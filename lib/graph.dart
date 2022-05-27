import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liberty_compass/quiz.dart';

class GraphPainter extends CustomPainter {
  final double size;
  final Quiz quiz;

  double get width => size;
  double get height => size * cos(30 * pi / 180);
  List<double> get center => [
    (0 + width + width / 2) / 3,
    (0 + 0 + height) / 3
  ];

  GraphPainter({
    required this.size,
    required this.quiz,
  }): super();

  void paintProgressiveSection(Canvas canvas) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(width / 2, 0)
      ..lineTo(width / 2, height / 3)
      ..lineTo(width / 2 * 0.5, height / 2)
      ..lineTo(0, 0)
      ..close();

    final paint = Paint()
      ..color = Colors.deepOrange
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  void paintConservativeSection(Canvas canvas) {
    final path = Path()
      ..moveTo(size / 2, 0)
      ..lineTo(size, 0)
      ..lineTo(size / 2 * 1.5, (size * cos(30 * pi / 180)) / 2)
      ..lineTo(size / 2, (size * cos(30 * pi / 180)) / 3)
      ..lineTo(size / 2, 0)
      ..close();

    final paint = Paint()
      ..color = Colors.lightBlue
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  void paintLibertarianSection(Canvas canvas) {
    final path = Path()
      ..moveTo(size / 2, (size * cos(30 * pi / 180)) / 3)
      ..lineTo(size / 2 * 1.5, (size * cos(30 * pi / 180)) / 2)
      ..lineTo(size / 2, (size * cos(30 * pi / 180)))
      ..lineTo(size / 2 * 0.5, (size * cos(30 * pi / 180)) / 2)
      ..lineTo(size / 2, (size * cos(30 * pi / 180)) / 3)
      ..close();

    final paint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  void paintSectionDividers(Canvas canvas) {
    final progressiveDividerPath = Path()
      ..moveTo(size / 2, (size * cos(30 * pi / 180)) / 3)
      ..lineTo(size / 2, 0)
      ..close();

    final conservativeDividerPath = Path()
      ..moveTo(size / 2, (size * cos(30 * pi / 180)) / 3)
      ..lineTo(size / 2 * 1.5, (size * cos(30 * pi / 180)) / 2)
      ..close();

    final libertarianDividerPath = Path()
      ..moveTo(size / 2, (size * cos(30 * pi / 180)) / 3)
      ..lineTo(size / 2 * 0.5, (size * cos(30 * pi / 180)) / 2)
      ..close();

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(progressiveDividerPath, paint);
    canvas.drawPath(conservativeDividerPath, paint);
    canvas.drawPath(libertarianDividerPath, paint);
  }

  void paintCentristTriangle(Canvas canvas) {
    const shrink = 5.5;

    final path = Path()
      ..moveTo(size / 2, size / shrink / 1.66)
      ..lineTo(size / 2 * 1.5 - size / shrink / 2, (size * cos(30 * pi / 180)) / 2 - (size * cos(30 * pi / 180)) / shrink / 3)
      ..lineTo(size / 2 * 0.5 + size / shrink / 2, (size * cos(30 * pi / 180)) / 2 - (size * cos(30 * pi / 180)) / shrink / 3)
      ..lineTo(size / 2, size / shrink / 1.66)
      ..close();

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  void paintTriangleOutline(Canvas canvas) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size, 0)
      ..lineTo(size / 2, size * cos(30 * pi / 180))
      ..lineTo(0, 0)
      ..close();

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 2;

    canvas.drawPath(path, paint);
  }

  void paintRadarPoints(Canvas canvas) {
    final centerX = center[0];
    final centerY = center[1];

    final progressivePercentage = quiz.score[QuizVariable.progressive]! / (quiz.questions.length * 2);
    final conservativePercentage = quiz.score[QuizVariable.conservative]! / (quiz.questions.length * 2);
    final libertarianPercentage = quiz.score[QuizVariable.libertarian]! / (quiz.questions.length * 2);

    final progressiveX = (0 - centerX) * progressivePercentage + centerX;
    final progressiveY = (0 - centerY) * progressivePercentage + centerY;
    final progressiveOffset = Offset(progressiveX, progressiveY);
    final progressivePointPaint = Paint()
      ..color = Colors.deepOrange
      ..style = PaintingStyle.fill;

    final conservativeX = (size - centerX) * conservativePercentage + centerX;
    final conservativeY = (0 - centerY) * conservativePercentage + centerY;
    final conservativeOffset = Offset(conservativeX, conservativeY);
    final conservativePointPaint = Paint()
      ..color = Colors.lightBlue
      ..style = PaintingStyle.fill;

    final libertarianX = ((width / 2) - centerX) * libertarianPercentage + centerX;
    final libertarianY = (height - centerY) * libertarianPercentage + centerY;
    final libertarianOffset = Offset(libertarianX, libertarianY);
    final libertarianPointPaint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.fill;

    final radarPath = Path()
      ..moveTo(progressiveX, progressiveY)
      ..lineTo(conservativeX, conservativeY)
      ..lineTo(libertarianX, libertarianY)
      ..lineTo(progressiveX, progressiveY)
      ..close();

    final radarFillPaint = Paint()
      ..color = const Color(0xFF262A35).withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final radarStrokePaint = Paint()
      ..color = const Color(0xFF262A35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(radarPath, radarFillPaint);
    canvas.drawPath(radarPath, radarStrokePaint);

    const variablePointRadius = 5.0;
    final variableOutlinePaint = Paint()
      ..color = const Color(0xFF262A35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(
      progressiveOffset,
      variablePointRadius,
      progressivePointPaint
    );

    canvas.drawCircle(
      progressiveOffset,
      variablePointRadius,
      variableOutlinePaint
    );

    canvas.drawCircle(
      conservativeOffset,
      variablePointRadius,
      conservativePointPaint
    );

    canvas.drawCircle(
      conservativeOffset,
      variablePointRadius,
      variableOutlinePaint
    );

    canvas.drawCircle(
      libertarianOffset,
      variablePointRadius,
      libertarianPointPaint
    );

    canvas.drawCircle(
      libertarianOffset,
      variablePointRadius,
      variableOutlinePaint
    );
  }

  void paintAuthoritarianMeter(Canvas canvas) {
    const meterWidth = 20.0;
    final meterOffset = size + size / 10;
    final height = size;
    final meterValue = quiz.authoritarianScore;

    final libertarianSectionCap = Path()..addRect(Rect.fromLTWH(meterOffset, height / 2, meterWidth, 10));
    final libertarianSection = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(meterOffset, height / 2, meterWidth, height / 2),
          Radius.circular(10)
        )
      );
    final libertarianSectionPaint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.fill;

    final authoritarianSectionCap = Path()..addRect(Rect.fromLTWH(meterOffset, height / 2 - 10, meterWidth, 10));
    final authoritarianSection = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(meterOffset, 0, meterWidth, height / 2),
          Radius.circular(10)
        )
      );
    final authoritarianSectionPaint = Paint()
      ..color = Color(0xFFAD65FF)
      ..style = PaintingStyle.fill;

    final meterDividerPath = Path()
      ..moveTo(meterOffset, height / 2)
      ..lineTo(meterOffset + meterWidth, height / 2)
      ..close();
    final meterOutlinePath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(meterOffset, 0, meterWidth, height),
          Radius.circular(10)
        )
      );
    final meterOutlinePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final radarY = height - (height * meterValue) + 2;
    final radarPath =  Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(meterOffset - 5, radarY - 10, meterWidth + 10, 10),
          Radius.circular(5)
        )
      );

    final radarStrokePaint = Paint()
      ..color = const Color(0xFF262A35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.save();
    canvas.translate(size / 10, -height / 2 - 5);
    canvas.rotate(30 * pi / 180);
    canvas.drawPath(libertarianSectionCap, libertarianSectionPaint);
    canvas.drawPath(libertarianSection, libertarianSectionPaint);
    canvas.drawPath(authoritarianSectionCap, authoritarianSectionPaint);
    canvas.drawPath(authoritarianSection, authoritarianSectionPaint);
    canvas.drawPath(meterDividerPath, meterOutlinePaint);
    canvas.drawPath(meterOutlinePath, meterOutlinePaint);
    canvas.drawPath(radarPath, radarY > height / 2 ? libertarianSectionPaint : authoritarianSectionPaint);
    canvas.drawPath(radarPath, radarStrokePaint);
    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    paintConservativeSection(canvas);
    paintLibertarianSection(canvas);
    paintProgressiveSection(canvas);
    paintSectionDividers(canvas);
    paintCentristTriangle(canvas);
    paintTriangleOutline(canvas);
    paintRadarPoints(canvas);
    paintAuthoritarianMeter(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Graph extends StatelessWidget {
  final Quiz quiz;

  const Graph({
    required this.quiz,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isMobile = mediaQuery.size.width < 600;
    final size = isMobile ? 250.0 : 380.0;

    return Container(
      width: size + (isMobile ? 64 : 128),
      child: UnconstrainedBox(
        alignment: Alignment.topLeft,
        child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flex(
                      direction: Axis.horizontal,
                      children: [
                        SizedBox(
                            width: size,
                            child: Wrap(
                                children: [
                                  Flex(
                                      direction: Axis.horizontal,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Stack(
                                          children: [
                                            Text(isMobile ? 'PROG.' : 'PROGRESSIVE',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.deepOrange,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Text(isMobile ? 'CONS.' : 'CONSERVATIVE',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.lightBlue,
                                              ),
                                            ),
                                          ],
                                        )
                                      ]
                                  )
                                ]
                            )
                        ),
                        Transform(
                            transform: isMobile ? Matrix4.translationValues(16, 14, 0) : Matrix4.translationValues(18, 18, 0),
                            child: Stack(
                              children: [
                                Text(isMobile ? 'AUTH.' : 'AUTHORITARIAN',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFFAD65FF),
                                  ),
                                ),
                              ],
                            )
                        )
                      ]
                  ),
                  SizedBox(height: 12),
                  Container(
                      width: size + 32,
                      height: size * cos(30 * pi / 180) + 20,
                      child: CustomPaint(
                        painter: GraphPainter(
                            size: size,
                            quiz: quiz
                        ),
                      )
                  ),
                  SizedBox(
                      width: size,
                      child: Center(
                          child: Transform(
                            transform: isMobile ? Matrix4.translationValues(-0, -5, 0) : Matrix4.translationValues(-30, -8, 0),
                            child: Stack(
                              children: [
                                Text(isMobile ? 'LIB.' : 'LIBERTARIAN',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.amber,
                                  ),
                                ),
                              ],
                            ),
                          )
                      )
                  )
                ]
            )
        )
      )
    );
  }
}
