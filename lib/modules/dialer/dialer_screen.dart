// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../widgets/custom_app_bar.dart';
// import '../call/call_screen.dart';

// class DialerScreen extends StatefulWidget {
//   final String? contactName;
//   final String? phone;

//   const DialerScreen({super.key, this.contactName, this.phone});

//   @override
//   State<DialerScreen> createState() => _DialerScreenState();
// }

// class _DialerScreenState extends State<DialerScreen> {
//   final TextEditingController _controller = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     if (widget.phone != null) {
//       _controller.text = widget.phone!;
//     }
//   }

//   /// Launches the native dialer with the given phone number
//   Future<void> _realCall() async {
//     final number = _controller.text.trim();
//     final Uri telUri = Uri(scheme: 'tel', path: number);

//     // Try launching the dialer
//     if (await canLaunchUrl(telUri)) {
//       await launchUrl(telUri);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Could not open the dialer on this device.')),
//       );
//     }
//   }

//   /// Simulates an in-app call (for your demo/recording module)
//   void _startAppCall() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CallScreen(
//           contactName: widget.contactName ?? _controller.text,
//           phone: _controller.text,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(title: 'Dialer'),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _controller,
//               keyboardType: TextInputType.phone,
//               style: const TextStyle(fontSize: 24),
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Phone Number',
//               ),
//             ),
//             const SizedBox(height: 32),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.call),
//                   label: const Text('Real Call'),
//                   onPressed: _realCall,
//                 ),
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.phone_android),
//                   label: const Text('App Call'),
//                   onPressed: _startAppCall,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
