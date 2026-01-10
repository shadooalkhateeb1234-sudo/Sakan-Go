abstract class HttpStatusCodes
{
  // Success
  static const int ok = 200;
  static const int created = 201;
  static const int noContent = 204;

  // Client errors
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int conflict = 409;
  static const int gone = 410;
  static const int unprocessableEntity = 422;
  static const int tooManyRequest = 429;

  // Server errors
  static const int internalServerError = 500;
  static const int badGateway = 502;
  static const int serviceUnavailable = 503;
}
