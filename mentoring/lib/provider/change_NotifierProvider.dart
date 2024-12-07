

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mentoring/services/auth_services.dart';

final authProvider = ChangeNotifierProvider((ref) {
  return AuthServices();
});

final dataProvider = FutureProvider<Map<String, String>>((ref) async {
  final authService = ref.watch(authProvider);
  return await authService.fetchUserData();
});