class RefreshTokenModel
{
  final String token;
  final int expiresIn;

  RefreshTokenModel({required this.token, required this.expiresIn});

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json)
  {
    return RefreshTokenModel
    (
      token: json['access_token'] as String,
      expiresIn: (json['expires_in'] as num).toInt()
    );
  }
}