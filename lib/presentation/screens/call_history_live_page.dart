import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voicecrm/core/theme/app_colors.dart';
import 'package:voicecrm/core/theme/app_typography.dart';

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
        return AppColors.success;
      case CallType.incoming:
        return AppColors.info;
      case CallType.missed:
        return AppColors.error;
      default:
        return AppColors.textSecondary;
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
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("Call History", style: AppTypography.titleLarge.copyWith(color: Colors.white)),
        backgroundColor: AppColors.appBarColor,
        centerTitle: true,
        elevation: 1,
      ),
      body: _callLogs.isEmpty
          ? Center(
              child: Text("No call history found", style: AppTypography.bodyMedium),
            )
          : ListView.separated(
                    physics: const BouncingScrollPhysics(),

              itemCount: _callLogs.length,
              separatorBuilder: (_, __) => Divider(color: AppColors.dividerColor),
              itemBuilder: (context, index) {
                final log = _callLogs.elementAt(index);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.surfaceColor,
                    child: Icon(_getIcon(log.callType), color: _getColor(log.callType)),
                  ),
                  title: Text(
                    log.name ?? log.number ?? "Unknown",
                    style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    "${log.callType.toString().split('.').last} · "
                    "${DateTime.fromMillisecondsSinceEpoch(log.timestamp ?? 0)}",
                    style: AppTypography.bodyMedium,
                  ),
                  trailing: Text(
                    "${log.duration ?? 0}s",
                    style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
                  ),
                  onTap: () {
                    if (log.number != null) _dialNumber(log.number!);
                  },
                );
              },
            ),
    );
  }
}
