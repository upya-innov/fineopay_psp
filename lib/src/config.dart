enum FineoEnvironment { sandbox, live }

class FineoConfig {
  final FineoEnvironment environment;

  /// Base URL (sans trailing slash)
  /// Exemple: https://psp-api.fineopay.com/api/v1
  final String baseUrl;

  const FineoConfig._(this.environment, this.baseUrl);

  factory FineoConfig.sandbox({String? baseUrl}) {
    return FineoConfig._(
      FineoEnvironment.sandbox,
      baseUrl ?? 'https://psp-api.fineopay.com/api/v1',
    );
  }

  factory FineoConfig.live({String? baseUrl}) {
    return FineoConfig._(
      FineoEnvironment.live,
      baseUrl ?? 'https://psp-api.fineopay.com/api/v1',
    );
  }
}
