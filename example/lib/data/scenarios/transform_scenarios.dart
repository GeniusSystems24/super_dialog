import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';
import '../../models/example_scenario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/dialogs/dialogs.dart';

/// Transform animation scenarios (all centerScale, centerFade, rotation, bounce, elastic, expand, flip, and combined animations)
class TransformScenarios {
  TransformScenarios._();

  static List<ExampleScenario> getAll() {
    return [
      // ========================================================================
      // CENTER SCALE ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'Center Scale · Expense Approval',
        description:
            'Scaled approval prompt that mirrors the reference animation.',
        animation: DialogAnimation.centerScale,
        category: 'Transform',
        icon: Icons.verified_rounded,
        accentColor: AppColors.primary,
        barrierColor: const Color(0x8C000000),
        barrierBlur: 8,
        builder: (context) => const QuickApprovalDialog(),
      ),

      ExampleScenario(
        title: 'ERP Rollout Milestones',
        description: 'ERP rollout milestones scaling into a focused review surface.',
        animation: DialogAnimation.centerScale,
        category: 'Transform',
        icon: Icons.map_rounded,
        accentColor: AppColors.accent,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) =>
            const DemoAdaptivePanel(widthFactor: 0.5, child: RoadmapCard()),
      ),

      ExampleScenario(
        title: 'Payment Cutoff Countdown',
        description: 'Countdown to a payment or posting cutoff requiring approval.',
        animation: DialogAnimation.centerScale,
        category: 'Transform',
        icon: Icons.timer_rounded,
        accentColor: AppColors.warning,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const CenterCountdownCard(),
      ),

      ExampleScenario(
        title: 'Controlled Action Confirmation',
        description: 'Controlled business action confirmation with a restrained scale transition.',
        animation: DialogAnimation.centerScale,
        category: 'Transform',
        icon: Icons.help_outline_rounded,
        accentColor: AppColors.info,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      ExampleScenario(
        title: 'Attachment Preview',
        description: 'Invoice, contract, or receipt attachment preview scaling from center.',
        animation: DialogAnimation.centerScale,
        category: 'Transform',
        icon: Icons.image_rounded,
        accentColor: const Color(0xFF7C5CFC),
        barrierColor: const Color(0x8C000000),
        barrierBlur: 10,
        barrierDismissible: true,
        builder: (context) =>
            const DemoAdaptivePanel(widthFactor: 0.6, child: RoadmapCard()),
      ),

      // ========================================================================
      // CENTER FADE ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'Posting Status',
        description: 'Subtle posting or workflow status confirmation that fades in place.',
        animation: DialogAnimation.centerFade,
        category: 'Transform',
        icon: Icons.check_circle_rounded,
        accentColor: AppColors.success,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const StatusNotificationDialog(),
      ),

      ExampleScenario(
        title: 'Unsaved Document Guard',
        description:
            'Uses onDismissed to confirm leaving the page after fade close.',
        animation: DialogAnimation.centerFade,
        category: 'Transform',
        icon: Icons.lock_rounded,
        accentColor: AppColors.error,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const GuardedExitDialog(),
        onDismissed: (context) {
          Future.microtask(() async {
            final bool? shouldLeave = await showDialog<bool>(
              context: context,
              barrierDismissible: false,
              builder: (dialogContext) => AlertDialog(
                title: const Text('Close example screen?'),
                content: const Text(
                  'The dialog has been dismissed.\nDo you want to exit this demo screen?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(false),
                    child: const Text('Stay here'),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.of(dialogContext).pop(true),
                    child: const Text('Leave screen'),
                  ),
                ],
              ),
            );
            if (shouldLeave == true && context.mounted) {
              Navigator.of(context).maybePop();
            }
          });
        },
      ),

      ExampleScenario(
        title: 'Access Review Reminder',
        description: 'Half-width compliance reminder fading without directional motion.',
        animation: DialogAnimation.centerFade,
        category: 'Transform',
        icon: Icons.lightbulb_rounded,
        accentColor: AppColors.accent,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const DemoAdaptivePanel(
          widthFactor: 0.5,
          child: CenterReminderCard(),
        ),
      ),

      ExampleScenario(
        title: 'Posting in Progress',
        description: 'Non-dismissible processing state while an ERP document is posted.',
        animation: DialogAnimation.centerFade,
        category: 'Transform',
        icon: Icons.hourglass_empty_rounded,
        accentColor: AppColors.primary,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: false,
        builder: (context) => const StatusNotificationDialog(),
      ),

      // ========================================================================
      // ROTATION ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'Document Assignment Notice',
        description: 'Assignment notification using a noticeable rotation entrance.',
        animation: DialogAnimation.rotateIn,
        category: 'Transform',
        icon: Icons.celebration_rounded,
        accentColor: AppColors.accent,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const StatusNotificationDialog(),
      ),

      ExampleScenario(
        title: 'Inventory Exception Alert',
        description: 'Inventory or integration exception alert with smooth rotation.',
        animation: DialogAnimation.rotateIn,
        category: 'Transform',
        icon: Icons.notifications_active_rounded,
        accentColor: AppColors.warning,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      ExampleScenario(
        title: 'Close Task Completed',
        description: 'Completed close or approval milestone with a distinctive transition.',
        animation: DialogAnimation.rotateIn,
        category: 'Transform',
        icon: Icons.stars_rounded,
        accentColor: const Color(0xFFFBBF24),
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const CenterCountdownCard(),
      ),

      ExampleScenario(
        title: 'Urgent Compliance Notice',
        description: 'High-priority compliance notice combining rotation and scale.',
        animation: DialogAnimation.rotateScale,
        category: 'Transform',
        icon: Icons.campaign_rounded,
        accentColor: AppColors.primary,
        barrierColor: const Color(0x8C000000),
        barrierBlur: 6,
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      ExampleScenario(
        title: 'Supplier Contract Notice',
        description: 'Supplier or contract announcement requiring user attention.',
        animation: DialogAnimation.rotateScale,
        category: 'Transform',
        icon: Icons.star_rounded,
        accentColor: AppColors.accent,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const DemoAdaptivePanel(
          widthFactor: 0.5,
          child: RoadmapCard(),
        ),
      ),

      ExampleScenario(
        title: 'Price Variance Alert',
        description: 'Purchase price variance notice with a dynamic entrance.',
        animation: DialogAnimation.rotateScale,
        category: 'Transform',
        icon: Icons.local_offer_rounded,
        accentColor: const Color(0xFFEF4444),
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      // ========================================================================
      // BOUNCE ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'Posting Success',
        description: 'Positive posting result using a more expressive bounce transition.',
        animation: DialogAnimation.bounceIn,
        category: 'Transform',
        icon: Icons.check_circle_rounded,
        accentColor: AppColors.success,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const StatusNotificationDialog(),
      ),

      ExampleScenario(
        title: 'Approval Milestone',
        description: 'Approval milestone feedback using a controlled bounce transition.',
        animation: DialogAnimation.bounceIn,
        category: 'Transform',
        icon: Icons.emoji_events_rounded,
        accentColor: AppColors.accent,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const CenterCountdownCard(),
      ),

      ExampleScenario(
        title: 'Workflow Escalation',
        description: 'Workflow escalation notice using an intentionally expressive motion example.',
        animation: DialogAnimation.bounceIn,
        category: 'Transform',
        icon: Icons.trending_up_rounded,
        accentColor: const Color(0xFF1DB88A),
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      ExampleScenario(
        title: 'Quick Reclassification Sheet',
        description: 'Mobile reclassification sheet entering from the bottom with bounce.',
        animation: DialogAnimation.bounceSlidBottom,
        category: 'Transform',
        icon: Icons.sports_basketball_rounded,
        accentColor: AppColors.primary,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const BottomQuickAssignSheet(),
      ),

      ExampleScenario(
        title: 'Document Actions',
        description: 'Document action menu sliding upward with a bounce effect.',
        animation: DialogAnimation.bounceSlidBottom,
        category: 'Transform',
        icon: Icons.menu_rounded,
        accentColor: AppColors.info,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const TimeOffDetailsDialog(
          alignment: Alignment.bottomCenter,
          widthFactor: 0.6,
        ),
      ),

      ExampleScenario(
        title: 'Record Shortcuts',
        description: 'Quick record shortcuts presented as a bottom action sheet.',
        animation: DialogAnimation.bounceSlidBottom,
        category: 'Transform',
        icon: Icons.flash_on_rounded,
        accentColor: const Color(0xFFFBBF24),
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const BottomQuickAssignSheet(),
      ),

      // ========================================================================
      // ELASTIC ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'Interactive Validation Prompt',
        description: 'Interactive validation prompt demonstrating elastic overshoot.',
        animation: DialogAnimation.elasticIn,
        category: 'Transform',
        icon: Icons.rule_folder_outlined,
        accentColor: const Color(0xFF7C5CFC),
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      ExampleScenario(
        title: 'Dynamic Work Item',
        description: 'Dynamic work item entering with a spring-like transition.',
        animation: DialogAnimation.elasticIn,
        category: 'Transform',
        icon: Icons.touch_app_rounded,
        accentColor: AppColors.accent,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const DemoAdaptivePanel(
          widthFactor: 0.5,
          child: CenterReminderCard(),
        ),
      ),

      ExampleScenario(
        title: 'KPI Target Reached',
        description: 'KPI target notification using elastic feedback.',
        animation: DialogAnimation.elasticIn,
        category: 'Transform',
        icon: Icons.card_giftcard_rounded,
        accentColor: const Color(0xFFEF4444),
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const StatusNotificationDialog(),
      ),

      ExampleScenario(
        title: 'Mobile Approval Sheet',
        description: 'Mobile approval sheet with elastic slide behavior.',
        animation: DialogAnimation.elasticSlideBottom,
        category: 'Transform',
        icon: Icons.settings_ethernet_rounded,
        accentColor: AppColors.info,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const BottomQuickAssignSheet(),
      ),

      ExampleScenario(
        title: 'Allocation Actions',
        description: 'Allocation actions in a springy mobile bottom sheet.',
        animation: DialogAnimation.elasticSlideBottom,
        category: 'Transform',
        icon: Icons.list_rounded,
        accentColor: AppColors.primary,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const TimeOffDetailsDialog(
          alignment: Alignment.bottomCenter,
        ),
      ),

      ExampleScenario(
        title: 'Worklist Sorting',
        description: 'Worklist sort selector using elastic slide motion.',
        animation: DialogAnimation.elasticSlideBottom,
        category: 'Transform',
        icon: Icons.sort_rounded,
        accentColor: AppColors.success,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const BottomQuickAssignSheet(),
      ),

      // ========================================================================
      // EXPAND ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'Company Code Selector',
        description: 'Company-code selector unfolding vertically from the center.',
        animation: DialogAnimation.expandVertical,
        category: 'Transform',
        icon: Icons.expand_more_rounded,
        accentColor: AppColors.primary,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const DemoAdaptivePanel(
          widthFactor: 0.5,
          child: RoadmapCard(),
        ),
      ),

      ExampleScenario(
        title: 'Cost Breakdown Panel',
        description: 'Cost breakdown panel expanding vertically for review.',
        animation: DialogAnimation.expandVertical,
        category: 'Transform',
        icon: Icons.unfold_more_rounded,
        accentColor: AppColors.success,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      ExampleScenario(
        title: 'Audit Detail Accordion',
        description: 'Audit detail accordion demonstrating vertical expansion.',
        animation: DialogAnimation.expandVertical,
        category: 'Transform',
        icon: Icons.view_headline_rounded,
        accentColor: AppColors.info,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const DemoAdaptivePanel(
          widthFactor: 0.6,
          child: CenterReminderCard(),
        ),
      ),

      ExampleScenario(
        title: 'Master Data Inspector',
        description: 'Master-data inspector expanding horizontally from the center.',
        animation: DialogAnimation.expandHorizontal,
        category: 'Transform',
        icon: Icons.unfold_more_rounded,
        accentColor: AppColors.info,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const DemoAdaptivePanel(
          widthFactor: 0.6,
          child: FilterPanel(),
        ),
      ),

      ExampleScenario(
        title: 'Process Step Menu',
        description: 'Process-step navigation expanding across the workspace.',
        animation: DialogAnimation.expandHorizontal,
        category: 'Transform',
        icon: Icons.menu_open_rounded,
        accentColor: AppColors.accent,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const CenterReminderCard(),
      ),

      ExampleScenario(
        title: 'Table Action Toolbar',
        description: 'ERP table action toolbar expanding horizontally.',
        animation: DialogAnimation.expandHorizontal,
        category: 'Transform',
        icon: Icons.build_rounded,
        accentColor: const Color(0xFF7C5CFC),
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const DemoAdaptivePanel(
          widthFactor: 0.5,
          child: FilterPanel(),
        ),
      ),

      ExampleScenario(
        title: 'Document Review Modal',
        description: 'Document review modal expanding uniformly from the center.',
        animation: DialogAnimation.expandCenter,
        category: 'Transform',
        icon: Icons.zoom_out_map_rounded,
        accentColor: AppColors.primary,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      ExampleScenario(
        title: 'Attachment Overlay',
        description: 'Attachment overlay using a smooth center expansion.',
        animation: DialogAnimation.expandCenter,
        category: 'Transform',
        icon: Icons.attach_file_rounded,
        accentColor: const Color(0xFF1DB88A),
        barrierColor: const Color(0x8C000000),
        barrierBlur: 5,
        barrierDismissible: true,
        builder: (context) => const DemoAdaptivePanel(
          widthFactor: 0.55,
          child: RoadmapCard(),
        ),
      ),

      ExampleScenario(
        title: 'Transaction Detail Zoom',
        description: 'Transaction details zooming into a focused review surface.',
        animation: DialogAnimation.expandCenter,
        category: 'Transform',
        icon: Icons.fullscreen_rounded,
        accentColor: AppColors.accent,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      // ========================================================================
      // FLIP ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'Document Side Review',
        description: 'Document summary flipping to reveal secondary information.',
        animation: DialogAnimation.flipHorizontal,
        category: 'Transform',
        icon: Icons.flip_rounded,
        accentColor: AppColors.accent,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      ExampleScenario(
        title: 'Sensitive Data Reveal',
        description: 'Sensitive business information revealed with a top-bottom flip.',
        animation: DialogAnimation.flipHorizontal,
        category: 'Transform',
        icon: Icons.info_rounded,
        accentColor: AppColors.info,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const DemoAdaptivePanel(
          widthFactor: 0.5,
          child: CenterReminderCard(),
        ),
      ),

      ExampleScenario(
        title: 'KPI Counter Update',
        description: 'KPI counter update demonstrated with a flip transition.',
        animation: DialogAnimation.flipHorizontal,
        category: 'Transform',
        icon: Icons.timer_rounded,
        accentColor: const Color(0xFF7C5CFC),
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const CenterCountdownCard(),
      ),

      ExampleScenario(
        title: 'Policy Page Review',
        description: 'Policy page review using a vertical-axis page transition.',
        animation: DialogAnimation.flipVertical,
        category: 'Transform',
        icon: Icons.flip_rounded,
        accentColor: const Color(0xFFEF4444),
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      ExampleScenario(
        title: 'Vendor Card Review',
        description: 'Vendor record card revealing its reverse side.',
        animation: DialogAnimation.flipVertical,
        category: 'Transform',
        icon: Icons.style_rounded,
        accentColor: AppColors.success,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const StatusNotificationDialog(),
      ),

      ExampleScenario(
        title: 'Contract Page Review',
        description: 'Contract page review using a book-style turn effect.',
        animation: DialogAnimation.flipVertical,
        category: 'Transform',
        icon: Icons.menu_book_rounded,
        accentColor: const Color(0xFF1DB88A),
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const DemoAdaptivePanel(
          widthFactor: 0.5,
          child: RoadmapCard(),
        ),
      ),

      // ========================================================================
      // COMBINED ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'Mobile Document Actions',
        description: 'Mobile document actions sliding upward with subtle rotation.',
        animation: DialogAnimation.slideRotateBottom,
        category: 'Transform',
        icon: Icons.phonelink_rounded,
        accentColor: AppColors.primary,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const BottomQuickAssignSheet(),
      ),

      ExampleScenario(
        title: 'Exception Resolution Sheet',
        description: 'Exception resolution sheet combining upward slide and rotation.',
        animation: DialogAnimation.slideRotateBottom,
        category: 'Transform',
        icon: Icons.auto_awesome_rounded,
        accentColor: AppColors.accent,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const TimeOffDetailsDialog(
          alignment: Alignment.bottomCenter,
          widthFactor: 0.6,
        ),
      ),

      ExampleScenario(
        title: 'Mobile ERP Menu',
        description: 'Mobile ERP navigation menu using a rotation transition.',
        animation: DialogAnimation.slideRotateBottom,
        category: 'Transform',
        icon: Icons.smartphone_rounded,
        accentColor: AppColors.info,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const BottomQuickAssignSheet(),
      ),

      ExampleScenario(
        title: 'Batch Completion Notice',
        description: 'Batch completion notice sliding down with rotation.',
        animation: DialogAnimation.slideRotateTop,
        category: 'Transform',
        icon: Icons.notifications_rounded,
        accentColor: AppColors.warning,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const TopAnnouncementBanner(widthFactor: 0.7),
      ),

      ExampleScenario(
        title: 'System Control Alert',
        description: 'System control alert shown as a rotating top banner.',
        animation: DialogAnimation.slideRotateTop,
        category: 'Transform',
        icon: Icons.priority_high_rounded,
        accentColor: AppColors.error,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const TopMiniAlert(),
      ),

      ExampleScenario(
        title: 'Operational Broadcast',
        description: 'Operational broadcast banner with a rotation transition.',
        animation: DialogAnimation.slideRotateTop,
        category: 'Transform',
        icon: Icons.campaign_outlined,
        accentColor: const Color(0xFFEF4444),
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const TopAnnouncementBanner(widthFactor: 0.65),
      ),

      ExampleScenario(
        title: 'Module Navigation Panel',
        description: 'ERP module navigation entering from the start edge with scale.',
        animation: DialogAnimation.slideScaleStart,
        category: 'Transform',
        icon: Icons.dashboard_rounded,
        accentColor: AppColors.primary,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        constraints: const BoxConstraints(maxWidth: 720),
        builder: (context) =>
            const AddTimeOffDialog(alignment: Alignment.centerLeft),
      ),

      ExampleScenario(
        title: 'Company Navigation Menu',
        description: 'Company navigation menu entering smoothly from the start edge.',
        animation: DialogAnimation.slideScaleStart,
        category: 'Transform',
        icon: Icons.menu_book_rounded,
        accentColor: AppColors.info,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const DemoAdaptivePanel(
          widthFactor: 0.5,
          alignment: AlignmentDirectional.centerStart,
          child: FilterPanel(),
        ),
      ),

      ExampleScenario(
        title: 'Worklist Filters',
        description: 'ERP worklist filters sliding in with scale.',
        animation: DialogAnimation.slideScaleStart,
        category: 'Transform',
        icon: Icons.filter_alt_rounded,
        accentColor: AppColors.accent,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const DemoAdaptivePanel(
          widthFactor: 0.4,
          alignment: AlignmentDirectional.centerStart,
          child: FilterPanel(),
        ),
      ),

      ExampleScenario(
        title: 'Posting Settings',
        description: 'Posting settings entering from the end edge with scale.',
        animation: DialogAnimation.slideScaleEnd,
        category: 'Transform',
        icon: Icons.settings_rounded,
        accentColor: AppColors.accent,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        constraints: const BoxConstraints(maxWidth: 720),
        builder: (context) =>
            const AddTimeOffDialog(alignment: Alignment.centerRight),
      ),

      ExampleScenario(
        title: 'Transaction Detail View',
        description: 'Transaction detail inspector entering from the end edge.',
        animation: DialogAnimation.slideScaleEnd,
        category: 'Transform',
        icon: Icons.article_rounded,
        accentColor: AppColors.success,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const DemoAdaptivePanel(
          widthFactor: 0.5,
          alignment: AlignmentDirectional.centerEnd,
          child: AnalyticsPanel(),
        ),
      ),

      ExampleScenario(
        title: 'Employee Master Record',
        description: 'Employee master-data sidebar using a scale entrance.',
        animation: DialogAnimation.slideScaleEnd,
        category: 'Transform',
        icon: Icons.account_circle_rounded,
        accentColor: const Color(0xFF7C5CFC),
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const DemoAdaptivePanel(
          widthFactor: 0.45,
          alignment: AlignmentDirectional.centerEnd,
          child: AnalyticsPanel(),
        ),
      ),
    ];
  }
}
