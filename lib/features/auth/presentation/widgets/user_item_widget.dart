import 'package:flutter/material.dart';

import '../../domain/entities/user_data.dart';

class UserItemWidget extends StatelessWidget {
  const UserItemWidget({
    super.key,
    required this.user,
  });

  final UserData user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(user.avatar),
        ),
        title: Text(user.name),
      ),
    );
  }
}
