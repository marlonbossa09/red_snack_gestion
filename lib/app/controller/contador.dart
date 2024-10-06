class Contador {
  // Método para calcular ganancias
  static double calcularGanancias(double ingresos, double costos) {
    return ingresos - costos;
  }

  // Método para calcular costos de producción
  static double calcularCostosProduccion(double materiaPrima, double manoDeObra, double otrosCostos) {
    return materiaPrima + manoDeObra + otrosCostos;
  }

  // Método escalable para agregar futuras funciones
  // Se pueden añadir más métodos estáticos según las necesidades de la app
}
