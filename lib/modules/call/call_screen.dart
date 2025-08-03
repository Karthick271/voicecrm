import 'package:flutter/material.dart';
import '../../presentation/widgets/custom_app_bar.dart';
import '../recordings/recordings_screen.dart';
import '../../core/theme/app_colors.dart';
 
class CallScreen extends StatefulWidget {
  final String contactName;
  final String phone;

  const CallScreen({super.key, required this.contactName, required this.phone});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool _recording = false;
  int _seconds = 0;
  late final Stopwatch _stopwatch;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch()..start();
    _ticker = Ticker(_onTick)..start();
  }

  void _onTick(Duration _) {
    setState(() {
      _seconds = _stopwatch.elapsed.inSeconds;
    });
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _ticker.dispose();
    super.dispose();
  }

  void _endCall() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const RecordingsScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _recording ? AppColors.recordingColor.withOpacity(0.05) : Colors.white,
      appBar: CustomAppBar(title: 'Call with ${widget.contactName}'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_recording ? Icons.mic : Icons.mic_none, size: 64, color: _recording ? AppColors.recordingColor : Colors.grey),
            const SizedBox(height: 16),
            Text('${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')}', style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 16),
            SwitchListTile(
              value: _recording,
              onChanged: (val) => setState(() => _recording = val),
              title: Text(_recording ? 'Recording...' : 'Not Recording'),
              activeColor: AppColors.recordingColor,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.call_end),
              label: const Text('End Call'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: _endCall,
            ),
          ],
        ),
      ),
    );
  }
}

// Simple Ticker class for timer updates
class Ticker {
  final void Function(Duration) onTick;
  bool _running = false;

  Ticker(this.onTick);

  void start() {
    _running = true;
    _tick();
  }

  void _tick() async {
    while (_running) {
      await Future.delayed(const Duration(seconds: 1));
      if (_running) {
        onTick(Duration.zero);
      }
    }
  }

  void dispose() {
    _running = false;
  }
}
