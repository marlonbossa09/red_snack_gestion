import 'package:fl_chart/fl_chart.dart';  
import 'package:flutter/material.dart';  

class TransaccionesEstado extends StatefulWidget {
  const TransaccionesEstado({super.key});
  
  @override  
  _TransaccionesEstadoState createState() => _TransaccionesEstadoState();  
}  

class _TransaccionesEstadoState extends State<TransaccionesEstado> {  
  // Inicializamos datos de ejemplo para las transacciones  
  List<BarChartGroupData> showingBarGroups = [];  
  double maxY = 0;  

  @override  
  void initState() {  
    super.initState();  
    // Cargamos datos iniciales  
    updateData();  
  }  

  void updateData() {  
    // Aquí puedes actualizar tus datos de manera dinámica  
    // Simulando datos de transacciones  
    showingBarGroups = [  
      BarChartGroupData(  
        x: 0,  
        barRods: [  
          BarChartRodData(toY: 5, color: Colors.pink), // Transacciones para 5K  
          BarChartRodData(toY: 7, color: Colors.yellow), // Total para 7K  
        ],  
      ),  
      BarChartGroupData(  
        x: 1,  
        barRods: [  
          BarChartRodData(toY: 3, color: Colors.pink),  
          BarChartRodData(toY: 5, color: Colors.yellow),  
        ],  
      ),  
      BarChartGroupData(  
        x: 2,  
        barRods: [  
          BarChartRodData(toY: 8, color: Colors.pink),  
          BarChartRodData(toY: 9, color: Colors.yellow),  
        ],  
      ),  
      BarChartGroupData(  
        x: 3,  
        barRods: [  
          BarChartRodData(toY: 10, color: Colors.pink),  
          BarChartRodData(toY: 12, color: Colors.yellow),  
        ],  
      ),  
      // ... Añadir más datos  
    ];  

    // Calcular el máximo Y dinámicamente  
    double calculatedMaxY = showingBarGroups.fold(  
        0, (prev, group) => prev > group.barRods.map((rod) => rod.toY).reduce((a, b) => a > b ? a : b) ? prev : group.barRods.map((rod) => rod.toY).reduce((a, b) => a > b ? a : b));  

    setState(() {  
      maxY = calculatedMaxY > 5 ? calculatedMaxY : 5; // Asegúrate de que maxY sea al menos 5  
    });  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      body: SingleChildScrollView(  
        child: Container(  
          width: double.infinity,  
          height: 300,  
          padding: const EdgeInsets.all(16),  
          child: BarChart(  
            BarChartData(  
              minY: 5, // Inicia el eje Y desde 5K  
              maxY: maxY,  
              barTouchData: BarTouchData(  
                touchTooltipData: BarTouchTooltipData(  
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {  
                    final isTransaction = rod.color == Colors.pink;  
                    final value = rod.toY;  
                    return BarTooltipItem(  
                      '${isTransaction ? "Transacción" : "Total"}: ${value}K',  
                      const TextStyle(color: Colors.black),  
                    );  
                  },  
                ),  
              ),  
              titlesData: FlTitlesData(  
                show: true,  
                bottomTitles: AxisTitles(  
                  sideTitles: SideTitles(  
                    showTitles: true,  
                    reservedSize: 38,  
                    getTitlesWidget: (value, meta) {  
                      const dayNames = ['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];  
                      return Text(dayNames[value.toInt()]);  
                    },  
                  ),  
                ),  
                leftTitles: AxisTitles(  
                  sideTitles: SideTitles(  
                    showTitles: true,  
                    reservedSize: 40,  
                    getTitlesWidget: (value, meta) {  
                      return Text('${(value.toInt()).toString()}K'); // Representa en miles  
                    },  
                  ),  
                ),  
              ),  
              borderData: FlBorderData(show: false),  
              barGroups: showingBarGroups,  
              gridData: const FlGridData(show: false),  
            ),  
          ),  
        ),  
      ),  
    );  
  }  
}