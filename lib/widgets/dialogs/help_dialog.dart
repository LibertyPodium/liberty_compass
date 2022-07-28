import 'package:flutter/material.dart';
import 'package:liberty_compass/quiz/quiz.dart';

import '../content/graph.dart';
import '../layout/section.dart';

class HelpDialog extends StatefulWidget {
  final Quiz quiz;

  const HelpDialog({
    required this.quiz,
    Key? key,
  }) : super(key: key);

  @override
  HelpDialogState createState() {
    return HelpDialogState();
  }
}

class HelpDialogState extends State<HelpDialog> {

  void handleClose(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isMobile = mediaQuery.size.width < 600;
    final isDense = mediaQuery.size.width < 400;
    final isMini = mediaQuery.size.width < 300;

    return SimpleDialog(
        elevation: 0,
        backgroundColor: const Color(0xFF262A35),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(56 / 2))
        ),
        insetPadding: const EdgeInsets.all(20),
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          padding: const EdgeInsets.only(
              left: 22
          ),
          height: 56,
          decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(56 / 2),
                  topRight: Radius.circular(56 / 2)
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'WHAT DOES IT MEAN?',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: isMini ? 16 : 18,
                    fontWeight: FontWeight.w300
                ),
              ),
              Material(
                  color: Colors.transparent,
                  child: SizedBox(
                    height: 56,
                    width: 56,
                    child: IconButton(
                        splashRadius: 56 / 2,
                        splashColor: Colors.black.withOpacity(0.33),
                        hoverColor: Colors.white.withOpacity(0.5),
                        onPressed: () => handleClose(context),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 24,
                        )
                    ),
                  )
              )
            ],
          ),
        ),
        children: [
          StatefulBuilder(builder: (context, setState) {
            return Column(
              children: [
                SizedBox(height: isMobile ? 0 : 16),
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(maxWidth: 720),
                  padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: isMini ? 20 : isMobile ? 32 : 48
                  ),
                  child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: SelectableText(
                              'Have questions about how to interpret your results? Use this guide to make sense of them. It will tell you how your responses are scored, how to read the graph, and what the various icons on the page mean.',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isMobile ? 15 : 17,
                                  fontWeight: FontWeight.w300,
                                  height: 1.5
                              )
                          ),
                        ),
                        SizedBox(height: isMobile ? 24 : 32),
                        Section(
                          title: 'Compass Graph',
                          children: [
                            SelectableText(
                                'The liberty compass is a 3-point radar graph. Each question you answer is weighted in favor of one or multiple of the 3 major categories: Conservative, Libertarian, and Progressive.',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isMobile ? 15 : 17,
                                    fontWeight: FontWeight.w300,
                                    height: 1.5
                                )
                            ),
                            SizedBox(height: isMobile ? 24 : 32),
                            Flex(
                              direction: isMobile ? Axis.vertical : Axis.horizontal,
                              children: [
                                Graph(
                                    quiz: Quiz(''),
                                    size: 160
                                ),
                                SizedBox(width: 24, height: 24,),
                                Expanded(
                                  flex: isMobile ? 0 : 1,
                                  child: SelectableText(
                                      'The more favorable you are towards a category, the further its point will be from the center. The radar will form a triangle that should point towards your most favored category.',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: isMobile ? 15 : 17,
                                          fontWeight: FontWeight.w300,
                                          height: 1.5
                                      )
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: isMobile ? 24 : 32),
                        Section(
                          title: 'Authoritarian Meter',
                          children: [
                              SelectableText(
                                  'Your authoritarian score is inferred from your responses, and is entirely opinion. It uses a simple equation which works as follows:',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isMobile ? 15 : 17,
                                      fontWeight: FontWeight.w300,
                                      height: 1.5
                                  )
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: 16,
                                  bottom: isMobile ? 20 : 28,
                                  left: isMobile ? 0 : 32
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SelectableText(
                                            'Total',
                                            style: TextStyle(
                                                color: Colors.white.withOpacity(0.66),
                                                fontSize: isMobile ? 12 : 15,
                                                fontWeight: FontWeight.w500,
                                                height: 1.5
                                            )
                                        ),
                                        SelectableText(
                                            isMini ? ' = Cons + Lib + Prog' : ' = Conservative + Libertarian + Progressive',
                                            style: TextStyle(
                                                color: Colors.white.withOpacity(0.66),
                                                fontSize: isMobile ? 12 : 15,
                                                fontWeight: FontWeight.w300,
                                                height: 1.5
                                            )
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SelectableText(
                                            'Auth',
                                            style: TextStyle(
                                                color: Colors.white.withOpacity(0.66),
                                                fontSize: isMobile ? 12 : 15,
                                                fontWeight: FontWeight.w500,
                                                height: 1.5
                                            )
                                        ),
                                        SelectableText(
                                            isMini ? ' = Cons + Prog' : ' = Conservative + Progressive',
                                            style: TextStyle(
                                                color: Colors.white.withOpacity(0.66),
                                                fontSize: isMobile ? 12 : 15,
                                                fontWeight: FontWeight.w300,
                                                height: 1.5
                                            )
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SelectableText(
                                            'Culture',
                                            style: TextStyle(
                                                color: Colors.white.withOpacity(0.66),
                                                fontSize: isMobile ? 12 : 15,
                                                fontWeight: FontWeight.w500,
                                                height: 1.5
                                            )
                                        ),
                                        SelectableText(
                                            ' = Auth × 10%',
                                            style: TextStyle(
                                                color: Colors.white.withOpacity(0.66),
                                                fontSize: isMobile ? 12 : 15,
                                                fontWeight: FontWeight.w300,
                                                height: 1.5
                                            )
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: isMobile ? 16 : 24),
                                    Row(
                                      children: [
                                        SelectableText(
                                            '(',
                                            style: TextStyle(
                                                color: Colors.white.withOpacity(0.66),
                                                fontSize: isMobile ? 12 : 15,
                                                fontWeight: FontWeight.w300,
                                                height: 1.5
                                            )
                                        ),
                                        SelectableText(
                                            'Total',
                                            style: TextStyle(
                                                color: Colors.white.withOpacity(0.66),
                                                fontSize: isMobile ? 12 : 15,
                                                fontWeight: FontWeight.w500,
                                                height: 1.5
                                            )
                                        ),
                                        SelectableText(
                                            ' / 3 ) + ',
                                            style: TextStyle(
                                                color: Colors.white.withOpacity(0.66),
                                                fontSize: isMobile ? 12 : 15,
                                                fontWeight: FontWeight.w300,
                                                height: 1.5
                                            )
                                        ),
                                        SelectableText(
                                            'Auth',
                                            style: TextStyle(
                                                color: Colors.white.withOpacity(0.66),
                                                fontSize: isMobile ? 12 : 15,
                                                fontWeight: FontWeight.w500,
                                                height: 1.5
                                            )
                                        ),
                                        SelectableText(
                                            ' - ',
                                            style: TextStyle(
                                                color: Colors.white.withOpacity(0.66),
                                                fontSize: isMobile ? 12 : 15,
                                                fontWeight: FontWeight.w300,
                                                height: 1.5
                                            )
                                        ),
                                        SelectableText(
                                            'Culture',
                                            style: TextStyle(
                                                color: Colors.white.withOpacity(0.66),
                                                fontSize: isMobile ? 12 : 15,
                                                fontWeight: FontWeight.w500,
                                                height: 1.5
                                            )
                                        ),
                                        SelectableText(
                                            ' - ',
                                            style: TextStyle(
                                                color: Colors.white.withOpacity(0.66),
                                                fontSize: isMobile ? 12 : 15,
                                                fontWeight: FontWeight.w300,
                                                height: 1.5
                                            )
                                        ),
                                        SelectableText(
                                            isMini ? 'Lib' : 'Libertarian',
                                            style: TextStyle(
                                                color: Colors.white.withOpacity(0.66),
                                                fontSize: isMobile ? 12 : 15,
                                                fontWeight: FontWeight.w500,
                                                height: 1.5
                                            )
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ),
                              Center(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth: 400
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(child: Container(
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(100),
                                                bottomLeft: Radius.circular(100)
                                            )
                                        ),
                                      )),
                                      SizedBox(width: 2),
                                      Expanded(child: Container(
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFAD65FF),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(100),
                                                bottomRight: Radius.circular(100)
                                            )
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: isMobile ? 24 : 32),
                              SelectableText(
                                  'The primary underlying hypothesis behind this opinion is that authoritarianism is tied directly to how far conservative and/or progressive someone is; the more to either of these ends means you wish to enact policy that controls the actions of others. It\'s not a moral judgement, but rather an observation.',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isMobile ? 15 : 17,
                                      fontWeight: FontWeight.w300,
                                      height: 1.5
                                  )
                              ),
                          ],
                        ),
                        SizedBox(height: isMobile ? 24 : 32),
                        Section(
                          title: 'Topics & Sentiment',
                          children: [
                            SelectableText(
                                'Each question, in addition to being weighted in favor of the aforementioned categories, may also be tied to one or more of the following topics:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isMobile ? 15 : 17,
                                    fontWeight: FontWeight.w300,
                                    height: 1.5
                                )
                            ),
                            SizedBox(height: 24),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              direction: isDense ? Axis.vertical : Axis.horizontal,
                              children: [
                                Chip(
                                    backgroundColor: Colors.white.withOpacity(0.25),
                                    label: SelectableText(
                                        'INDIVIDUAL FREEDOM',
                                        style: TextStyle(
                                            color: Colors.white.withOpacity(0.75),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            height: 1.5
                                        )
                                    ),
                                ),
                                Chip(
                                  backgroundColor: Colors.white.withOpacity(0.25),
                                  label: SelectableText(
                                      'NATIONAL SECURITY',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.75),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          height: 1.5
                                      )
                                  ),
                                ),
                                Chip(
                                  backgroundColor: Colors.white.withOpacity(0.25),
                                  label: SelectableText(
                                      'RIGHT TO BEAR ARMS',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.75),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          height: 1.5
                                      )
                                  ),
                                ),
                                Chip(
                                  backgroundColor: Colors.white.withOpacity(0.25),
                                  label: SelectableText(
                                      'IMMIGRATION',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.75),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          height: 1.5
                                      )
                                  ),
                                ),
                                Chip(
                                  backgroundColor: Colors.white.withOpacity(0.25),
                                  label: SelectableText(
                                      'PARENTAL RIGHTS',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.75),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          height: 1.5
                                      )
                                  ),
                                ),
                                Chip(
                                  backgroundColor: Colors.white.withOpacity(0.25),
                                  label: SelectableText(
                                      'FREEDOM OF SPEECH',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.75),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          height: 1.5
                                      )
                                  ),
                                ),
                                Chip(
                                  backgroundColor: Colors.white.withOpacity(0.25),
                                  label: SelectableText(
                                      'FREEDOM OF RELIGION',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.75),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          height: 1.5
                                      )
                                  ),
                                ),
                                Chip(
                                  backgroundColor: Colors.white.withOpacity(0.25),
                                  label: SelectableText(
                                      'TAXATION',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.75),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          height: 1.5
                                      )
                                  ),
                                ),
                                Chip(
                                  backgroundColor: Colors.white.withOpacity(0.25),
                                  label: SelectableText(
                                      'RECREATIONAL DRUGS',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.75),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          height: 1.5
                                      )
                                  ),
                                ),
                                Chip(
                                  backgroundColor: Colors.white.withOpacity(0.25),
                                  label: SelectableText(
                                      'MANDATORY MEDICINE',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.75),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          height: 1.5
                                      )
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: isMobile ? 24 : 32),
                            SelectableText(
                                'The sentiment score for each topic depends on whether you agree or disagree with the questions which are tied to it.',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isMobile ? 15 : 17,
                                    fontWeight: FontWeight.w300,
                                    height: 1.5
                                )
                            ),
                            SizedBox(height: 24),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.add, color: Colors.white.withOpacity(0.33), size: 20,),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.thumb_up, color: Colors.lightBlue, size: 20,),
                                  const SizedBox(width: 8),
                                  Flexible(child: SelectableText(
                                      'You agree and it positively impacts the sentiment.',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 12,
                                        height: 1.33,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                  ))
                                ]
                            ),
                            SizedBox(height: 8),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.remove, color: Colors.white.withOpacity(0.33), size: 20,),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.thumb_up, color: Colors.lightBlue, size: 20,),
                                  const SizedBox(width: 8),
                                  Flexible(child: SelectableText(
                                      'You agree and it negatively impacts the sentiment.',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 12,
                                        height: 1.33,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                  ))
                                ]
                            ),
                            SizedBox(height: 8),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.add, color: Colors.white.withOpacity(0.33), size: 20,),
                                  const SizedBox(width: 8),
                                  Icon(Icons.thumb_down, color: Colors.white.withOpacity(0.66), size: 20,),
                                  const SizedBox(width: 8),
                                  Flexible(child: SelectableText(
                                      'You disagree and it positively impacts the sentiment.',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 12,
                                        height: 1.33,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                  ))
                                ]
                            ),
                            SizedBox(height: 8),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.remove, color: Colors.white.withOpacity(0.33), size: 20,),
                                  const SizedBox(width: 8),
                                  Icon(Icons.thumb_down, color: Colors.white.withOpacity(0.66), size: 20,),
                                  const SizedBox(width: 8),
                                  Flexible(child: SelectableText(
                                      'You disagree and it negatively impacts the sentiment.',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 12,
                                        height: 1.33,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                  ))
                                ]
                            ),
                            SizedBox(height: 24),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, color: Colors.white.withOpacity(0.33), size: 20,),
                                  const SizedBox(width: 2),
                                  Icon(Icons.sentiment_satisfied, color: Colors.green, size: 28,),
                                  const SizedBox(width: 8),
                                  Flexible(child: SelectableText(
                                      'The overall sentiment is positive.',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 12,
                                        height: 1.33,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                  ))
                                ]
                            ),
                            SizedBox(height: 3),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.multiple_stop, color: Colors.white.withOpacity(0.33), size: 20,),
                                  const SizedBox(width: 2),
                                  Icon(Icons.sentiment_neutral, color: Colors.white.withOpacity(0.5), size: 28,),
                                  const SizedBox(width: 8),
                                  Flexible(child: SelectableText(
                                      'The overall sentiment is neutral.',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 12,
                                        height: 1.33,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                  ))
                                ]
                            ),
                            SizedBox(height: 3),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.remove, color: Colors.white.withOpacity(0.33), size: 20,),
                                  const SizedBox(width: 2),
                                  Icon(Icons.sentiment_dissatisfied, color: Colors.deepOrange, size: 28,),
                                  const SizedBox(width: 8),
                                  Flexible(child: SelectableText(
                                      'The overall sentiment is negative.',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 12,
                                        height: 1.33,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                  ))
                                ]
                            )
                          ],
                        ),
                        SizedBox(height: isMobile ? 0 : 16),
                      ]
                  ),
                )
              ],
            );
          })
        ]
    );
  }
}
