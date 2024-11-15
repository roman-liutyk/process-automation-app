import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:process_automation_app/common/utils/typedefs.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel {
  const UserModel({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.imageUrl,
  });

  factory UserModel.fromJson(Json json) => _$UserModelFromJson(json);

  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String? imageUrl;

  Json toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? uid,
    String? email,
    String? firstName,
    String? lastName,
    String? imageUrl,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
