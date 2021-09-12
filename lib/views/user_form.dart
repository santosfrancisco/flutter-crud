import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(User? user) {
    if (user != null) {
      _formData['id'] = user.id!;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ModalRoute.of(context)?.settings.arguments as User?;
    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

    void handleSave() {
      if (_form.currentState!.validate()) {
        print('valid');
        _form.currentState!.save();
        print(_formData);
        users.put(
          User(
            id: _formData['id'],
            name: _formData['name']!,
            email: _formData['email']!,
            avatarUrl: _formData['avatarUrl'] ?? "",
          ),
        );
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de usuários'),
        actions: [
          IconButton(
            onPressed: () {
              handleSave();
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          handleSave();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                initialValue: _formData['name'],
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (name) {
                  print(name == "");
                  if (name!.trim().isEmpty) {
                    return 'Nome é obrigatório.';
                  }
                  if (name.trim().length < 4) {
                    return 'Nome deve ter pelo menos 5 caracteres';
                  }
                },
                onSaved: (value) => _formData['name'] = value!,
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: InputDecoration(labelText: 'Email'),
                validator: (email) {
                  if (email!.trim().isEmpty) {
                    return 'Email é obrigatório.';
                  }

                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                      .hasMatch(email);
                  if (emailValid == false) {
                    return 'Email inválido.';
                  }
                },
                onSaved: (value) => _formData['email'] = value!,
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: InputDecoration(labelText: 'Avatar'),
                onSaved: (value) => _formData['avatarUrl'] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
