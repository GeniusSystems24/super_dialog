part of '../../super_dialog.dart';

/// A compact dialog surface built directly from `super_core` design tokens.
///
/// It can be returned directly from any [SuperDialog] builder. Width, padding,
/// action layout, and scroll constraints adapt automatically to compact screens.
class SuperDialogSurface extends StatelessWidget {
  const SuperDialogSurface({
    super.key,
    this.title,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.markerColor,
    this.content,
    this.actions = const <Widget>[],
    this.width,
    this.showClose = true,
    this.onClose,
  });

  final String? title;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final Color? markerColor;
  final Widget? content;
  final List<Widget> actions;
  final double? width;
  final bool showClose;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final theme = SuperDialogThemeData.of(context);
    final media = MediaQuery.of(context);
    final compact = media.size.width < 600;
    final veryCompact = media.size.width < 420;
    final hasHeader = title != null || subtitle != null || icon != null;
    final inset = compact
        ? EdgeInsets.all(
            veryCompact ? core.SuperTokens.space2 : core.SuperTokens.space3,
          )
        : theme.insetPadding;
    final availableWidth =
        (media.size.width - inset.horizontal).clamp(0.0, double.infinity);
    final availableHeight = (media.size.height -
            inset.vertical -
            media.viewInsets.vertical -
            media.padding.vertical)
        .clamp(220.0, double.infinity);
    final maxWidth = (width ?? theme.dialogWidth)
        .clamp(0.0, availableWidth)
        .toDouble();
    final contentPadding = compact
        ? EdgeInsets.all(
            veryCompact ? core.SuperTokens.space3 : core.SuperTokens.space4,
          )
        : theme.contentPadding;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: inset,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
          maxHeight: availableHeight.toDouble(),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.surfaceColor,
            borderRadius: BorderRadius.circular(theme.cardRadius),
            border: Border.all(color: theme.borderColor),
            boxShadow: theme.shadow,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (hasHeader)
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    contentPadding.left,
                    contentPadding.top,
                    contentPadding.right,
                    content != null || actions.isNotEmpty
                        ? 0
                        : contentPadding.bottom,
                  ),
                  child: _SuperDialogHeader(
                    title: title,
                    subtitle: subtitle,
                    icon: icon,
                    iconColor: iconColor,
                    markerColor: markerColor,
                    showClose: showClose,
                    onClose: onClose,
                    compact: veryCompact,
                  ),
                ),
              if (content != null)
                Flexible(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.fromLTRB(
                      contentPadding.left,
                      hasHeader
                          ? core.SuperTokens.space4
                          : contentPadding.top,
                      contentPadding.right,
                      actions.isNotEmpty ? 0 : contentPadding.bottom,
                    ),
                    child: DefaultTextStyle.merge(
                      style: core.SuperText.body.copyWith(
                        color: theme.secondaryForegroundColor,
                      ),
                      child: content!,
                    ),
                  ),
                ),
              if (actions.isNotEmpty)
                Padding(
                  padding: contentPadding,
                  child: _SuperDialogActions(
                    actions: actions,
                    stacked: veryCompact,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuperDialogActions extends StatelessWidget {
  const _SuperDialogActions({
    required this.actions,
    required this.stacked,
  });

  final List<Widget> actions;
  final bool stacked;

  @override
  Widget build(BuildContext context) {
    if (!stacked) {
      return Wrap(
        alignment: WrapAlignment.end,
        runAlignment: WrapAlignment.end,
        spacing: core.SuperTokens.space3,
        runSpacing: core.SuperTokens.space2,
        children: actions,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (var index = actions.length - 1; index >= 0; index--) ...<Widget>[
          SizedBox(width: double.infinity, child: actions[index]),
          if (index > 0) const SizedBox(height: core.SuperTokens.space2),
        ],
      ],
    );
  }
}

class _SuperDialogHeader extends StatelessWidget {
  const _SuperDialogHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.markerColor,
    required this.showClose,
    required this.onClose,
    required this.compact,
  });

  final String? title;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final Color? markerColor;
  final bool showClose;
  final VoidCallback? onClose;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = SuperDialogThemeData.of(context);
    final tone = iconColor ?? markerColor ?? theme.accentColor;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (icon != null)
          Container(
            width: compact ? 36 : 40,
            height: compact ? 36 : 40,
            alignment: Alignment.center,
            margin: const EdgeInsetsDirectional.only(
              end: core.SuperTokens.space3,
            ),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(theme.controlRadius),
            ),
            child: Icon(icon, size: compact ? 18 : 20, color: tone),
          )
        else
          Container(
            width: core.SuperTokens.markerWidth,
            height: compact ? 34 : core.SuperTokens.markerHeight,
            margin: const EdgeInsetsDirectional.only(
              top: 2,
              end: core.SuperTokens.space4,
            ),
            decoration: BoxDecoration(
              color: tone,
              borderRadius: BorderRadius.circular(theme.pillRadius),
            ),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (title != null)
                Text(
                  title!,
                  style: core.SuperText.heading.copyWith(
                    color: theme.foregroundColor,
                    fontSize: compact ? 15 : null,
                  ),
                ),
              if (subtitle != null) ...<Widget>[
                const SizedBox(height: core.SuperTokens.space1),
                Text(
                  subtitle!,
                  style: core.SuperText.caption.copyWith(
                    color: theme.tertiaryForegroundColor,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (showClose) ...<Widget>[
          const SizedBox(width: core.SuperTokens.space2),
          IconButton(
            onPressed: onClose ?? () => Navigator.of(context).maybePop(),
            tooltip: 'Close',
            icon: const Icon(Icons.close, size: 16),
            style: IconButton.styleFrom(
              fixedSize: const Size.square(core.SuperTokens.iconButton),
              minimumSize: const Size.square(core.SuperTokens.iconButton),
              padding: EdgeInsets.zero,
              foregroundColor: theme.secondaryForegroundColor,
              hoverColor: theme.inputColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(theme.controlRadius),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
