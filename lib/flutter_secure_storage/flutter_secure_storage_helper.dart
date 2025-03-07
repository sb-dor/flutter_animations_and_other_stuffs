import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static SecureStorageHelper? _internal;

  static SecureStorageHelper get internal =>
      _internal ??= SecureStorageHelper._();

  SecureStorageHelper._();

  // not usable now
  late final FlutterSecureStorage _storage;

  Future<void> init() async {
    const androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
      keyCipherAlgorithm:
          KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
    );
    const iosOptions = IOSOptions(
      accessibility:
          KeychainAccessibility.first_unlock, // When the data is accessible
      synchronizable: true, // Sync data with iCloud
    );

    /// * If `useBackwardCompatibility` is set to `true`, trying to read from values
    ///   which were written by previous versions. In addition, when reading or
    ///   writing from previpus version's storage, read values will be migrated to
    ///   new storage automatically. This may introduces some performance hit and
    ///   might cause error for some kinds of keys.
    ///   Default is `false`.
    ///   You must set this value to `false` if you could use:
    ///   * Keys containing `"`, `<`, `>`, `|`, `:`, `*`, `?`, `/`, `\`,
    ///     or any of ASCII control charactors.
    ///   * Keys containing `/../`, `\..\`, or their combinations.
    ///   * Long key string (precise size is depends on your app's product name,
    ///     company name, and account name who executes your app).
    ///
    /// You can migrate all old data with this options as following:
    /// ```dart
    /// await FlutterSecureStorage().readAll(
    ///     const WindowsOptions(useBackwardCompatibility: true),
    /// );
    /// ```
    const windowsOptions = WindowsOptions(
      useBackwardCompatibility:
          true, // Stores data in a protected folder within the user's directory
    );

    const macosOptions = MacOsOptions(
      accessibility:
          KeychainAccessibility.first_unlock, // Matches iOS accessibility
      synchronizable: true, // Sync with iCloud if needed
    );

    // it automatically will be set even if you don't set the value
    const linuxOptions = LinuxOptions();

    // it automatically will be set even if you don't set the value
    const webOptions = WebOptions();

    _storage = const FlutterSecureStorage(
      aOptions: androidOptions,
      iOptions: iosOptions,
      mOptions: macosOptions,
      wOptions: windowsOptions,
      lOptions: linuxOptions,
      webOptions: webOptions,
    );
  }

  Future<void> setValueByKey(
      {required String key, required dynamic value}) async {
    if (value == null) return;
    await _storage.write(key: key, value: value.toString());
  }

  //
  //
  Future<String?> getStringByKey({required String key}) async {
    return _storage.read(key: key);
  }

  Future<int?> getIntByKey({required String key}) async {
    return int.tryParse("${await _storage.read(key: key)}");
  }

  Future<double?> getDoubleByKey({required String key}) async {
    return double.tryParse("${await _storage.read(key: key)}");
  }

  Future<bool?> getBoolByKey({required String key}) async {
    return bool.tryParse("${await _storage.read(key: key)}");
  }
}
