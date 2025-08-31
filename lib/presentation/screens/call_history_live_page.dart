import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:url_launcher/url_launcher.dart';

class CallHistoryLivePage extends StatefulWidget {
  @override
  _CallHistoryLivePageState createState() => _CallHistoryLivePageState();
}

class _CallHistoryLivePageState extends State<CallHistoryLivePage> {
  Iterable<CallLogEntry> _callLogs = [];

  @override
  void initState() {
    super.initState();
    _fetchLogs();
  }

  Future<void> _fetchLogs() async {
    final logs = await CallLog.get();
    setState(() {
      _callLogs = logs;
    });
  }

  IconData _getIcon(CallType? type) {
    switch (type) {
      case CallType.outgoing:
        return Icons.call_made;
      case CallType.incoming:
        return Icons.call_received;
      case CallType.missed:
        return Icons.call_missed;
      default:
        return Icons.call;
    }
  }

  Color _getColor(CallType? type) {
    switch (type) {
      case CallType.outgoing:
        return Colors.green;
      case CallType.incoming:
        return Colors.blue;
      case CallType.missed:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _dialNumber(String number) async {
    final uri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Call History")),
      body: ListView(
        children: _callLogs.map((log) {
          return ListTile(
            leading: CircleAvatar(
              child: Icon(_getIcon(log.callType), color: _getColor(log.callType)),
            ),
            title: Text(log.name ?? log.number ?? "Unknown"),
            subtitle: Text(
              "${log.callType.toString().split('.').last} · "
              "${DateTime.fromMillisecondsSinceEpoch(log.timestamp!)}",
            ),
            trailing: Text("${log.duration ?? 0}s"),
            onTap: () {
              if (log.number != null) _dialNumber(log.number!);
            },
          );
        }).toList(),
      ),
    );
  }
}
