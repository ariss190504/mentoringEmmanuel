import 'package:first_emma_app/api/user_api.dart';
import 'package:first_emma_app/model/form_model.dart';
import 'package:first_emma_app/screen/user_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formModel = Provider.of<FormModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Formulaire')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              onChanged: formModel.setEmail,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              onChanged: formModel.setName,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: formModel.isValid
                  ? () async {
                      // Créer l'utilisateur via l'API
                      final futureResponse = createUser(
                        formModel.email,
                        formModel.name,
                      );

                      // Naviguer vers une nouvelle vue avec FutureProvider
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              FutureProvider<Map<String, dynamic>>.value(
                            value: futureResponse,
                            initialData: {'email': '', 'name': ''},
                            child: const UserListScreen(),
                          ),
                        ),
                      );
                    }
                  : null,
              child: const Text('Soumettre le formulaire'),
            ),
          ],
        ),
      ),
    );
  }
}
