import 'package:flutter/material.dart';

abstract final class AppInteractionFeedback {
  static void showSelection(BuildContext context, String label) {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$label selected'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 1200),
        ),
      );
  }

  static Future<void> showInfo(BuildContext context, String title) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text('$title is available as an interactive app action.'),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  static Future<void> showSearch(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search'),
        content: const TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Type a name...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  static Future<void> showOptions(
    BuildContext context, {
    required String title,
    required List<String> options,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                title,
                style: Theme.of(sheetContext).textTheme.titleMedium,
              ),
            ),
            ...options.map(
              (option) => ListTile(
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  showSelection(context, option);
                },
                title: Text(option),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
