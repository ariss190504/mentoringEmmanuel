import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Map<String, dynamic>>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Données Soumises')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: userData.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email : ${userData['email']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Nom : ${userData['name']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
      ),
    );
  }
}
