class Api {
  static const baseUrl = 'https://api.gtuadmin.lat';
  static const baseWs = 'ws://167.99.145.76/ws/tracking';

  static const _path = '/api';
  //Authentication
  static const authApi = '$_path/auth';
  static const login = '$authApi/login-passenger';

  static const register = '$authApi/register';
  static const resetPassword = '$authApi/reset-password-request';
  //Routes
  static const routeApi = '$_path/route-management';
  static const busRoute = '$routeApi/routes';
  static const stops = '$routeApi/stops';
  static const neighborhoods = '$routeApi/neighborhoods';

  //Tracking
  static const subcriptionsLocation = '/topic/tracking/drivers';

  //Assighment
  static const assignmentApi = '$_path/assign-driver';
  static const driverAssigments = '$assignmentApi/assignments';

  //User
  static const userApi = '$_path/user-management';
  static const updatePassword = '$userApi/passengers/{id}/password';
}
