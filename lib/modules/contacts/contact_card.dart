import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final String name;
  final String phone;
  final VoidCallback onTap;

  const ContactCard({
    super.key,
    required this.name,
    required this.phone,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(child: Text(name[0])),
        title: Text(name),
        subtitle: Text(phone),
        trailing: const Icon(Icons.call),
        onTap: onTap,
      ),
    );
  }
}
