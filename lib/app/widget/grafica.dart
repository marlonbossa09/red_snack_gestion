import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSampleEmprendimiento extends StatefulWidget {
  const BarChartSampleEmprendimiento({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSampleEmprendimientoState();
}

class BarChartSampleEmprendimientoState extends State<BarChartSampleEmprendimiento> {
  final double barWidth = 5;

  late List<BarChartGroupData> barGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  final Color gananciasColor = Colors.yellow[700]!;
  final Color perdidasColor = Colors.red[700]!;
  final Color avgColor = Colors.red.withOpacity(0.5);

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 1000, 500);  // Sep 1 - 15
    final barGroup2 = makeGroupData(1, 1500, 800);  // Sep 16 - 30
    final barGroup3 = makeGroupData(2, 1200, 300);  // Oct 1 - 15
    final barGroup4 = makeGroupData(3, 1700, 900);  // Oct 16 - 30

    barGroups = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
    ];

    showingBarGroups = List.of(barGroups);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Ganancias y Pérdidas',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: 2000,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        String week;
                        switch (group.x.toInt()) {
                          case 0:
                            week = 'Sep 1 - 15';
                            break;
                          case 1:
                            week = 'Sep 16 - 30';
                            break;
                          case 2:
                            week = 'Oct 1 - 15';
                            break;
                          case 3:
                            week = 'Oct 16 - 30';
                            break;
                          default:
                            week = '';
                            break;
                        }
                        return BarTooltipItem(
                          '$week\n',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: rod.toY.toString(),
                              style: const TextStyle(
                                color: Colors.yellow,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    touchCallback: (FlTouchEvent event, response) {
                      if (response == null || response.spot == null) {
                        setState(() {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(barGroups);
                        });
                        return;
                      }

                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                      setState(() {
                        if (!event.isInterestedForInteractions) {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(barGroups);
                          return;
                        }
                        showingBarGroups = List.of(barGroups);
                        if (touchedGroupIndex != -1) {
                          final avg = (showingBarGroups[touchedGroupIndex]
                                      .barRods
                                      .map((rod) => rod.toY)
                                      .reduce((a, b) => a + b)) /
                                  showingBarGroups[touchedGroupIndex].barRods.length;

                          showingBarGroups[touchedGroupIndex] =
                              showingBarGroups[touchedGroupIndex].copyWith(
                            barRods: showingBarGroups[touchedGroupIndex]
                                .barRods
                                .map((rod) => rod.copyWith(
                                      toY: avg,
                                      color: avgColor,
                                    ))
                                .toList(),
                          );
                        }
                      });
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: leftTitles,
                        reservedSize: 28,
                        interval: 500,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: showingBarGroups,
                  gridData: const FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double ganancias, double perdidas) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: ganancias,
          color: gananciasColor,
          width: barWidth,
        ),
        BarChartRodData(
          toY: perdidas,
          color: perdidasColor,
          width: barWidth,
        ),
      ],
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '0';
    } else if (value == 500) {
      text = '500';
    } else if (value == 1000) {
      text = '1K';
    } else if (value == 1500) {
      text = '1.5K';
    } else if (value == 2000) {
      text = '2K';
    } else {
      return Container();
    }
    return Text(text, style: style);
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Sep 1-15';
        break;
      case 1:
        text = 'Sep 16-30';
        break;
      case 2:
        text = 'Oct 1-15';
        break;
      case 3:
        text = 'Oct 16-30';
        break;
      default:
        text = '';
        break;
    }
    return Text(text, style: style);
  }
}
