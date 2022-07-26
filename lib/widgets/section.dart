import 'package:flutter/material.dart';

class Section extends StatelessWidget {
    final String icon;
    final String title;
    final int? sentiment;
    final List<Widget> children;

    const Section({
        required this.title,
        this.icon = '',
        this.sentiment,
        this.children = const [],
        Key? key
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        final mediaQuery = MediaQuery.of(context);
        final isMobile = mediaQuery.size.width < 600;
        final iconSize = isMobile ? 40.0 : 64.0;

        final sentimentOperator = sentiment == 0
            ? Icons.multiple_stop
            : sentiment != null && sentiment! < 0
                ? Icons.remove
                : Icons.add;

        final sentimentIcon = sentiment == 0
            ? Icons.sentiment_neutral_rounded
            : sentiment != null && sentiment! < 0
                ? Icons.sentiment_dissatisfied_rounded
                : Icons.sentiment_satisfied_alt_rounded;

        final sentimentColor = sentiment == 0
            ? Colors.white.withOpacity(0.5)
            : sentiment != null && sentiment! < 0
                ? Colors.deepOrange
                : Colors.green;

        return Container(
            constraints: const BoxConstraints(
                maxWidth: 720,
                maxHeight: double.infinity
            ),
            padding: const EdgeInsets.only(right: 8),
            child: Column(
                children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                            icon.isNotEmpty ? Opacity(
                                opacity: 0.25,
                                child: Container(
                                    width: iconSize,
                                    height: iconSize,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(icon),
                                            filterQuality: FilterQuality.medium,
                                            fit: BoxFit.contain
                                        )
                                    ),
                                )
                            ) : Container(),
                            SizedBox(width: icon.isNotEmpty ? 16 : 0),
                            Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        SizedBox(
                                            height: iconSize,
                                            child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                    Expanded(child: Container(
                                                        padding: EdgeInsets.only(bottom: isMobile ? 8 : 12),
                                                        decoration: BoxDecoration(
                                                            border: Border(
                                                                bottom: BorderSide(
                                                                    color: Colors.white.withOpacity(0.33),
                                                                    width: 2.0
                                                                )
                                                            )
                                                        ),
                                                        child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: sentiment != null ? [
                                                                Expanded(
                                                                    child: SelectableText(title,
                                                                        style: const TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize: 20,
                                                                            fontWeight: FontWeight.w500,
                                                                        )
                                                                    ),
                                                                ),
                                                                Icon(
                                                                    sentimentOperator,
                                                                    color: Colors.white.withOpacity(0.33),
                                                                    size: 20,
                                                                ),
                                                                const SizedBox(width: 2),
                                                                Icon(
                                                                    sentimentIcon,
                                                                    color: sentimentColor,
                                                                    size: 28,
                                                                )
                                                            ] : [
                                                              Expanded(
                                                                child: SelectableText(title,
                                                                    style: const TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 20,
                                                                      fontWeight: FontWeight.w500,
                                                                    )
                                                                ),
                                                              ),
                                                            ]
                                                        )
                                                    ))
                                                ]
                                            )
                                        ),
                                        SizedBox(height: isMobile ? 8 : 0),
                                        ...children
                                    ]
                                )
                            )
                        ]
                    )
                ],
            )
        );
    }
}