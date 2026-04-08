import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatefulWidget {
  const CustomProgressIndicator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomProgressIndicatorState createState() =>
      _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<double> progressNotifier = ValueNotifier<double>(0.0);
  final double animationDuration = 2.0;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    progressNotifier.dispose();
  }

  void startAnimation() {
    Future.delayed(const Duration(milliseconds: 100), () {
      double progressValue = 0.0;
      const double step = 0.02;

      // Simulate the progress animation
      while (progressValue <= 1.0) {
        progressNotifier.value = progressValue;
        progressValue += step;
        Future.delayed(
            Duration(milliseconds: (animationDuration * 1000 * step).toInt()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 10,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ValueListenableBuilder<double>(
        valueListenable: progressNotifier,
        builder: (context, value, child) {
          return CustomPaint(
            painter: ProgressIndicatorPainter(progress: value),
          );
        },
      ),
    );
  }
}

class ProgressIndicatorPainter extends CustomPainter {
  final double progress;
  ProgressIndicatorPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint redPaint = Paint()..color = Colors.red;
    final Paint greenPaint = Paint()..color = Colors.green;
    final double progressWidth = progress * size.width;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, progressWidth, size.height),
      redPaint,
    );

    canvas.drawRect(
      Rect.fromLTWH(progressWidth, 0, size.width - progressWidth, size.height),
      greenPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
