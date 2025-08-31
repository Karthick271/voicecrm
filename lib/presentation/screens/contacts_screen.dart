import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voicecrm/core/theme/app_colors.dart';
import 'package:voicecrm/core/theme/app_typography.dart';
import 'package:voicecrm/presentation/widgets/custom_drawer_header.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final List<Map<String, String>> _contacts = [
    {"name": "Pranesh", "phone": "+91 8883075721"},
    {"name": "NRK(me)", "phone": "+91 6382367233"},
    {"name": "Sri", "phone": "+91 9597736066"},
    {"name": "Sophia Davis", "phone": "5551357911"},
    {"name": "Liam Harper", "phone": "5553692580"},
    {"name": "Ava Mitchell", "phone": "5557890123"},
    {"name": "Jackson Reed", "phone": "5554567890"},
    {"name": "Isabella Foster", "phone": "5556543210"},
    {"name": "Lucas Parker", "phone": "5551112233"},
    {"name": "Mia Collins", "phone": "5553334455"},
  ];

  List<Map<String, String>> _filteredContacts = [];

  @override
  void initState() {
    super.initState();
    _filteredContacts = List.from(_contacts); // initially all contacts
  }

  void _filterContacts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredContacts = List.from(_contacts);
      } else {
        _filteredContacts = _contacts.where((contact) {
          final name = contact["name"]!.toLowerCase();
          final phone = contact["phone"]!.toLowerCase();
          return name.contains(query.toLowerCase()) || phone.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  Future<void> _callNumber(String number) async {
    final Uri url = Uri.parse("tel:$number");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }

  Color _getAvatarColor(String name) {
    return Colors.primaries[name.hashCode % Colors.primaries.length].shade400;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
       appBar: AppBar(
  title: Text("Contacts", style: AppTypography.titleLarge.copyWith(color: Colors.white)),
  centerTitle: true,
  backgroundColor: AppColors.primaryColor,
  elevation: 1,
  actions: [
    IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {},
    ),
  ],
),
      drawer: const CustomDrawerHeader(),

      body: Column(
        children: [
          // 🔍 Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              style: AppTypography.bodyLarge,
              onChanged: _filterContacts, // ✅ filter as user types
              decoration: InputDecoration(
                hintText: "Search contacts",
                hintStyle: AppTypography.bodyMedium,
                prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.surfaceColor,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: AppColors.borderColor),
                ),
              ),
            ),
          ),

          // 📋 Contact list
          Expanded(
            child: _filteredContacts.isEmpty
                ? Center(
                    child: Text("No contacts found", style: AppTypography.bodyMedium),
                  )
                : ListView.separated(
                          physics: const BouncingScrollPhysics(),

                    itemCount: _filteredContacts.length,
                    separatorBuilder: (_, __) => Divider(height: 1, color: AppColors.dividerColor),
                    itemBuilder: (context, index) {
                      final contact = _filteredContacts[index];
                      final name = contact["name"] ?? "Unknown";
                      final phone = contact["phone"] ?? "";
                      final firstLetter = name.isNotEmpty ? name[0].toUpperCase() : "?";
                      final avatarColor = _getAvatarColor(name);

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: avatarColor,
                          child: Text(
                            firstLetter,
                            style: AppTypography.bodyLarge.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          name,
                          style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          phone,
                          style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
                        ),
                        trailing: InkWell(
                          onTap: () => _callNumber(phone),
                          borderRadius: BorderRadius.circular(20),
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                            child: Icon(Icons.call, color: AppColors.primaryColor, size: 20),
                          ),
                        ),
                        onTap: () => _callNumber(phone),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
