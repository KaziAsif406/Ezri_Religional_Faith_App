import json
import requests
import re
import os

# --- Dart textStyle template ---
STYLE_TEMPLATE = '''  static final textStyle{size}c{color}{fontName}{fontWeight} = TextStyle(
    fontFamily: "{font}",
    fontFamilyFallback: const ['DMSans', 'Open Sans', 'Roboto', 'Noto Sans'],
    color: AppColors.c{color},
    fontSize: {size}.sp,
    fontWeight: FontWeight.w{fontWeight},
  );'''

# --- Dart file header ---
FILE_HEADER = """import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../gen/colors.gen.dart';

class TextFontStyle {
  TextFontStyle._();
"""

FILE_FOOTER = "}\n"

# --- Figma API settings ---
FIGMA_TOKEN = "figd_X_J0tUC8fK7ISzujtsNZxUFY4BZcmI1bW7t0pcmI"
FILE_KEY = "Qa9Rpim4ZUJP6qVq0nEsaz"
PAGE_NODE_ID = "72-167"  # "Final Design" page
OUTPUT_PATH = "lib/constants/text_font_style.dart"


headers = {
    "X-Figma-Token": FIGMA_TOKEN
}

# --- Fetch Figma nodes ---
def fetch_figma_nodes():
    url = f"https://api.figma.com/v1/files/{FILE_KEY}/nodes?ids={PAGE_NODE_ID}"
    print(f"🔤 Fetching text styles from Figma (page: {PAGE_NODE_ID})...")
    response = requests.get(url, headers=headers)
    if response.status_code != 200:
        print("❌ Failed to fetch Figma nodes:", response.text)
        return {}
    print("✅ Successfully fetched Figma file data.")
    data = response.json()
    # Return a structure with 'document' key pointing to the specific page
    node_key = PAGE_NODE_ID.replace('-', ':')
    return {"document": data["nodes"][node_key]["document"]}

# --- Convert RGBA to hex (no #) ---
def rgba_to_hex(rgba):
    r = round(rgba['r'] * 255)
    g = round(rgba['g'] * 255)
    b = round(rgba['b'] * 255)
    return f"{r:02X}{g:02X}{b:02X}"

# --- Parse text style ---
def parse_text_style(node):
    try:
        style = node['style']
        fontFamily = style.get('fontFamily', 'DMSans')
        fontWeight = style.get('fontWeight', 400)
        fontSize = int(style.get('fontSize', 14))
        fills = node.get('fills', [])
        color = "000000"
        if fills:
            solid_fill = next((f for f in fills if f['type'] == "SOLID"), None)
            if solid_fill:
                color = rgba_to_hex(solid_fill['color'])
        return fontFamily, fontWeight, fontSize, color
    except Exception as e:
        print(f"⚠️ Error parsing node: {e}")
        return "DMSans", 400, 14, "000000"

# --- Extract existing manual styles from file ---
def read_existing_styles():
    """Read existing text styles that were manually added (not from Figma)."""
    existing = []
    try:
        with open(OUTPUT_PATH, 'r') as f:
            content = f.read()
            # Extract all static final lines (full style blocks)
            pattern = r'(  static final \w+ = TextStyle\([^;]+\);)'
            matches = re.findall(pattern, content, re.DOTALL)
            for match in matches:
                existing.append(match)
    except FileNotFoundError:
        pass
    return existing

# --- Generate Dart styles from Figma nodes ---
def generate_dart_from_nodes(nodes):
    dart_lines = []
    unique_names = set()

    def traverse(node):
        if 'children' in node:
            for child in node['children']:
                traverse(child)
        if node.get('type') == "TEXT":
            fontFamily, fontWeight, fontSize, color = parse_text_style(node)
            fontName = re.sub(r'\W+', '', fontFamily)
            style_name = f"textStyle{fontSize}c{color}{fontName}{fontWeight}"

            if style_name not in unique_names:
                unique_names.add(style_name)
                line = STYLE_TEMPLATE.format(
                    size=fontSize,
                    color=color,
                    fontName=fontName,
                    fontWeight=fontWeight,
                    font=fontFamily
                )
                dart_lines.append(line)

    traverse(nodes['document'])

    # Sort by font size, then alphabetically
    dart_lines.sort(key=lambda l: (int(re.search(r"textStyle(\d+)", l).group(1)), l))
    return dart_lines

# --- Main execution ---
if __name__ == "__main__":
    figma_nodes = fetch_figma_nodes()
    if not figma_nodes:
        exit(1)

    dart_lines = generate_dart_from_nodes(figma_nodes)

    print(f"🔍 Found {len(dart_lines)} unique text styles in Figma file")

    # Auto create folder if missing
    os.makedirs(os.path.dirname(OUTPUT_PATH), exist_ok=True)

    # Write complete valid Dart file
    with open(OUTPUT_PATH, "w") as f:
        f.write(FILE_HEADER)
        f.write("\n")
        for line in dart_lines:
            f.write(line + "\n\n")
            # Extract style name for logging
            name_match = re.search(r"static final (\w+)", line)
            if name_match:
                print(f"  ✅ {name_match.group(1)}")
        f.write(FILE_FOOTER)

    print(f"\n🎉 Generated {len(dart_lines)} text styles at: {OUTPUT_PATH}")
    print("📌 Next step: run 'fluttergen -c pubspec.yaml' if you added new colors")
