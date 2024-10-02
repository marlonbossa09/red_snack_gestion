class Usuario {  
  String nombre;  
  String correo;  
  String contrasena;  
  int idEmprendimiento; // Nuevo campo  

  // Constructor  
  Usuario({  
    required this.nombre,  
    required this.correo,  
    required this.contrasena,  
    required this.idEmprendimiento, // Se añade al constructor  
  });  

  // Método para convertir a JSON  
  Map<String, dynamic> toJson() {  
    return {  
      'nombre': nombre,  
      'correo': correo,  
      'contrasena': contrasena,  
      'idEmprendimiento': idEmprendimiento, // Se añade al JSON  
    };  
  }  

  // Método para crear una instancia de Usuario desde un JSON  
  factory Usuario.fromJson(Map<String, dynamic> json) {  
    return Usuario(  
      nombre: json['nombre'],  
      correo: json['correo'],  
      contrasena: json['contrasena'],  
      idEmprendimiento: json['idEmprendimiento'], // Se añade la nueva propiedad  
    );  
  }  
}
