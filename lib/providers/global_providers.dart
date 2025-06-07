import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider<int>((ref) => 0);

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(null);

  void setUser(User? user) {
    state = user;
  }

  User? get user => state;

  void logout() {
    state = null;
  }
}

final userProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier();
});

final userProviderWithOutNotifier = userProvider.notifier;
