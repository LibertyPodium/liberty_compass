import 'package:flutter/material.dart';
import 'package:liberty_compass/quiz/quiz.dart';

class ResetWarningDialog extends StatefulWidget {
  final Quiz quiz;
  final Function() onAccept;

  const ResetWarningDialog({
    required this.quiz,
    required this.onAccept,
    Key? key,
  }) : super(key: key);

  @override
  ResetWarningDialogState createState() {
    return ResetWarningDialogState();
  }
}

class ResetWarningDialogState extends State<ResetWarningDialog> {

  void handleClose(BuildContext context) {
    Navigator.pop(context, false);
  }

  void handleAccept(BuildContext context) async {
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isMobile = mediaQuery.size.width < 600;
    final isMini = mediaQuery.size.width < 300;

    return SimpleDialog(
        elevation: 0,
        backgroundColor: const Color(0xFF262A35),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(56 / 2))
        ),
        insetPadding: EdgeInsets.all(isMini ? 16 : 24),
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
              const Text(
                'WARNING!',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
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
                  constraints: BoxConstraints(maxWidth: 420),
                  padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: isMini ? 20 : isMobile ? 32 : 48
                  ),
                  child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: SelectableText(
                              'You have not shared your quiz results. If you navigate away now you will lose all of your progress. Do you accept?',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isMobile ? 15 : 17,
                                  fontWeight: FontWeight.w300,
                                  height: 1.5
                              )
                          ),
                        ),
                        SizedBox(height: isMobile ? 24 : 32),
                        Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Container(
                                    child: ElevatedButton(
                                      onPressed: () => handleAccept(context),
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.black),
                                          foregroundColor: MaterialStateProperty.all(Colors.white),
                                          minimumSize: MaterialStateProperty.all(Size(double.infinity, 54)),
                                          shadowColor: MaterialStateProperty.all(Colors.transparent),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(100)
                                              )
                                          )
                                      ),
                                      child: const Text(
                                          'ACCEPT',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          )
                                      ),
                                    )
                                ),
                              ),
                            ]
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