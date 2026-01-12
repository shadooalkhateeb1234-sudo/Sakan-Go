import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure() : super('Server Failure');
}

class OfflineFailure extends Failure {
  const OfflineFailure() : super('No Internet Connection');
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('No Internet Connection');
}

class CacheFailure extends Failure {
  const CacheFailure() : super('Cache Failure');
}

class EmptyFailure extends Failure {
  EmptyFailure():super('Empty Failure');
}


class EmptyCacheFailure extends Failure {
  EmptyCacheFailure():super('Empty Cache Failure');

}

class WrongDataFailure extends Failure {
  WrongDataFailure():super('Wrong Data Failure');

}

class AuthenticationFailure extends Failure {
  AuthenticationFailure():super('Authentication Failure');

}

class BookingFailure extends Failure{
  BookingFailure():super('Booking Failure');

}

class ApartmentFailure extends Failure{
  ApartmentFailure():super('Apartment Failure');

}

class UserFailure extends Failure{
  UserFailure():super('User Failure');

}
 
class NotFoundFailure extends Failure {
  NotFoundFailure() : super('Not Found Failure');
}

class ConflictFailure extends Failure {
  ConflictFailure() : super('Conflict Failure');
}

 class UnAuthorizedFailure extends Failure {
  UnAuthorizedFailure():super('UnAuthorized Failure');
}
class ForbiddenFailure extends Failure {
  ForbiddenFailure() : super('Forbidden Failure');
}

class GoneFailure extends Failure {
  GoneFailure() : super('Gone Failure');
}
class UnprocessableEntityFailure extends Failure {
  UnprocessableEntityFailure() : super('Unprocessable Entity Failure');
}
class TooManyRequestFailure extends Failure {
  TooManyRequestFailure() : super( 'Too Many Request Failure');
}
 class UnexpectedFailure extends Failure {
  UnexpectedFailure() : super( 'Unexpected Failure');

}