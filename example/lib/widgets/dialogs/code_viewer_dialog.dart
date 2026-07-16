import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_dialog/super_dialog.dart';
import '../../theme/app_theme.dart';

/// A dialog that displays code with syntax highlighting.
class CodeViewerDialog extends StatelessWidget {
  const CodeViewerDialog({
    super.key,
    required this.title,
    required this.code,
    this.accentColor,
  });

  final String title;
  final String code;
  final Color? accentColor;

  void _copyCode(BuildContext context) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_rounded, color: Colors.white, size: 18),
            SizedBox(width: AppSpacing.sm),
            Text('Code copied to clipboard'),
          ],
        ),
        backgroundColor: AppColors.success,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? AppColors.primary;
    final theme = Theme.of(context);

    return SuperDialogSurface(
      title: 'Code Example',
      subtitle: title,
      icon: Icons.code_rounded,
      iconColor: color,
      width: 640,
      content: Container(
        height: 340,
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark
              ? AppColors.darkBackground
              : AppColors.lightInput,
          borderRadius: BorderRadius.circular(AppRadii.control),
          border: Border.all(color: theme.colorScheme.outline),
        ),
        clipBehavior: Clip.antiAlias,
        child: SyntaxView(
          code: code,
          syntax: Syntax.DART,
          syntaxTheme: getSyntaxTheme(theme),
          withZoom: false,
          withLinesCount: true,
          expanded: true,
        ),
      ),
      actions: [
        FilledButton.icon(
          onPressed: () => _copyCode(context),
          icon: const Icon(Icons.copy_rounded, size: 16),
          label: const Text('Copy Code'),
          style: FilledButton.styleFrom(backgroundColor: color),
        ),
      ],
    );
  }
}

SyntaxTheme getSyntaxTheme(ThemeData theme) {
  final syntaxTheme = switch (theme.brightness) {
    Brightness.light => SyntaxTheme.vscodeLight(),
    Brightness.dark => SyntaxTheme.vscodeDark(),
  };

  syntaxTheme.baseStyle = GoogleFonts.jetBrainsMono(
    textStyle: syntaxTheme.baseStyle,
    fontWeight: FontWeight.w400,
  );

  return syntaxTheme;
}
