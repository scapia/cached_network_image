/// Global configuration for `cached_network_image`.
///
/// This singleton provides runtime toggles for platform specific workarounds
/// and tuning parameters such as the iOS image decode semaphore limit.
class CachedNetworkImageConfig {
  CachedNetworkImageConfig._();

  /// Shared singleton instance.
  static final CachedNetworkImageConfig instance = CachedNetworkImageConfig._();

  bool _enableIOSDecodeSemaphore = false;
  int _iosDecodeSemaphoreLimit = 10;

  /// Whether to run iOS frame decoding through a semaphore to avoid GPU
  /// saturation. Enabled by default to preserve current behaviour.
  bool get enableIOSDecodeSemaphore => _enableIOSDecodeSemaphore;

  set enableIOSDecodeSemaphore(bool value) {
    _enableIOSDecodeSemaphore = value;
  }

  /// Maximum number of concurrent iOS frame decode tasks allowed when the
  /// semaphore is enabled. Defaults to 10.
  int get iosDecodeSemaphoreLimit => _iosDecodeSemaphoreLimit;

  set iosDecodeSemaphoreLimit(int value) {
    if (value <= 0) {
      throw ArgumentError.value(
        value,
        'value',
        'iosDecodeSemaphoreLimit must be greater than 0.',
      );
    }
    _iosDecodeSemaphoreLimit = value;
  }

  /// Convenience method to update multiple settings in one call.
  void update({
    bool? enableIOSDecodeSemaphore,
    int? iosDecodeSemaphoreLimit,
  }) {
    if (enableIOSDecodeSemaphore != null) {
      this.enableIOSDecodeSemaphore = enableIOSDecodeSemaphore;
    }
    if (iosDecodeSemaphoreLimit != null) {
      this.iosDecodeSemaphoreLimit = iosDecodeSemaphoreLimit;
    }
  }
}
