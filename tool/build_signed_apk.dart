/// Generic Flutter APK signing automation script.
///
/// Drop this into any Flutter project's `tool/` folder and run:
///
///   dart run tool/build_signed_apk.dart           # Full setup + signed release build
///   dart run tool/build_signed_apk.dart --debug   # Also build debug APK
///   dart run tool/build_signed_apk.dart --bundle  # Build App Bundle instead of APK
///   dart run tool/build_signed_apk.dart --sha     # Just print SHA1/SHA256 of existing keystore
///
/// What it does (idempotent — safe to run multiple times):
///   1. Generates upload-keystore.jks if missing   (android/app/)
///   2. Creates key.properties                     (android/)
///   3. Patches build.gradle.kts for signing       (android/app/)
///   4. Updates .gitignore so keystore & props are pushable
///   5. Builds signed APK (release, optionally debug)
///   6. Prints SHA1 & SHA256 fingerprints
/// Works on macOS, Linux, and Windows.
library;

import 'dart:io';

final bool _isWindows = Platform.isWindows;

// ── Configuration (edit these if needed) ─────────────────────────────────────

const String keyAlias = 'upload';
const String storePassword = '12345678';
const String keyPassword = '12345678';
const String keystoreFilename = 'upload-keystore.jks';
const String dname =
    'CN=Unknown, OU=Unknown, O=Unknown, L=Unknown, ST=Unknown, C=US';

// ── Derived Paths ────────────────────────────────────────────────────────────

final String root = _findProjectRoot();
final String keystorePath = _join([root, 'android', 'app', keystoreFilename]);
final String keyPropertiesPath = _join([root, 'android', 'key.properties']);
final String gradlePath = _join([root, 'android', 'app', 'build.gradle.kts']);
final String gitignorePath = _join([root, 'android', '.gitignore']);

// ── Main ─────────────────────────────────────────────────────────────────────

Future<void> main(List<String> args) async {
  final shaOnly = args.contains('--sha');
  final buildDebug = args.contains('--debug');
  final buildBundle = args.contains('--bundle');

  _header('Flutter Signed Build Automation');

  if (shaOnly) {
    await _printFingerprints();
    return;
  }

  // Step 1 — Keystore
  await _ensureKeystore();

  // Step 2 — key.properties
  _ensureKeyProperties();

  // Step 3 — Patch build.gradle.kts
  _patchGradle();

  // Step 4 — Update .gitignore
  _patchGitignore();

  // Step 5 — Build
  _header('Building');
  await _flutter(['build', 'apk', '--release']);
  _log('✓ Release APK built');

  if (buildDebug) {
    await _flutter(['build', 'apk', '--debug']);
    _log('✓ Debug APK built');
  }

  if (buildBundle) {
    await _flutter(['build', 'appbundle', '--release']);
    _log('✓ Release App Bundle built');
  }

  // Step 6 — Fingerprints
  await _printFingerprints();

  _header('Done');
}

// ═════════════════════════════════════════════════════════════════════════════
// STEP 1 — KEYSTORE
// ═════════════════════════════════════════════════════════════════════════════

Future<void> _ensureKeystore() async {
  if (File(keystorePath).existsSync()) {
    _log('✓ Keystore exists: $keystorePath');
    return;
  }

  _log('🔑 Generating keystore...');
  final r = await Process.run(_cmd('keytool'), [
    '-genkey',
    '-v',
    '-keystore',
    keystorePath,
    '-keyalg',
    'RSA',
    '-keysize',
    '2048',
    '-validity',
    '10000',
    '-alias',
    keyAlias,
    '-storepass',
    storePassword,
    '-keypass',
    keyPassword,
    '-dname',
    dname,
  ]);
  if (r.exitCode != 0) _die('keytool failed:\n${r.stderr}');
  _log('✓ Keystore generated: $keystorePath');
}

// ═════════════════════════════════════════════════════════════════════════════
// STEP 2 — KEY.PROPERTIES
// ═════════════════════════════════════════════════════════════════════════════

void _ensureKeyProperties() {
  const content = 'storePassword=$storePassword\n'
      'keyPassword=$keyPassword\n'
      'keyAlias=$keyAlias\n'
      'storeFile=$keystoreFilename\n';

  File(keyPropertiesPath).writeAsStringSync(content);
  _log('✓ key.properties written');
}

// ═════════════════════════════════════════════════════════════════════════════
// STEP 3 — PATCH build.gradle.kts FOR SIGNING
// ═════════════════════════════════════════════════════════════════════════════

void _patchGradle() {
  final file = File(gradlePath);
  if (!file.existsSync()) {
    _log('⚠️  $gradlePath not found — skipping gradle patch');
    return;
  }

  var content = file.readAsStringSync();

  // Already patched?
  if (content.contains('keystoreProperties')) {
    _log('✓ build.gradle.kts already configured for signing');
    return;
  }

  _log('🔧 Patching build.gradle.kts...');

  // 1. Add imports + keystoreProperties loading BEFORE the plugins block
  const importsBlock = '''import java.util.Properties
import java.io.FileInputStream

''';
  if (!content.contains('import java.util.Properties')) {
    content = importsBlock + content;
  }

  // 2. Inject keystoreProperties loading after plugins { ... }
  final pluginsEnd = content.indexOf('}', content.indexOf('plugins'));
  if (pluginsEnd == -1) {
    _log('⚠️  Could not find plugins block — skipping gradle patch');
    return;
  }
  final insertPos = pluginsEnd + 1;
  const propsBlock = '''

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}
''';
  content = content.substring(0, insertPos) +
      propsBlock +
      content.substring(insertPos);

  // 3. Inject signingConfigs block inside android { ... } before defaultConfig
  final defaultConfigIndex = content.indexOf('defaultConfig');
  if (defaultConfigIndex != -1) {
    const signingBlock = '''
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String
        }
    }

    ''';
    content = content.substring(0, defaultConfigIndex) +
        signingBlock +
        content.substring(defaultConfigIndex);
  }

  // 4. Replace release signing from debug to release config
  content = content.replaceAll(
    'signingConfig = signingConfigs.getByName("debug")',
    'signingConfig = signingConfigs.getByName("release")',
  );

  file.writeAsStringSync(content);
  _log('✓ build.gradle.kts patched for release signing');
}

// ═════════════════════════════════════════════════════════════════════════════
// STEP 4 — UPDATE .GITIGNORE (ALLOW KEYSTORE + KEY.PROPERTIES)
// ═════════════════════════════════════════════════════════════════════════════

void _patchGitignore() {
  final file = File(gitignorePath);
  if (!file.existsSync()) {
    _log('✓ No android/.gitignore to patch');
    return;
  }

  final lines = file.readAsLinesSync();
  final patternsToRemove = ['key.properties', '**/*.keystore', '**/*.jks'];
  var changed = false;

  final updated = lines.where((line) {
    final trimmed = line.trim();
    if (patternsToRemove.contains(trimmed)) {
      changed = true;
      return false;
    }
    // Also remove the comment lines right above them
    if (trimmed == '# Remember to never publicly share your keystore.' ||
        trimmed == '# See https://flutter.dev/to/reference-keystore') {
      changed = true;
      return false;
    }
    return true;
  }).toList();

  if (changed) {
    // Remove trailing blank lines
    while (updated.isNotEmpty && updated.last.trim().isEmpty) {
      updated.removeLast();
    }
    file.writeAsStringSync('${updated.join('\n')}\n');
    _log('✓ .gitignore updated (keystore & key.properties allowed)');
  } else {
    _log('✓ .gitignore already allows keystore files');
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// STEP 6 — PRINT SHA1 / SHA256 FINGERPRINTS
// ═════════════════════════════════════════════════════════════════════════════

Future<void> _printFingerprints() async {
  _header('Signing Fingerprints');

  if (!File(keystorePath).existsSync()) {
    _log('⚠️  Keystore not found at $keystorePath');
    return;
  }

  // Release key fingerprints
  _log('📋 Release key ($keyAlias):');
  final releaseResult = await Process.run(_cmd('keytool'), [
    '-list',
    '-v',
    '-keystore',
    keystorePath,
    '-alias',
    keyAlias,
    '-storepass',
    storePassword,
  ]);

  if (releaseResult.exitCode == 0) {
    final output = releaseResult.stdout.toString();
    _printCertFingerprints(output);
  } else {
    _error('Failed to read release key: ${releaseResult.stderr}');
  }

  // Debug key fingerprints
  final debugKeystore = _findDebugKeystore();
  if (debugKeystore != null) {
    _log('\n📋 Debug key (androiddebugkey):');
    final debugResult = await Process.run(_cmd('keytool'), [
      '-list',
      '-v',
      '-keystore',
      debugKeystore,
      '-alias',
      'androiddebugkey',
      '-storepass',
      'android',
    ]);

    if (debugResult.exitCode == 0) {
      _printCertFingerprints(debugResult.stdout.toString());
    } else {
      _log('   Could not read debug keystore');
    }
  }
}

void _printCertFingerprints(String keytoolOutput) {
  for (final line in keytoolOutput.split('\n')) {
    final trimmed = line.trim();
    if (trimmed.startsWith('SHA1:') || trimmed.startsWith('SHA256:')) {
      _log('   $trimmed');
    }
  }
}

String? _findDebugKeystore() {
  final home =
      Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'] ?? '';
  final paths = [
    _join([home, '.android', 'debug.keystore']),
  ];
  for (final p in paths) {
    if (p.isNotEmpty && File(p).existsSync()) return p;
  }
  return null;
}

// ═════════════════════════════════════════════════════════════════════════════
// HELPERS
// ═════════════════════════════════════════════════════════════════════════════

Future<void> _flutter(List<String> args) async {
  final p = await Process.start(_cmd('flutter'), args,
      workingDirectory: root, mode: ProcessStartMode.inheritStdio);
  final code = await p.exitCode;
  if (code != 0) _die('flutter ${args.join(' ')} failed (exit $code)');
}

String _findProjectRoot() {
  var dir = Directory.current;
  while (true) {
    if (File(_join([dir.path, 'pubspec.yaml'])).existsSync()) return dir.path;
    final parent = dir.parent;
    if (parent.path == dir.path) return Directory.current.path;
    dir = parent;
  }
}

/// Returns the platform-correct executable name.
/// On Windows, `flutter` → `flutter.bat`, `keytool` → `keytool.exe` etc.
String _cmd(String name) {
  if (!_isWindows) return name;
  // flutter & dart ship as .bat on Windows
  if (name == 'flutter' || name == 'dart') return '$name.bat';
  return name;
}

/// Joins path segments with the platform separator.
String _join(List<String> parts) => parts.join(Platform.pathSeparator);

void _header(String t) {
  final l = '═' * (t.length + 4);
  stdout.writeln('\n$l\n  $t\n$l\n');
}

void _log(String m) => stdout.writeln(m);
void _error(String m) => stderr.writeln('❌ $m');
void _die(String m) {
  _error(m);
  exit(1);
}
