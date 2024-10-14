import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/pages/chat_page.dart';
import 'package:red_snack_gestion/app/widget/appbar.dart';
import 'package:fl_chart/fl_chart.dart'; // Biblioteca para gráficos de barras

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(title: 'Home', chatPage: Chat()), // Usa tu AppBar global
      drawer: const SideMenu(), // Usa tu SideMenu ya implementado
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gráfico de barras
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text('Computadoras');
                            case 1:
                              return const Text('Móvil');
                            case 2:
                              return const Text('Tablet');
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [
                      BarChartRodData(toY: 100, color: Colors.blue),
                    ]),
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(toY: 60, color: Colors.blue),
                    ]),
                    BarChartGroupData(x: 2, barRods: [
                      BarChartRodData(toY: 20, color: Colors.blue),
                    ]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Tarjetas con ventas, gastos, ganancias
            _buildInfoCard('Ventas: 1000'),
            const SizedBox(height: 10),
            _buildInfoCard('Gastos: 500'),
            const SizedBox(height: 10),
            _buildInfoCard('Ganancias: 500'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción para agregar nueva venta o registro
        },
        // ignore: sort_child_properties_last
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Método para construir las tarjetas de información
  Widget _buildInfoCard(String text) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}


