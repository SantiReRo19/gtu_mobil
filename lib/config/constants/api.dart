class Api {
  static const baseUrl = 'https://api.gtuadmin.lat';

  static const _path = '/api';

  static const authApi = '$_path/auth';
  static const login = '$authApi/login-passenger';
  static const register = '$authApi/register';
  static const resetPassword = '$authApi/reset-password';
}
