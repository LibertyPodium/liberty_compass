import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Introduction extends StatelessWidget {
  final void Function() onStart;

  const Introduction({
    required this.onStart,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isMobile = mediaQuery.size.width < 600;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: isMobile ? 4 : 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText('Liberty Compass',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                )
              ),
              SelectableText('POLITICAL COMPASS QUIZ',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )
              )
            ]
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: isMobile ? 200 : 320,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/intro.png'),
                    filterQuality: FilterQuality.medium,
                    fit: BoxFit.contain
                )
            ),
          ),
          SizedBox(height: 40),
          isMobile ? Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: ConstrainedBox(
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
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)
                            )
                        )
                      ),
                    )
                  ),
                )
              ]
          ) : Container(),
          isMobile ? SizedBox(height: 32) : Container(),
          SelectableText(
              'This quiz attempts to categorize your political perspective by gauging your favorableness towards propositions of policy and governance. ' +
                  'Each proposition will have a specific bias towards one or more of the following categories:',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                  height: 1.5
              )
          ),
          SizedBox(height: 24),
          SelectableText(
              'PROGRESSIVE',
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              )
          ),
          SizedBox(height: 8),
          SelectableText(
              'Policies which tend to favor social welfare programs, or policies which favor equitable outcomes are generally considered progressive. ' +
                  'This may include policies such as universal health care, universal basic income, and lax immigration laws.',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  height: 1.5
              )
          ),
          SizedBox(height: 24),
          SelectableText(
              'CONSERVATIVE',
              style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              )
          ),
          SizedBox(height: 8),
          SelectableText(
              'Policies which tend to favor traditional values, or policies which favor economic prosperity are generally considered conservative. ' +
                  'This may include policies such as lower taxes, banning abortion, and strong immigration laws.',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  height: 1.5
              )
          ),
          SizedBox(height: 24),
          SelectableText(
              'LIBERTARIAN',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              )
          ),
          SizedBox(height: 8),
          SelectableText(
              'Policies which tend to favor individual freedom, or simply the lack of policy and governance are generally considered libertarian. ' +
                  'Many political perspectives are miscategorized as being progressive or conservative, and are actually libertarian. ' +
                  'For example, both progressives and libertarians support lax immigration laws, while both conservatives and libertarians support lower taxes.',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  height: 1.5
              )
          ),
          SizedBox(height: 48),
          Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: ConstrainedBox(
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
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)
                              )
                          )
                        ),
                      )
                  ),
                )
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
                  image: AssetImage('assets/images/github.png'),
                  height: 40,
                  filterQuality: FilterQuality.medium,
                ),
              ),
            ),
          )
        ]
    );
  }
}