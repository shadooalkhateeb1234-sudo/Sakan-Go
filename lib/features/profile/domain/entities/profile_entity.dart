import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable
{
  final String? firstName;
  final String? lastName;
  final DateTime? birthDate;
  final String? personalImage;
  final String? idImage;

  const ProfileEntity({this.firstName, this.lastName, this.birthDate, this.personalImage, this.idImage});

  ProfileEntity copyWith({String? firstName, String? lastName, DateTime? birthDate, String? personalImage, String? idImage})
  {
    return ProfileEntity(firstName: firstName ?? this.firstName, lastName: lastName ?? this.lastName, birthDate: birthDate ?? this.birthDate, personalImage: personalImage ?? this.personalImage, idImage: idImage ?? this.idImage);
  }

  @override
  List<Object?> get props => [ firstName, lastName, birthDate, personalImage, idImage ];
}