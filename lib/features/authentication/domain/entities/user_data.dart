import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  const UserData({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const UserData.empty()
      : this(
          id: "0",
          createdAt: "empty.createdAt",
          name: "empty.name",
          avatar: "empty.avatar",
        );

  @override
  List<Object?> get props => [id, createdAt, name, avatar];
}
