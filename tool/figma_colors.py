import requests
import os

# ===== CONFIGURATION =====
FIGMA_TOKEN = "figd_X_J0tUC8fK7ISzujtsNZxUFY4BZcmI1bW7t0pcmI"
FILE_KEY = "Qa9Rpim4ZUJP6qVq0nEsaz"
PAGE_NODE_ID = "72-167"  # "Final Design" page
OUTPUT_FILE = 'assets/color/colors.xml'
# ==========================

headers = {
    "X-Figma-Token": FIGMA_TOKEN
}

def rgb_to_hex(r, g, b):
    """Convert Figma RGB (0–1) to 6-digit hex (no #)."""
    return "{:02X}{:02X}{:02X}".format(round(r * 255), round(g * 255), round(b * 255))

def parse_node(node, colors):
    """Recursively extract color fills."""
    if "fills" in node:
        for fill in node["fills"]:
            if fill.get("type") == "SOLID":
                color = fill["color"]
                hex_code = rgb_to_hex(color["r"], color["g"], color["b"])
                # Always 6 digits, prefixed with FF for full opacity
                modifyData = f'    <color name="c{hex_code}">#FF{hex_code}</color>'
                colors.add(modifyData)

    # Recurse into children
    for child in node.get("children", []):
        parse_node(child, colors)

def main():
    url = f"https://api.figma.com/v1/files/{FILE_KEY}/nodes?ids={PAGE_NODE_ID}"
    print(f"🎨 Fetching colors from Figma (page: {PAGE_NODE_ID})...")
    response = requests.get(url, headers=headers)

    if response.status_code != 200:
        print("❌ Failed to fetch Figma file:", response.text)
        return

    data = response.json()
    colors = set()
    # Extract from the specific page node (Figma returns ID with a colon in the body)
    node_key = PAGE_NODE_ID.replace('-', ':')
    page_data = data["nodes"][node_key]["document"]
    parse_node(page_data, colors)

    print(f"🔍 Found {len(colors)} unique colors in Figma file")

    # Read existing colors from file (if it exists)
    existing_colors = set()
    try:
        with open(OUTPUT_FILE, 'r') as f:
            for line in f:
                stripped = line.strip()
                if stripped.startswith('<color '):
                    existing_colors.add(stripped)
    except FileNotFoundError:
        pass

    # Merge: existing + new
    all_colors = existing_colors | {c.strip() for c in colors}

    # Auto create folder if missing
    os.makedirs(os.path.dirname(OUTPUT_FILE), exist_ok=True)

    # Write complete valid XML file
    new_count = len(all_colors) - len(existing_colors)
    with open(OUTPUT_FILE, 'w') as f:
        f.write('<?xml version="1.0" encoding="UTF-8"?>\n')
        f.write('<colors>\n')
        for color_line in sorted(all_colors):
            # Ensure proper indentation
            if not color_line.startswith('    '):
                color_line = f'    {color_line}'
            f.write(color_line + '\n')
        f.write('</colors>\n')

    if existing_colors:
        print(f"✅ Added {new_count} new colors (kept {len(existing_colors)} existing)")
    else:
        print(f"✅ Generated fresh with {len(all_colors)} colors")

    print(f"🎉 All Figma colors saved to: {OUTPUT_FILE}")
    print("📌 Next step: run 'fluttergen -c pubspec.yaml' to regenerate AppColors")

if __name__ == "__main__":
    main()
