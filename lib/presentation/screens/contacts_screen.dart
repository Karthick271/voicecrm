import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voicecrm/presentation/screens/call_history_live_page.dart';

class ContactsScreen extends StatelessWidget {
  final List<Map<String, String>> contacts = [
    {"name": "Ethan Carter", "phone": "5551234567"},
    {"name": "Olivia Bennett", "phone": "5559876543"},
    {"name": "Noah Thompson", "phone": "5552468013"},
    {"name": "Sophia Davis", "phone": "5551357911"},
    {"name": "Liam Harper", "phone": "5553692580"},
    {"name": "Ava Mitchell", "phone": "5557890123"},
    {"name": "Jackson Reed", "phone": "5554567890"},
    {"name": "Isabella Foster", "phone": "5556543210"},
    {"name": "Lucas Parker", "phone": "5551112233"},
    {"name": "Mia Collins", "phone": "5553334455"},
  ];

  ContactsScreen({Key? key}) : super(key: key);

  Future<void> _callNumber(String number) async {
    final Uri url = Uri.parse("tel:$number");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Contacts"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color(0xFF1173d4)),
              shape: MaterialStateProperty.all(const CircleBorder()),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          // 🔍 Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search contacts",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 📋 Contact list
          Expanded(
            child: ListView.separated(
              itemCount: contacts.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  title: Text(contact["name"]!, style: const TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text(contact["phone"]!, style: const TextStyle(color: Colors.grey)),
                  trailing: IconButton(
                    icon: const Icon(Icons.call, color: Color(0xFF1173d4)),
                    onPressed: () => _callNumber(contact["phone"]!),
                  ),
                  onTap: () => _callNumber(contact["phone"]!),
                );
              },
            ),
          ),
        ],
      ),

     bottomNavigationBar: BottomNavigationBar(
  currentIndex: 0, // highlight current tab (Contacts for example)
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.group), label: "Contacts"),
    BottomNavigationBarItem(icon: Icon(Icons.history), label: "Call History"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
  ],
  onTap: (index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CallHistoryLivePage()),
      );
    }
  },
),

    );
  }
}
