import '../../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity
{
  const ProfileModel({super.firstName, super.lastName, super.birthDate, super.personalImage, super.idImage});

  factory ProfileModel.fromJson(Map<String, dynamic> json)
  {
    return ProfileModel
    (
      firstName: json['first_name'],
      lastName: json['last_name'],
      birthDate: DateTime.parse(json['birth_date']),
      personalImage: json['personal_image'],
      idImage: json['id_image'],
    );
  }
}