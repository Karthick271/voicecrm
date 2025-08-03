import 'package:flutter/material.dart';
import '../../core/models/item_model.dart';
import '../widgets/app_card.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/loading_overlay.dart';

class ItemListScreen extends StatelessWidget {
  // Example data. Replace with API call or Provider later!
  final List<ItemModel> items;

  const ItemListScreen({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    // Example: Simulate loading
    final isLoading = false;

    return LoadingOverlay(
      isLoading: isLoading,
      child: items.isEmpty
          ? const EmptyStateWidget(
              title: 'No Items Found',
              subtitle: 'Try adding something!',
              assetImagePath: null,
              fallbackIcon: Icons.inbox,
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return AppCard(
                  child: ListTile(
                    leading: const Icon(Icons.label_important_outline),
                    title: Text(item.title),
                    subtitle: Text(item.subtitle),
                    onTap: () {
                      // TODO: handle tap (navigate, show details, etc)
                    },
                  ),
                );
              },
            ),
    );
  }
}
