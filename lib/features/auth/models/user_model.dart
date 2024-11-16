// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:process_automation_app/common/utils/typedefs.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  const UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.imageUrl,
  });

  factory UserModel.fromJson(Json json) => _$UserModelFromJson(json);

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? imageUrl;

  Json toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? imageUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $id, email: $email, firstName: $firstName, lastName: $lastName, imageUrl: $imageUrl)';
  }
}
