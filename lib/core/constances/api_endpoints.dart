class ApiEndpoints {
  static const String baseUrl = 'https://api.escuelajs.co/api/v1';

  // Auth
  static const String login = '/auth/login';
  static const String profile = '/auth/profile';
  static const String refreshToken = '/auth/refresh-token';

  // Users
  static const String users = '/users';
  static const String checkEmail = '/users/is-available';

  // Products
  static const String products = '/products';

  // Categories
  static const String categories = '/categories';
}
