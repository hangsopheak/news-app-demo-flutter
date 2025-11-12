
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:news_app_demo_flutter/l10n/app_localizations.dart';

class SectionTitleBarWidget extends StatelessWidget {
  const SectionTitleBarWidget({super.key, required this.title, this.onSeeMoreClicked});

  final String title;
  final VoidCallback? onSeeMoreClicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            GestureDetector(
              onTap: onSeeMoreClicked,
              child: Text(
                AppLocalizations.of(context)!.see_more,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )

          ]
        )
    );

  }
}

// run command flutter widget-preview start
@Preview(name: 'Section Title Bar')
Widget SectionTitleBarPreview() {
  return SectionTitleBarWidget(title: 'Breaking News');
}
