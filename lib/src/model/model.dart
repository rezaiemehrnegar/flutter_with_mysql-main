import 'package:flutter/foundation.dart' show immutable;

@immutable
class Profiles {
  final String email;
  final String password;
  const Profiles({required this.email, required this.password});
}
