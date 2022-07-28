import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liberty_compass/quiz/quiz.dart';
import 'package:liberty_compass/utils.dart';

class ShareResultsDialog extends StatefulWidget {
    final Quiz quiz;
    final Function(DocumentReference) onContinue;
    final Function(BuildContext) onCopy;

    const ShareResultsDialog({
        required this.quiz,
        required this.onContinue,
        required this.onCopy,
        Key? key,
    }) : super(key: key);

    @override
    ShareResultsDialogState createState() {
        return ShareResultsDialogState();
    }
}

class ShareResultsDialogState extends State<ShareResultsDialog> {
    final urlTextController = TextEditingController();

    bool savingResults = false;
    String resultsId = '';

    void handleClose(BuildContext context) {
        Navigator.pop(context);
    }

    void handleContinue() async {
        setState(() {
            savingResults = true;
        });

        final document = await widget.quiz.saveResults();

        setUrlToResultsPage(document.id);
        setState(() {
            savingResults = false;
            resultsId = document.id;
            urlTextController.value = TextEditingValue(
                text: getUrlToResultsPage(document.id)
            );
        });

        widget.onContinue(document);
    }

    void handleCopyTap(BuildContext context) {
        widget.onCopy(context);
        Navigator.pop(context);
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
                        const Text(
                            'SHARE RESULTS',
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
                            SizedBox(height: 16),
                            Container(
                                width: double.infinity,
                                height: isMini ? 140 : isMobile ? 180 : 240,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(resultsId == '' ? 'assets/images/share.png' : 'assets/images/success.png'),
                                        filterQuality: FilterQuality.medium,
                                        fit: BoxFit.contain
                                    )
                                ),
                            ),
                            SizedBox(height: isMobile ? 0 : 8),
                            Container(
                                width: double.infinity,
                                constraints: BoxConstraints(maxWidth: 420),
                                padding: EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: isMini ? 20 : isMobile ? 32 : 48
                                ),
                                child: Column(
                                    children: resultsId == ''
                                        ? [
                                            SizedBox(
                                                width: double.infinity,
                                                child: SelectableText(
                                                    'Sharing your quiz with others requires that we save your answers to our database. We do not collect or save any data other than the answers you\'ve selected. Would you like to continue?',
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
                                                    savingResults
                                                        ? CircularProgressIndicator()
                                                        : Flexible(
                                                        child: Container(
                                                            child: ElevatedButton(
                                                                onPressed: handleContinue,
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
                                                                    'CONTINUE',
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
                                        : [
                                            SizedBox(
                                                width: double.infinity,
                                                child: SelectableText(
                                                    'All set! Use the link below to access your results. There is no guarantee on how long your results may be saved for, so consider also taking a screenshot of your compass.',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: isMobile ? 15 : 17,
                                                        fontWeight: FontWeight.w300,
                                                        height: 1.5
                                                    )
                                                ),
                                            ),
                                            SizedBox(height: isMobile ? 24 : 32),
                                            Row(
                                                children: [
                                                    Expanded(
                                                        child: TextField(
                                                            autofocus: true,
                                                            readOnly: true,
                                                            controller: urlTextController,
                                                            onTap: () => handleCopyTap(context),
                                                            style: TextStyle(
                                                                color: Colors.white
                                                            ),
                                                            decoration: InputDecoration(
                                                                filled: true,
                                                                fillColor: Colors.white.withOpacity(0.33),
                                                                border: OutlineInputBorder(
                                                                    borderSide: BorderSide(width: 0),
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft: Radius.circular(100),
                                                                        bottomLeft: Radius.circular(100)
                                                                    )
                                                                )
                                                            ),
                                                        )
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: () => handleCopyTap(context),
                                                        style: ButtonStyle(
                                                            backgroundColor: MaterialStateProperty.all(Colors.black),
                                                            foregroundColor: MaterialStateProperty.all(Colors.white),
                                                            // minimumSize: MaterialStateProperty.all(Size(double.infinity, 54)),
                                                            padding: MaterialStateProperty.all(
                                                                EdgeInsets.symmetric(
                                                                    vertical: 21
                                                                )
                                                            ),
                                                            shape: MaterialStateProperty.all(
                                                                RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.only(
                                                                        topRight: Radius.circular(100),
                                                                        bottomRight: Radius.circular(100)
                                                                    )
                                                                )
                                                            )
                                                        ),
                                                        child: Center(
                                                            child: Icon(
                                                                Icons.copy,
                                                                color: Colors.white,
                                                            )
                                                        )
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