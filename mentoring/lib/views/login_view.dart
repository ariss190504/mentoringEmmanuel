import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mentoring/provider/change_NotifierProvider.dart';
import 'package:mentoring/views/home_view.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authServices = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'entrer votre nom',
                labelStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (value) => authServices.setName(value),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'entrer votre email',
                labelStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (value) => authServices.setEmail(value),
            ),
            const SizedBox(
              height: 24,
            ),
            authServices.isLoggedIn
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      try {
                        await authServices.login();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeView()),
                        );
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erreur: $error')),
                        );
                      }
                    },
                    child: const Text('Connexion'),
                  ),
          ],
        ),
      ),
    );
  }
}
