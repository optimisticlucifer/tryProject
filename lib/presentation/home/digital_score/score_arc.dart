// import 'package:datacoup/export.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'dart:math' as math;

// class ScoreArc extends StatefulWidget {
//   const ScoreArc({super.key});

//   @override
//   State<ScoreArc> createState() => _ScoreArcState();
// }

// class _ScoreArcState extends State<ScoreArc> with SingleTickerProviderStateMixin{

//   Animation<double> animation;
//   Animat

//   @override
//   Widget build(BuildContext context) {
//     return const CustomPaint(
//       size: Size(300, 300),
//       painter: ,
//     );
//   }
// }

// class ProgressArc extends CustomPainter{

//   bool isBackground;
//   double arc;
//   Color progressColor;

//   ProgressArc(this.arc,this.progressColor,this.isBackground);

//   @override
//   void paint(Canvas canvas,Size size){
//     final rect = Rect.fromLTRB(0, 0, 300, 300);
//     final startAngle = -math.pi;
//     final sweepAngle = arc!=null?arc:math.pi;
//     final userCenter = false;

//     final paint = Paint()
//     ..strokeCap = StrokeCap.round
//     ..color = progressColor
//     ..style = PaintingStyle.stroke
//     ..strokeWidth = 20;

//     if(isBackground){

//     }

//     canvas.drawArc(rect, startAngle, sweepAngle, userCenter, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate){
//     return true;
//   }
// }

