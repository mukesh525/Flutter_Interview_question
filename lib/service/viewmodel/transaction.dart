import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

Random random = Random();
List<FlSpot> totalReceived = List.generate(
    7, (index) => FlSpot(index.toDouble(), random.nextInt(10) * 100.0));
List<FlSpot> totalRedeem = List.generate(
    7, (index) => FlSpot(index.toDouble(), random.nextInt(10) * 100.0));


