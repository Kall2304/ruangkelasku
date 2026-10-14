import 'package:material_ui/material_ui.dart';

import '../copy/strings.dart';
import '../layout/breakpoints.dart';
import '../theme/tokens.dart';

class AdaptiveDestination {
  const AdaptiveDestination({required this.icon, required this.selectedIcon, required this.label, required this.path});

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String path;
}

/// Navigasi global berganti menurut lebar: drawer (Compact), rail (Medium),
/// rail diperluas (Expanded), drawer permanen (Large).
class AdaptiveScaffold extends StatelessWidget {
  const AdaptiveScaffold({
    super.key,
    required this.title,
    required this.body,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.actions = const [],
    this.floatingActionButton,
  });

  final Widget title;
  final Widget body;
  final List<AdaptiveDestination> destinations;

  /// `null` bila halaman ini tidak ada di daftar tujuan.
  final int? selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<Widget> actions;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final size = context.windowSize;
    final content = Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Sizes.contentMaxWidth),
        child: body,
      ),
    );
    final appBar = AppBar(title: title, actions: actions, automaticallyImplyLeading: size.isCompact);

    if (size.isCompact) {
      return Scaffold(
        appBar: appBar,
        drawer: _drawer(context, closeOnSelect: true),
        body: content,
        floatingActionButton: floatingActionButton,
      );
    }

    final Widget navigation = switch (size) {
      WindowSize.large => SizedBox(width: Sizes.navDrawerWidth, child: _drawer(context, closeOnSelect: false)),
      _ => NavigationRail(
        extended: size == WindowSize.expanded,
        labelType: size == WindowSize.expanded ? NavigationRailLabelType.none : NavigationRailLabelType.all,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: [
          for (final d in destinations)
            NavigationRailDestination(icon: Icon(d.icon), selectedIcon: Icon(d.selectedIcon), label: Text(d.label)),
        ],
      ),
    };

    return Scaffold(
      body: Row(
        children: [
          navigation,
          const VerticalDivider(width: 1),
          Expanded(
            child: Scaffold(appBar: appBar, body: content, floatingActionButton: floatingActionButton),
          ),
        ],
      ),
    );
  }

  Widget _drawer(BuildContext context, {required bool closeOnSelect}) {
    final theme = Theme.of(context);
    return NavigationDrawer(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        if (closeOnSelect) Navigator.of(context).pop();
        onDestinationSelected(index);
      },
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Space.xxl, Space.xl, Space.lg, Space.lg),
          child: Text(S.appName, style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary)),
        ),
        for (final d in destinations)
          NavigationDrawerDestination(icon: Icon(d.icon), selectedIcon: Icon(d.selectedIcon), label: Text(d.label)),
      ],
    );
  }
}
