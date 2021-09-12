import 'package:flutter/material.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:flutter_crud/views/user_form.dart';
import 'package:flutter_crud/views/users_list.dart';
import 'package:provider/provider.dart';
import 'provider/users.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => Users(),
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            AppRoutes.HOME: (ctx) => UsersList(),
            AppRoutes.USER_FORM: (ctx) => UserForm(),
          }),
    );
  }
}
