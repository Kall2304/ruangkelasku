import 'package:material_ui/material_ui.dart';

import '../core/copy/strings.dart';
import '../core/widgets/ruki_view.dart';
import 'global_scaffold.dart';

/// Sementara untuk layar yang belum dibangun; diganti layar aslinya per vertical slice.
class ComingSoonBody extends StatelessWidget {
  const ComingSoonBody({super.key});

  @override
  Widget build(BuildContext context) => const RukiView(pose: RukiPose.think, message: S.comingSoon);
}

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key, required this.location, required this.title});

  final String location;
  final String title;

  @override
  Widget build(BuildContext context) =>
      GlobalScaffold(location: location, title: Text(title), body: const ComingSoonBody());
}
