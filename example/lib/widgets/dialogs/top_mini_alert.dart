import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'dialog_demo_components.dart';

class TopMiniAlert extends StatelessWidget {
  const TopMiniAlert({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.topCenter,
      child: DemoFloatingSurface(
        maxWidth: 560,
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        accentColor: AppColors.error,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 430;
            final message = Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(
                    Icons.error_outline_rounded,
                    size: 20,
                    color: AppColors.error,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    '3 purchase orders are blocked by missing budget approval.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
            final actions = Wrap(
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: AppSpacing.sm,
              children: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Review'),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  tooltip: 'Close',
                  icon: const Icon(Icons.close_rounded, size: 16),
                ),
              ],
            );

            if (compact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  message,
                  const SizedBox(height: AppSpacing.sm),
                  actions,
                ],
              );
            }
            return Row(
              children: <Widget>[
                Expanded(child: message),
                const SizedBox(width: AppSpacing.sm),
                actions,
              ],
            );
          },
        ),
      ),
    );
  }
}
