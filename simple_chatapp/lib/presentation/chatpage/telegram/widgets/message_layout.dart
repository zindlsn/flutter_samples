import 'package:flutter/material.dart';

class InBubble extends StatelessWidget {
  final String message;
  const InBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top:5.0),
                child: CustomPaint(
                  painter: InBubbleTriangle(Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 6 / 7,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(19),
                    bottomRight: Radius.circular(19),
                    topRight: Radius.circular(19),
                  ),
                ),
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ],
        ));
  }
}

class InBubbleTriangle extends CustomPainter {
  final Color backgroundColor;
  InBubbleTriangle(this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = backgroundColor;

    var path = Path();
    path.lineTo(5, 5);
    path.lineTo(5, 0);
    path.lineTo(0, 0);
    /* path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(0, 0); */
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class OutBubble extends StatelessWidget {
  final String message;
  const OutBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            width: MediaQuery.of(context).size.width * 6 / 7,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: Colors.indigo.shade600,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(19),
                bottomLeft: Radius.circular(19),
                bottomRight: Radius.circular(19),
              ),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
        CustomPaint(painter: Triangle(Colors.indigo.shade600)),
      ],
    );
  }
}

class Triangle extends CustomPainter {
  final Color backgroundColor;
  Triangle(this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = backgroundColor;

    var path = Path();
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
