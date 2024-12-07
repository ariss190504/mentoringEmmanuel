import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mentoring/provider/change_NotifierProvider.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(dataProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
      ),
      body: Center(
        child: dataAsync.when(
          data: (data) => Column(
            children: [
              Text('Nom: ${data['name']}'),
              Text('Email: ${data['email']}'),
            ],
          ),
          error: (err, stack) => Text('Erreur: $err'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
