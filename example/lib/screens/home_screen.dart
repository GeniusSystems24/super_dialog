// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';
import 'package:super_navigation_sidebar/super_navigation_sidebar.dart';

import '../data/scenarios/scenarios.dart';
import '../models/models.dart';
import '../state/app_theme_controller.dart';
import '../theme/app_theme.dart';
import 'tabs/tabs.dart';

enum _ExampleDestination { erp, slide, reveal, transform, positioned }

extension on _ExampleDestination {
  String get id => switch (this) {
        _ExampleDestination.erp => 'erp-workflows',
        _ExampleDestination.slide => 'slide-panels',
        _ExampleDestination.reveal => 'reveal-surfaces',
        _ExampleDestination.transform => 'transform-dialogs',
        _ExampleDestination.positioned => 'positioned-dialogs',
      };

  String get label => switch (this) {
        _ExampleDestination.erp => 'ERP Workflows',
        _ExampleDestination.slide => 'Slide Panels',
        _ExampleDestination.reveal => 'Reveal Surfaces',
        _ExampleDestination.transform => 'Transform',
        _ExampleDestination.positioned => 'Positioned',
      };
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<ExampleScenario> _motionScenarios;
  late final List<ExampleScenario> _erpScenarios;
  late final NavigationSidebarController<_ExampleDestination> _navigation;

  _ExampleDestination _destination = _ExampleDestination.erp;

  final List<AnimationCategory> _animationCategories =
      const <AnimationCategory>[
    AnimationCategory(
      title: 'Slide',
      icon: Icons.swap_horiz_rounded,
      animations: <DialogAnimation>[
        DialogAnimation.startToEnd,
        DialogAnimation.endToStart,
      ],
    ),
    AnimationCategory(
      title: 'Reveal',
      icon: Icons.swap_vert_rounded,
      animations: <DialogAnimation>[
        DialogAnimation.topToBottom,
        DialogAnimation.bottomToTop,
      ],
    ),
    AnimationCategory(
      title: 'Transform',
      icon: Icons.blur_on_rounded,
      animations: <DialogAnimation>[
        DialogAnimation.centerScale,
        DialogAnimation.centerFade,
        DialogAnimation.rotateIn,
        DialogAnimation.rotateScale,
        DialogAnimation.bounceIn,
        DialogAnimation.bounceSlidBottom,
        DialogAnimation.elasticIn,
        DialogAnimation.elasticSlideBottom,
        DialogAnimation.expandVertical,
        DialogAnimation.expandHorizontal,
        DialogAnimation.expandCenter,
        DialogAnimation.flipHorizontal,
        DialogAnimation.flipVertical,
        DialogAnimation.slideRotateBottom,
        DialogAnimation.slideRotateTop,
        DialogAnimation.slideScaleStart,
        DialogAnimation.slideScaleEnd,
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _motionScenarios = <ExampleScenario>[
      ...SlideScenarios.getAll(),
      ...RevealScenarios.getAll(),
      ...TransformScenarios.getAll(),
    ];
    _erpScenarios = ErpScenarios.getAll();
    _navigation = NavigationSidebarController<_ExampleDestination>(
      sections: _buildNavigationSections(),
      active: _ExampleDestination.erp.id,
      expanded: const <NavNodeId>{'dialog-patterns'},
      favorites: const <NavNodeId>{'erp-workflows', 'positioned-dialogs'},
    );
  }

  List<NavSection<_ExampleDestination>> _buildNavigationSections() {
    return <NavSection<_ExampleDestination>>[
      NavSection<_ExampleDestination>(
        title: 'Workspace',
        items: <NavNode<_ExampleDestination>>[
          NavNode<_ExampleDestination>(
            id: _ExampleDestination.erp.id,
            label: _ExampleDestination.erp.label,
            code: 'ERP-HUB',
            keywords: const <String>[
              'approvals',
              'finance',
              'inventory',
              'workflow',
            ],
            icon: Icons.business_center_outlined,
            value: _ExampleDestination.erp,
            badge: NavBadge(
              '${_erpScenarios.length}',
              tone: NavBadgeTone.success,
            ),
            shortcut: const <String>['g', 'e'],
            status: NavNodeStatus.open,
          ),
        ],
      ),
      NavSection<_ExampleDestination>(
        title: 'Component showcase',
        items: <NavNode<_ExampleDestination>>[
          NavNode<_ExampleDestination>(
            id: 'dialog-patterns',
            label: 'Dialog Patterns',
            icon: Icons.layers_outlined,
            badge: NavBadge(
              '${_motionScenarios.length}',
              tone: NavBadgeTone.accent,
            ),
            children: <NavNode<_ExampleDestination>>[
              NavNode<_ExampleDestination>(
                id: _ExampleDestination.slide.id,
                label: _ExampleDestination.slide.label,
                code: 'DLG-SLIDE',
                icon: Icons.swap_horiz_rounded,
                value: _ExampleDestination.slide,
                shortcut: const <String>['g', 's'],
              ),
              NavNode<_ExampleDestination>(
                id: _ExampleDestination.reveal.id,
                label: _ExampleDestination.reveal.label,
                code: 'DLG-REVEAL',
                icon: Icons.swap_vert_rounded,
                value: _ExampleDestination.reveal,
                shortcut: const <String>['g', 'r'],
              ),
              NavNode<_ExampleDestination>(
                id: _ExampleDestination.transform.id,
                label: _ExampleDestination.transform.label,
                code: 'DLG-XFORM',
                icon: Icons.blur_on_rounded,
                value: _ExampleDestination.transform,
                shortcut: const <String>['g', 't'],
              ),
              NavNode<_ExampleDestination>(
                id: _ExampleDestination.positioned.id,
                label: _ExampleDestination.positioned.label,
                code: 'DLG-POS',
                icon: Icons.grid_3x3_rounded,
                value: _ExampleDestination.positioned,
                shortcut: const <String>['g', 'p'],
              ),
            ],
          ),
        ],
      ),
    ];
  }

  @override
  void dispose() {
    _navigation.dispose();
    super.dispose();
  }

  void _selectDestination(NavNode<_ExampleDestination> node) {
    final destination = node.value;
    if (destination == null || destination == _destination) return;
    setState(() => _destination = destination);
  }

  void _openScenario(ExampleScenario scenario) {
    SuperDialog.showAnimatedDialog<void>(
      context,
      scenario.builder,
      config: scenario.config,
      animation: scenario.animation,
      constraints: scenario.constraints,
      barrierDismissible: scenario.barrierDismissible,
      barrierColor: scenario.barrierColor,
      barrierBlur: scenario.barrierBlur,
      onDismissed: scenario.onDismissed == null
          ? null
          : () => scenario.onDismissed!(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mode = const NavSidebarBreakpoints().modeFor(
              constraints.maxWidth,
            );
            return NavShortcutBinder<_ExampleDestination>(
              controller: _navigation,
              onNavigate: _selectDestination,
              child: NavigationShell<_ExampleDestination>(
                controller: _navigation,
                mode: mode,
                paneBehavior: NavPaneBehavior.push,
                contentPadding: EdgeInsets.zero,
                sidebarBuilder: _buildSidebar,
                body: _buildShellBody(mode),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildShellBody(NavSidebarMode mode) {
    final page = _buildDestinationView();
    if (mode != NavSidebarMode.drawer) return page;

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(top: 56),
            child: page,
          ),
        ),
        PositionedDirectional(
          top: AppSpacing.sm,
          start: AppSpacing.sm,
          child: _CompactShellControls(
            onOpenNavigation: _navigation.openDrawer,
          ),
        ),
      ],
    );
  }

  Widget _buildSidebar(BuildContext context, NavSidebarMode mode) {
    return NavigationSidebar<_ExampleDestination>(
      controller: _navigation,
      mode: mode,
      header: (context, collapsed) => _SidebarHeader(collapsed: collapsed),
      footer: (context, collapsed) => _SidebarFooter(collapsed: collapsed),
      showGuides: true,
      railFlyouts: true,
      shortcutMode: NavShortcutMode.onHover,
      allowSearchDialog: true,
      searchHint: 'Search screen, code, or keyword',
      favoritable: true,
      aggregateBadges: true,
      quickAccessTitle: 'Quick access',
      drawerTitle: 'Example navigation',
      onNavigate: _selectDestination,
      onSearchPick: _selectDestination,
    );
  }

  Widget _buildDestinationView() {
    return IndexedStack(
      index: _destination.index,
      children: <Widget>[
        ErpWorkflowsView(
          scenarios: _erpScenarios,
          onScenarioTap: _openScenario,
        ),
        AnimationListView(
          category: _animationCategories[0],
          scenarios: _motionScenarios,
          onScenarioTap: _openScenario,
        ),
        AnimationListView(
          category: _animationCategories[1],
          scenarios: _motionScenarios,
          onScenarioTap: _openScenario,
        ),
        AnimationListView(
          category: _animationCategories[2],
          scenarios: _motionScenarios,
          onScenarioTap: _openScenario,
        ),
        const PositionedTabView(),
      ],
    );
  }
}

class _CompactShellControls extends StatelessWidget {
  const _CompactShellControls({required this.onOpenNavigation});

  final VoidCallback onOpenNavigation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      elevation: 3,
      borderRadius: BorderRadius.circular(AppRadii.card),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xs),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadii.card),
          border: Border.all(color: theme.colorScheme.outline),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: onOpenNavigation,
              tooltip: 'Open navigation',
              icon: const Icon(Icons.menu_rounded, size: 20),
            ),
            IconButton(
              onPressed: toggleAppTheme,
              tooltip: 'Toggle theme',
              icon: Icon(
                theme.brightness == Brightness.dark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                size: 19,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarHeader extends StatelessWidget {
  const _SidebarHeader({required this.collapsed});

  final bool collapsed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(collapsed ? AppSpacing.sm : AppSpacing.lg),
      child: collapsed
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _BrandMark(color: theme.colorScheme.primary, size: 36),
                const SizedBox(height: AppSpacing.sm),
                IconButton(
                  onPressed: toggleAppTheme,
                  tooltip: 'Toggle theme',
                  icon: Icon(
                    theme.brightness == Brightness.dark
                        ? Icons.light_mode_outlined
                        : Icons.dark_mode_outlined,
                    size: 18,
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _BrandMark(color: theme.colorScheme.primary, size: 38),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Super Dialog',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'ERP pattern library',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: toggleAppTheme,
                      tooltip: 'Toggle theme',
                      icon: Icon(
                        theme.brightness == Brightness.dark
                            ? Icons.light_mode_outlined
                            : Icons.dark_mode_outlined,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                const _CompanyStatus(),
              ],
            ),
    );
  }
}

class _SidebarFooter extends StatelessWidget {
  const _SidebarFooter({required this.collapsed});

  final bool collapsed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (collapsed) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Center(
          child: Tooltip(
            message: 'ERP Administrator',
            child: _UserAvatar(),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadii.card),
          border: Border.all(color: theme.colorScheme.outline),
        ),
        child: Row(
          children: <Widget>[
            const _UserAvatar(),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ERP Administrator',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Demo workspace',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompanyStatus extends StatelessWidget {
  const _CompanyStatus();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.16),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Demo company · FY26 P07',
              style: theme.textTheme.labelSmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark({required this.color, this.size = 38});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Icon(
        Icons.layers_outlined,
        size: size * 0.52,
        color: Colors.white,
      ),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppRadii.control),
      ),
      child: Text(
        'EA',
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
