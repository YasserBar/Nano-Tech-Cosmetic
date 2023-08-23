class AppRoutes {
  static const baseUrl = 'http://192.168.43.93:8000/mobile/';

  //Auth
  static const registerUser = 'registerUser';
  static const registerSalon = 'registerSalon';
  static const registerCompany = 'registerCompany';
  static const verifyOtp = 'verifyOtp';
  static const resendotp = 'resendotp';
  static const resetPassword = 'resetPassword';
  static const login = 'login';
  static const logout = 'logout';
  static const refreshToken = 'refreshToken';

  //Ads
  static const displayAds = 'displayAds';

  //Categories
  static const showAllCategory = 'showAllCategory';

  //Products
  static const showAllProduct = 'showAllProduct';
  static const rateProduct = 'rateProduct';

  //Offers
  static const showOffers = 'showOffers';
  static const showOfferByProduct = 'showOfferByProduct';

  //Orders
  static const storeOrder = 'storeOrder';
  static const displayOrder = 'DisplayOrder';
  static const displayOrderDetails = 'getOrderDetails';

  //Orders Salon
  static const addOrderName = 'addOrderName';
  static const displayOrderName = 'DisplayOrderName';

  //Orders Salon
  static const addOrderManufacturing = 'addOrderManufacture';
  static const displayOrderManufacturing = 'DisplayOrderManufacture';
}
