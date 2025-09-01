import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:voicecrm/core/theme/app_colors.dart';
import 'package:voicecrm/core/theme/app_typography.dart';

class RecordingsPage extends StatefulWidget {
  const RecordingsPage({super.key});

  @override
  State<RecordingsPage> createState() => _RecordingsPageState();
}

class _RecordingsPageState extends State<RecordingsPage> {
  List<FileSystemEntity> _files = [];
  final AudioPlayer _player = AudioPlayer();
  String? _currentlyPlaying;

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    final dir = await getApplicationDocumentsDirectory();
    final files = Directory(dir.path)
        .listSync()
        .where((f) => f.path.endsWith(".m4a"))
        .toList()
      ..sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified)); // newest first
    setState(() => _files = files);
  }

  Future<void> _playFile(String path) async {
    if (_currentlyPlaying == path) {
      // toggle stop
      await _player.stop();
      setState(() => _currentlyPlaying = null);
    } else {
      await _player.stop();
      await _player.play(DeviceFileSource(path));
      setState(() => _currentlyPlaying = path);
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("Recordings", style: AppTypography.titleLarge.copyWith(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      body: _files.isEmpty
          ? Center(child: Text("No recordings found", style: AppTypography.bodyMedium))
          : RefreshIndicator(
              onRefresh: _loadFiles,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: _files.length,
                separatorBuilder: (_, __) => Divider(color: AppColors.dividerColor, height: 1),
                itemBuilder: (context, index) {
                  final file = _files[index];
                  final name = file.path.split("/").last;
                  final isPlaying = _currentlyPlaying == file.path;

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                      child: Icon(Icons.audiotrack, color: AppColors.primaryColor),
                    ),
                    title: Text(name, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
                    subtitle: Text(
                      "Saved: ${file.statSync().modified}",
                      style: AppTypography.bodyMedium,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        isPlaying ? Icons.stop : Icons.play_arrow,
                        color: AppColors.primaryColor,
                      ),
                      onPressed: () => _playFile(file.path),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
