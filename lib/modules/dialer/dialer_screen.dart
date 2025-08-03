import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../call/call_screen.dart';
 
class DialerScreen extends StatefulWidget {
  final String? contactName;
  final String? phone;

  const DialerScreen({super.key, this.contactName, this.phone});

  @override
  State<DialerScreen> createState() => _DialerScreenState();
}

class _DialerScreenState extends State<DialerScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.phone != null) {
      _controller.text = widget.phone!;
    }
  }

  void _startCall() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CallScreen(
          contactName: widget.contactName ?? _controller.text,
          phone: _controller.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Dialer'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.phone,
              style: const TextStyle(fontSize: 24),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone Number',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.call),
              label: const Text('Call'),
              onPressed: _startCall,
            ),
          ],
        ),
      ),
    );
  }
}
