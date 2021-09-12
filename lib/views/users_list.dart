import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:flutter_crud/widgets/user_tile.dart';
import 'package:provider/provider.dart';

class UsersList extends StatelessWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // modo 1 com generics
    // final usersProvider = Provider.of<Users>(context);

    // modo 2 tipando a variável
    final Users users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de usuários'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.USER_FORM),
            icon: Icon(Icons.add),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.USER_FORM),
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (BuildContext context, index) {
          return UserTile(user: users.byIndex(index));
        },
      ),
    );
  }
}
