import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel{
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? password;
  @HiveField(3)
  final String? address;
  @HiveField(4)
  final String? age;

  UserModel({this.name, this.email, this.password, this.address, this.age});
}