import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactsProvider = Provider<List<Map<String, String>>>((ref) {
  return [
    {'name': 'Alice', 'phone': '+91 98765 43210'},
    {'name': 'Bob', 'phone': '+91 91234 56789'},
    {'name': 'Charlie', 'phone': '+91 99887 77665'},
    {'name': 'CRM Support', 'phone': '+91 90000 11111'},
  ];
});
