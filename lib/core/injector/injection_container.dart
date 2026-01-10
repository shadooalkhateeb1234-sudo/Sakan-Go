import 'package:http/http.dart' as http;
import 'core/network/api_endpoints.dart';
import 'features/booking/data/data_sources/fake_booking_remote_data_source.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'features/booking/data/data_sources/booking_remote_data_source.dart';
import 'features/booking/data/repositories/booking_repository_impl.dart';
import 'features/booking/domain/use_cases/create_booking_usecase.dart';
import 'features/booking/domain/use_cases/reject_booking_usecase.dart';
import 'features/booking/domain/use_cases/update_booking_usecase.dart';
import 'features/booking/domain/use_cases/cancel_booking_usecase.dart';
import 'features/booking/domain/repositories/booking_repository.dart';
import 'features/booking/domain/use_cases/get_bookings_usecase.dart';
import 'features/booking/presentation/manager/booking_bloc.dart';
import 'core/network/network_info.dart';
import 'package:get_it/get_it.dart';


final di = GetIt.instance;

Future<void> init() async {

  di.registerLazySingleton<http.Client>(() => http.Client());


  di.registerLazySingleton<InternetConnectionChecker>(
        () => InternetConnectionChecker.createInstance(),
  );

  //! Core

  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: di()));

  //! Data source
  di.registerLazySingleton<BookingRemoteDataSource>(
        () => BookingRemoteDataSourceImpl(di()),
  );


  // sl.registerLazySingleton<BookingRemoteDataSource>(
  //     () => FakeBookingRemoteDataSource(),
  // );
  //! Repository
  di.registerLazySingleton<BookingRepository>(
        () => BookingRepositoryImpl(
      remote: di(),
      networkInfo: di(),
    ),
  );

  //! UseCases
  di.registerLazySingleton(() => CreateBookingUseCase(di()));
  di.registerLazySingleton(() => CancelBookingUseCase(di()));
  di.registerLazySingleton(() => GetUserBookingsUsecase(di()));
  di.registerLazySingleton(() => UpdateBookingUseCase(di()));
  di.registerLazySingleton(() => RejectBookingUseCase(di()));

  //! Bloc
  di.registerFactory(
        () => BookingBloc(
      createBooking: di(),
      cancelBooking: di(),
      getUserBookings: di(),
      updateBooking: di(),
      rejectBooking: di(),
    ),
  );
}




//..................
// import 'package:get_it/get_it.dart';
// import 'package:http/http.dart' as http;
//
// final sl = GetIt.instance;
//
// Future<void> init() async {
//   sl.registerLazySingleton(() => http.Client());
//   sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
//   sl.registerLazySingleton<BookingRemoteDataSource>(
//         () => BookingRemoteDataSourceImpl(sl()),
//   );
//   sl.registerLazySingleton(() => BookingRepositoryImpl(
//     remote: sl(),
//     networkInfo: sl(),
//   ));
//   sl.registerLazySingleton(() => CreateBookingUseCase(sl()));
//   sl.registerLazySingleton(() => CancelBookingUseCase(sl()));
//   sl.registerLazySingleton(() => GetUserBookingsUsecase(sl()));
//   sl.registerFactory(() => BookingBloc(
//     createBooking: sl(),
//     cancelBooking: sl(),
//     getUserBookings: sl(),
//   ));
// }
