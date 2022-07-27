import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liberty_compass/quiz/quiz.dart';

class Header extends StatelessWidget {
    final bool ready;
    final bool started;
    final Quiz quiz;
    final DocumentReference? results;
    final void Function() onStart;
    final void Function(BuildContext) onReset;

    const Header({
        required this.ready,
        required this.started,
        required this.quiz,
        required this.results,
        required this.onStart,
        required this.onReset,
        Key? key,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        final mediaQuery = MediaQuery.of(context);
        final isMobile = mediaQuery.size.width < 600;
        final isMini = mediaQuery.size.width < 300;

        final headerDecorations = !started
            ? [
                Material(
                    color: Colors.transparent,
                    child: SizedBox(
                      height: 56,
                      width: 56,
                      child: IconButton(
                          splashRadius: 56 / 2,
                          splashColor: Colors.black.withOpacity(0.33),
                          hoverColor: Colors.white.withOpacity(0.5),
                          onPressed: onStart,
                          icon: const Icon(
                            Icons.not_started_outlined,
                            color: Colors.black,
                            size: 24,
                          )
                      ),
                    )
                )
            ]
            : quiz.currentQuestion == null
                ? [
                    Material(
                        color: Colors.transparent,
                        child: SizedBox(
                            height: 56,
                            width: 56,
                            child: IconButton(
                                splashRadius: 56 / 2,
                                splashColor: Colors.black.withOpacity(0.33),
                                hoverColor: Colors.white.withOpacity(0.5),
                                onPressed: () => onReset(context),
                                icon: const Icon(
                                    Icons.restart_alt,
                                    color: Colors.black,
                                    size: 24,
                                )
                            ),
                        )
                    )
                ]
                : [
                    Text(
                        isMini ? '${quiz.currentPlace + 1}/${quiz.questions.length}' : 'Question ${quiz.currentPlace + 1}/${quiz.questions.length}',
                        style: TextStyle(
                            fontSize: isMobile ? 12 : 14,
                            fontWeight: FontWeight.w300,
                        ),
                    ),
                    SizedBox(width: isMobile ? 12 : 24)
                ];

        return SizedBox(
            width: double.infinity,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    SizedBox(width: isMobile ? 12 : 16),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => onReset(context),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Image(
                              image: AssetImage('assets/images/logo.png'),
                              height: 40,
                              filterQuality: FilterQuality.medium,
                            ),
                            SizedBox(width: isMini ? 8 : 12),
                            Text(
                                'LIBERTY COMPASS',
                                style: TextStyle(
                                  fontSize: isMini ? 16 : 18,
                                  fontWeight: FontWeight.w300,
                                )
                            ),
                          ],
                        ),
                      )
                    ),
                    Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: headerDecorations
                        )
                    )
                ]
            )
        );
    }
}