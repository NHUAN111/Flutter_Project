class AppUrl {
  static var baseUrl = 'http://192.168.1.7/DACN-Web/';

  static var loginUrl = '${baseUrl}api/web/login';
  static var registerUrl = '${baseUrl}api/web/register';

  // Category
  static var categoriesUrl = '${baseUrl}api/web/category';
  static var slidersUrl = '${baseUrl}api/web/slider';

  // Food
  static var foodBestSellerUrl = '${baseUrl}api/web/food_bestseller';
  static var foodNewUrl = '${baseUrl}api/web/food_new';
  static var foodDiscountUrl = '${baseUrl}api/web/food_discount';
  static var foodAllUrl = '${baseUrl}api/web/food';
  static var foodDetailUrl = '${baseUrl}api/web/food_detail';
  static var foodSameCategoryUrl = '${baseUrl}api/web/same_food';

  // Coupon
  static var coupons = '${baseUrl}api/web/coupon';

  // Order
  static var infoOrders = '${baseUrl}api/web/info_orders';
  static var cancelOrder = '${baseUrl}api/web/cancel_order';
  static var orderDetail = '${baseUrl}api/web/detail_order';
  static var order = '${baseUrl}api/web/order_detail'; // Dat hang

  // Feeship
  static var cityAddress = '${baseUrl}api/web/city';
  static var pronviceAddress = '${baseUrl}api/web/pronvice';
  static var wardAddress = '${baseUrl}api/web/ward';
  static var shippingFee = '${baseUrl}api/web/shipping_fee';
}
