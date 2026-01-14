
class ApiEndpoints {

  static const  baseUrl = 'https://erethismic-britta-forebearingly.ngrok-free.dev/';

  //booking
  static const  booking ='${baseUrl}api/booking';
  static const  showUserBookings ='${booking}/showUserBookings';
  static const  bookAnApartment ='${booking}/bookAnApartment';
  static const  cancelAbook ='${booking}/cancelAbook'; //user
  static const  rejectAbook ='${booking}/rejectAbook'; //owner
  static const approveAbooke='${booking}/approveAbooke'; //owner
  static const  showAbook ='${booking}/showAbook';//{booking_id}


  //rating
  static const  review ='${booking}/review/createReview';
  static const  apartmentAverageRating ='${booking}/review/apartmentAverageRating';//{apartment_id}

  //update_booking
  static const  updateBooking= '${booking}/updateBooking';//{booking_id}
  //static const  requestupdateBooking= '${booking}/updateBooking';
  static const  showUserBookingUpdateRequests = '${booking}/showUserBookingUpdateRequests';
  static const  showBookingUpdateRequest = '${booking}/showBookingUpdateRequest';//{booking_update_request_id}
  static const  cancelBookingUpdateRequest = '${booking}/cancelBookingUpdateRequest';//{booking_update_request_id}

  //owner_booking{reject,approve}&&Update
  static const rejectBookingUpdateRequest='${booking}/rejectBookingUpdateRequest';
  static const approveBookingUpdateRequest='${booking}/approveBookingUpdateRequest';
  static const OwnerBookingUpdateRequests='${booking}/OwnerBookingUpdateRequests';
  static const OwnerBookingRequests='${booking}/OwnerBookingRequests';

   // apartment
  static const apartment = '${baseUrl}api/apartment/';

  // user
  static const user = '${baseUrl}api/user/';
  // admin_approval feature
  static const adminApproval = "${user}admin-approval-status";
  // admin_upgrade feature
  static const checkAdminUpgrade = "${user}check-upgrade-status";
  static const requestAdminUpgrade = "${user}upgrade";
  // auth feature
  static const sendPhoneOtp = "${user}send-phone-otp";
  static const resendPhoneOtp = "${user}resend-phone-otp";
  static const verifyPhoneOtp = "${user}verify-phone-otp";
  static const refreshToken = "${user}refresh-token";
  static const logout = "${user}logout";
  // profile feature
  static const submitProfile = "${user}submit-profile";
  static const  updateProfile = "${user}update-profile";
  static const showProfile = "${user}show-profile";

}
