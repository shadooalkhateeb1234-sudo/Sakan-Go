abstract class ProfileEvent {}

class FirstNameChanged extends ProfileEvent
{
  final String value;
  FirstNameChanged(this.value);
}

class LastNameChanged extends ProfileEvent
{
  final String value;
  LastNameChanged(this.value);
}

class BirthDateChanged extends ProfileEvent
{
  final DateTime value;
  BirthDateChanged(this.value);
}

class PersonalImageChanged extends ProfileEvent
{
  final String path;
  PersonalImageChanged(this.path);
}

class IdImageChanged extends ProfileEvent
{
  final String path;
  IdImageChanged(this.path);
}

class ShowProfilePressed extends ProfileEvent {}
class SubmitProfilePressed extends ProfileEvent {}
class UpdateProfilePressed extends ProfileEvent {}