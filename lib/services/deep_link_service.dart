class DeepLinkService {
  static final Map<String, String> _routeMap = {
    'dashboard': '/dashboard',
    'login': '/login',
    'register': '/register',
    'leaderboard': '/leaderboard',
    'challenges': '/challenges',
    'heritage': '/heritage',
    'calendar': '/calendar',
    'map': '/zimbabwe-map',
    'national-dashboard': '/national-dashboard',
    'ministry-dashboard': '/ministry-dashboard',
  };

  static String? resolveRoute(String path) {
    final segments = path.split('/').where((s) => s.isNotEmpty).toList();
    if (segments.isEmpty) return null;
    final route = _routeMap[segments.first];
    if (route == null) return null;
    return route;
  }

  static Map<String, String> parseQueryParams(String? query) {
    if (query == null || query.isEmpty) return {};
    final params = <String, String>{};
    for (final param in query.split('&')) {
      final parts = param.split('=');
      if (parts.length == 2) {
        params[Uri.decodeComponent(parts[0].replaceAll('+', ' '))] = Uri.decodeComponent(parts[1].replaceAll('+', ' '));
      }
    }
    return params;
  }
}
