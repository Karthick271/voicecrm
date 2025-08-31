// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:phone_state/phone_state.dart';

// class CallAndLogScreen extends StatefulWidget {
//   final String contactName;
//   final String phoneNumber;

//   const CallAndLogScreen({super.key, required this.contactName, required this.phoneNumber});

//   @override
//   State<CallAndLogScreen> createState() => _CallAndLogScreenState();
// }

// class _CallAndLogScreenState extends State<CallAndLogScreen> {
//   PhoneStateStatus? _lastState;
//   late final Stream<PhoneStateStatus> _phoneStream;

//   @override
//   void initState() {
//     super.initState();
//     // Listen for call state changes
//     _phoneStream = PhoneState.phoneStateStream;
//     _phoneStream.listen((PhoneStateStatus status) {
//       // Only react if call just ended (was active before)
//       if (_lastState == PhoneStateStatus.CALL_INCOMING ||
//           _lastState == PhoneStateStatus.CALL_STARTED ||
//           _lastState == PhoneStateStatus.NOTHING &&
//           status == PhoneStateStatus.CALL_ENDED) {
//         _showNoteScreen();
//       }
//       _lastState = status;
//     });
//   }

//   Future<void> _makeCall() async {
//     final Uri telUri = Uri(scheme: 'tel', path: widget.phoneNumber);
//     if (await canLaunchUrl(telUri)) {
//       await launchUrl(telUri);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Could not open dialer')),
//       );
//     }
//   }

//   void _showNoteScreen() async {
//     // Delay a bit to allow the user to return to app after call
//     await Future.delayed(const Duration(seconds: 1));
//     if (!mounted) return;
//     Navigator.of(context).push(
//       MaterialPageRoute(builder: (_) => RecordNoteScreen(contactName: widget.contactName)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Call Contact')),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           children: [
//             Text(widget.contactName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 16),
//             Text(widget.phoneNumber, style: const TextStyle(fontSize: 20)),
//             const Spacer(),
//             ElevatedButton.icon(
//               icon: const Icon(Icons.call),
//               label: const Text('Call Now'),
//               onPressed: _makeCall,
//             ),
//             const SizedBox(height: 40),
//             // Manual fallback for iOS or if listener fails
//             OutlinedButton.icon(
//               icon: const Icon(Icons.mic),
//               label: const Text('Add Call Note'),
//               onPressed: _showNoteScreen,
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
