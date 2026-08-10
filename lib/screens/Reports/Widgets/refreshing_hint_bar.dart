import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';


/// A sliver-thin progress line, not a full spinner. Used by every report
/// card during a refetch so old data stays fully visible underneath —
/// nothing gets torn down and rebuilt from scratch, it just gets a subtle
/// "this is updating" hint until the new numbers swap in.
class RefreshingHintBar extends StatelessWidget {
  final bool isRefreshing;

  const RefreshingHintBar({super.key, required this.isRefreshing});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return AnimatedOpacity(
      opacity: isRefreshing ? 1 : 0,
      duration: const Duration(milliseconds: 150),
      child: SizedBox(
        height: 2,
        child: LinearProgressIndicator(
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation(colors.primary),
        ),
      ),
    );
  }
}
