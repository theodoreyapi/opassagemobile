class ApiUrls {
  ApiUrls._();

  // Change base URL
  static const bool change = false;

  // Base URL
  static const baseUrlProd = "http://candidat.aptiotalent.com/api";
  static const baseUrlTest = "http://opassage.sodalite-consulting.com/api";

  // Pour obtenir la bonne base URL
  static String get baseUrl => change ? baseUrlProd : baseUrlTest;

  // base des api
  static String get auth => "$baseUrl/auth";
  static String get users => "$baseUrl/users";
  static String get hotels => "$baseUrl/hotels";
  static String get reservations => "$baseUrl/reservations";
  static String get promos => "$baseUrl/promos";
  static String get favorites => "$baseUrl/favorites";
  static String get subscriptions => "$baseUrl/subscriptions";
  static String get notifications => "$baseUrl/notifications";
  static String get politique => "$baseUrl/politique";
  static String get reviews => "$baseUrl/reviews";

  // Authentification
  static String get postAuthLogin => "$auth/login";
  static String get postAuthRegister => "$auth/register";
  static String get postAuthRegisterOne => "$auth/register-one";
  static String get postAuthLogout => "$auth/logout";
  static String get postAuthUpdate => "$auth/update/";
  static String get postAuthForgot => "$auth/password/forgot";
  static String get postAuthReset => "$auth/password/reset";
  static String get postAuthVerifOtp => "$auth/password/otp";
  static String get postAuthResend => "$auth/resend/otp";

  // User profile
  static String get getUserProfile => "$users/profile/";
  static String get putUserUpdateProfile => "$users/profile/";
  static String get putUserChangePasswordProfile => "$users/password/";
  static String get deleteUserAccountProfile => "$users/account/";
  static String get putUserUpdateCodeProfile => "$users/code";
  static String get postUserCodeCheckProfile => "$users/code/check";

  // Hotel & Rooms
  static String get getHotelAll => hotels;
  static String get getHotelDetail => "$hotels/";
  static String get postHotelSearch => "$hotels/search";
  static String get postHotelCreate => hotels;
  static String get putHotelUpdate => "$hotels/";
  static String get deleteHotel => "$hotels/";
  static String get getHotelRoom => "$hotels/{hotel_id}/rooms";
  static String get getRoomDetail => "$hotels/rooms/";
  static String get getRoomAll => "$hotels/rooms";
  static String get postRoomCreate => "$hotels/rooms";
  static String get deleteRoom => "$hotels/rooms/";
  static String get putRoomUpdate => "$hotels/rooms/";
  static String get patchRoomAvailability => "$hotels/rooms/{id}/availability";

  // Reservations and Payments
  static String get postReservationCreate => reservations;
  static String get getReservation => "$reservations/";
  static String get postReservationSearch => "$reservations/search";
  static String get deleteReservation => "$reservations/";
  static String get getReservationRoomManager => "$reservations/";
  static String get patchReservationConfirmManager => "$reservations/{id}/confirm";
  static String get patchReservationCancelManager => "$reservations/{id}/cancel";
  static String get postReservationPaymentInitial => "$reservations/payments/initiate";
  static String get postReservationPaymentCallback => "$reservations/payments/callback";
  static String get getReservationPayment => "$reservations/payments/";

  // Promo Codes
  static String get getPromoCheck => "$promos/check/";

  // Favorites
  static String get getFavorite => "$favorites/";
  static String get postFavoriteCreate => favorites;
  static String get deleteFavorite => favorites;

  // Subscriptions
  static String get getSubscriptionsAll => subscriptions;
  static String get postSubscriptionsSubscribe => "$subscriptions/subscribe";
  static String get getSubscriptionsByUser => "$subscriptions/me/";
  static String get postSubscriptionsCancel => "$subscriptions/cancel";
  static String get postSubscriptionsInitial => "$subscriptions/payments/initiate";
  static String get postSubscriptionsCallback => "$subscriptions/payments/callback";
  static String get getSubscriptionsPayment => "$subscriptions/payments/history/";

  // Notifications
  static String get getNotificationUser => "$notifications/";
  static String get postNotificationMark => "$notifications/mark-as-read";
  static String get deleteNotification => "$notifications/mark-as-read";

  // Politiques
  static String get getMention => "$politique/mention";
  static String get getSecurity => "$politique/security";
  static String get getCondition => "$politique/condition";

  // Reviews
  static String get getReviews => "$reviews/hotel/";
  static String get postReviewsAdd => "$reviews/hotel/";
  static String get deleteReviews => "$reviews/hotel/";


}
