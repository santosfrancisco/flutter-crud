import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile({Key? key, required this.user});

  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);
    final avatar = user.avatarUrl.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: user,
                );
              },
              icon: Icon(
                Icons.edit,
                color: Colors.blue[300],
              ),
            ),
            IconButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text('Atenção!'),
                        content: Text('Deseja mesmo remover este usuário?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              users.remove(user.id!);
                              Navigator.pop(context, 'Sim');
                            },
                            child: Text('Sim'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Não'),
                            child: Text('Não'),
                          ),
                        ],
                      )),
              icon: Icon(
                Icons.delete,
                color: Colors.red[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
