// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../widgets/custom_app_bar.dart';
// import 'contact_card.dart';
// import 'contacts_provider.dart';
// import '../dialer/dialer_screen.dart';
 
// class ContactsScreen extends ConsumerWidget {
//   const ContactsScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final contacts = ref.watch(contactsProvider);

//     return Scaffold(
//       appBar: const CustomAppBar(title: 'Contacts'),
//       body: ListView.builder(
//         itemCount: contacts.length,
//         itemBuilder: (context, index) {
//           final contact = contacts[index];
//           return ContactCard(
//             name: contact['name']!,
//             phone: contact['phone']!,
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DialerScreen(
//                     contactName: contact['name'],
//                     phone: contact['phone'],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
