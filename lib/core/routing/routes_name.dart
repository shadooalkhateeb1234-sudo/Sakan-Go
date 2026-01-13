class RouteName {
 // static const String base_url = "http://127.0.0.1:8000/api/booking";
  //intro
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String phoneNumber = '/phone_number';
  static const String otpVerification = '/otp_verification';
  static const String completeProfile = '/profile';
  static const String approval = '/approval';
  static const String home = '/home';

  //booking
  static const bookings = '/bookings';
  static const createBooking = '/bookings/create';
  static const updateBooking = '/bookings/edit';
  static const Bookingdetail = '/bookings/details';
  static const Bookingcancel = '/bookings/cancel/:id';
  static const Ownerbookings  = '/owner/bookings';
  //review(rating)
  static const createReview='/createReview/:bookingId/:apartmentId';


}