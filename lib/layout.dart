import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:liberty_compass/answer.dart';
import 'package:liberty_compass/graph.dart';
import 'package:liberty_compass/quiz.dart';
import 'package:url_launcher/url_launcher_string.dart';

final GlobalKey genKey = GlobalKey();

class Layout extends StatelessWidget {
  final Quiz quiz;
  final int cursor;
  final bool started;
  final void Function() onStart;
  final void Function(Answer) onAnswerSelect;
  final void Function(Answer) onAnswerSubmit;
  final Answer? selectedAnswer;

  const Layout({
    required this.quiz,
    required this.cursor,
    required this.started,
    required this.onStart,
    required this.onAnswerSubmit,
    required this.onAnswerSelect,
    required this.selectedAnswer,
    Key? key,
  }) : super(key: key);

  Future<void> saveOrCopyGraphImage() async {
    final boundary = genKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    final image = await boundary?.toImage();
    final byteData = await image?.toByteData(format: ImageByteFormat.png);
    final uInt8List = byteData?.buffer.asUint8List();

    if (kIsWeb) {
      final blob = html.Blob([uInt8List], 'image/png');
      final file = html.File([blob], 'liberty_compass.png');

      js.context.callMethod('saveAs', [file]);
    } else {
      // Pasteboard.writeImage(byteData?.buffer.asUint8List());
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isMobile = mediaQuery.size.width < 600;
    final question = cursor == quiz.questions.length ? null : quiz.questions[cursor];

    if (!started) {
      return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: double.infinity,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              children: const [
                Image(
                  image: AssetImage('assets/liberty_silhouette.png'),
                  height: 40,
                  filterQuality: FilterQuality.medium,
                ),
                Text(
                  'LIBERTY COMPASS',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  )
                )
              ]
            )
          ),
          shadowColor: Colors.transparent,
        ),
        body: Container(
          color: Color(0xFF262A35),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 640,
                      ),
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(32),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Liberty Compass',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 32,
                                            fontWeight: FontWeight.w500,
                                          )
                                      ),
                                      Text('POLITICAL COMPASS QUIZ',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.5),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          )
                                      )
                                    ]
                                ),
                                SizedBox(height: 32),
                                isMobile ? Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth: 320,
                                        ),
                                        child: ElevatedButton(
                                          onPressed: onStart,
                                          child: const Text(
                                              'START QUIZ',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300,
                                              )
                                          ),
                                          style: ButtonStyle(
                                            minimumSize: MaterialStateProperty.all(Size(double.infinity, 54)),
                                            shadowColor: MaterialStateProperty.all(Colors.transparent),
                                          ),
                                        )
                                    ),
                                  ]
                                ) : Container(),
                                isMobile ? SizedBox(height: 32) : Container(),
                                Text(
                                    'This quiz attempts to categorize your political perspective by gauging your favorableness towards propositions of policy and governance. ' +
                                    'Each proposition will have a specific bias towards one or more of the following categories:',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        height: 1.5
                                    )
                                ),
                                SizedBox(height: 24),
                                Text(
                                    'PROGRESSIVE',
                                    style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                    )
                                ),
                                SizedBox(height: 8),
                                Text(
                                    'Policies which tend to favor social welfare programs, or policies which favor equitable outcomes are generally considered progressive. ' +
                                    'This may include policies such as universal health care, universal basic income, and lax immigration laws.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                        height: 1.5
                                    )
                                ),
                                SizedBox(height: 24),
                                Text(
                                    'CONSERVATIVE',
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                    )
                                ),
                                SizedBox(height: 8),
                                Text(
                                    'Policies which tend to favor traditional values, or policies which favor economic prosperity are generally considered conservative. ' +
                                    'This may include policies such as lower taxes, banning abortion, and strong immigration laws.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                        height: 1.5
                                    )
                                ),
                                SizedBox(height: 24),
                                Text(
                                    'LIBERTARIAN',
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                    )
                                ),
                                SizedBox(height: 8),
                                Text(
                                    'Policies which tend to favor individual freedom, or simply the lack of policy and governance are generally considered libertarian. ' +
                                        'Many political perspectives are miscategorized as being progressive or conservative, and are actually libertarian. ' +
                                        'For example, both progressives and libertarians support lax immigration laws, while both conservatives and libertarians support lower taxes.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                        height: 1.5
                                    )
                                ),
                                SizedBox(height: 24),
                                Text(
                                    'Disclaimer: This is not a survey; none of your information or responses are being collected.',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.66),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                        height: 1.5
                                    )
                                ),
                                SizedBox(height: 48),
                                Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: 320,
                                          ),
                                          child: ElevatedButton(
                                            onPressed: onStart,
                                            child: const Text(
                                                'START QUIZ',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300,
                                                )
                                            ),
                                            style: ButtonStyle(
                                              minimumSize: MaterialStateProperty.all(Size(double.infinity, 54)),
                                              shadowColor: MaterialStateProperty.all(Colors.transparent),
                                            ),
                                          )
                                      ),
                                    ]
                                ),
                                SizedBox(height: 48),
                                Center(
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        launchUrlString('https://github.com/fyrware/liberty_compass');
                                      },
                                      child: Image(
                                        image: AssetImage('assets/github_logo.png'),
                                        height: 40,
                                        filterQuality: FilterQuality.medium,
                                      ),
                                    ),
                                  ),
                                )
                              ]
                          )
                      )
                  ),
                ]
            ),
          )
        )
      );
    }

    if (question == null) {
      return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: double.infinity,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              children: const [
                Image(
                  image: AssetImage('assets/liberty_silhouette.png'),
                  height: 40,
                  filterQuality: FilterQuality.medium,
                ),
                Text('LIBERTY COMPASS',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  )
                )
              ]
            )
          ),
          shadowColor: Colors.transparent,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xFF262A35),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 640,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Liberty Compass',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                )
                              ),
                              Text('POLITICAL COMPASS QUIZ',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                )
                              ),
                            ]
                          )
                        ),
                        SizedBox(height: 48),
                        Center(
                          child: RepaintBoundary(
                            key: genKey,
                            child: Graph(quiz: quiz)
                          )
                        ),
                        SizedBox(height: 48),
                        Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 320,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: saveOrCopyGraphImage,
                                    child: const Text(
                                        kIsWeb ? 'SAVE IMAGE' : 'COPY IMAGE',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                        )
                                    ),
                                    style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(Size(double.infinity, 54)),
                                      shadowColor: MaterialStateProperty.all(Colors.transparent),
                                    ),
                                  )
                              ),
                            ]
                        ),
                      ]
                    )
                  )
                ),
              ],
            )
          )
        )
      );
    }

    // LinearProgressIndicator(
    //   value: cursor / quiz.questions.length,
    //   backgroundColor: Color(0xFF262A35),
    //   color: Colors.white.withOpacity(0.4),
    //   minHeight: 5,
    // ),

    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/liberty_silhouette.png'),
                height: 40,
                filterQuality: FilterQuality.medium,
              ),
              SizedBox(width: 12),
              Text('LIBERTY COMPASS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                )
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Question ${cursor + 1}/${quiz.questions.length}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ]
                )
              )
            ]
          )
        ),
        shadowColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFF262A35),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 640,
                ),
                child: Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.content,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 24),
                      ...question.answers.map((answer) => Material(
                          color: Colors.transparent,
                          child: ListTile(
                            visualDensity: VisualDensity.compact,
                            tileColor: Colors.transparent,
                            hoverColor: Colors.white.withOpacity(0.166),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            title: Text(
                                answer.content,
                                style: TextStyle(
                                  color: answer == selectedAnswer ? Colors.white : Colors.white.withOpacity(0.9),
                                  fontWeight: answer == selectedAnswer ? FontWeight.w500 : FontWeight.w300,
                                )
                            ),
                            leading: Radio(
                              value: answer,
                              groupValue: selectedAnswer,
                              onChanged: (void value) => onAnswerSelect(answer),
                              fillColor: answer == selectedAnswer
                                  ? MaterialStateProperty.all(Colors.amber)
                                  : MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.5)),
                              overlayColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.166)),
                            ),
                            onTap: () => onAnswerSelect(answer),
                          )
                      )),
                      const SizedBox(height: 24),
                      Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 320,
                          ),
                          child: ElevatedButton(
                            onPressed: selectedAnswer != null ? () => onAnswerSubmit(selectedAnswer!) : null,
                            child: const Text(
                              'NEXT QUESTION',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              )
                            ),
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(double.infinity, 54)),
                              shadowColor: MaterialStateProperty.all(Colors.transparent),
                              backgroundColor: MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.white.withOpacity(0.166);
                                }
                                return Colors.amber;
                              }),
                            ),
                          )
                        ),
                      )
                    ],
                  ),
                )
              )
            ]
          ),
        ),
      )
    );
  }
}