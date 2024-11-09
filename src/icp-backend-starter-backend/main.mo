import Array "mo:base/Array";
import Debug "mo:base/Debug";

actor AgendaCitas {
  type Cita = {
    nombre: Text;
    areaMedica: Text;
    fecha: Text;
    hora: Text;
  };

  var citas: [Cita] = [];

  public func mostrarAreasMedicas() : [Text] {
    ["Cardiología", "Dermatología", "Ginecología", "Pediatría", "Odontología"]
  };

  public func agendarCita(nombre: Text, areaMedica: Text, fecha: Text, hora: Text) : Text {
    let nuevaCita: Cita = { nombre; areaMedica; fecha; hora };
    citas := Array.append(citas, [nuevaCita]);
    "Cita agendada con éxito.\nNombre del paciente: " # nombre # "\nÁrea médica: " # areaMedica # "\nFecha: " # fecha # "\nHora: " # hora
  };

  public func obtenerCitas() : [Cita] {
    citas
  };
};

actor PatientRecord {

  type PatientInfo = {
    num_seg: Text;
    uniqueKey: Text;
    name: Text;
    age: Nat;
    gender: Text;
    address: Text;
    enfermedades: [Text];
    cirugias: [Text];
    alergias: [Text];
  };

  var patients : [PatientInfo] = [];

  public func addPatient(
    num_seg: Text, uniqueKey: Text, name: Text, age: Nat, 
    gender: Text, address: Text, enfermedades: [Text], 
    cirugias: [Text], alergias: [Text]
  ) : async Text {
    let newPatient : PatientInfo = {
      num_seg = num_seg;
      uniqueKey = uniqueKey;
      name = name;
      age = age;
      gender = gender;
      address = address;
      enfermedades = enfermedades;
      cirugias = cirugias;
      alergias = alergias;
    };
    patients := Array.append(patients, [newPatient]);
    "Datos del paciente guardados.\nNombre: " # name # "\nNúmero de seguro: " # num_seg
  };

  public func login(num_seg: Text, password: Text) : async ?Text {
    for (patient in patients.vals()) {
      if (patient.num_seg == num_seg and patient.uniqueKey == password) {
        return ?("Login exitoso. Bienvenido, " # patient.name # "!");
      }
    };
    return null;
  };

  public func getPatients() : async [PatientInfo] {
    return patients;
  };
};

actor Main {
  public func main() : async () {
    let agenda = AgendaCitas;
    let patientRecord = PatientRecord;

    Debug.print("Bienvenido al sistema de agenda médica.\n");

    // Login del paciente
    let num_seg = "123456";
    let password = "password123";
    let loginResult = await patientRecord.login(num_seg, password);

    switch (loginResult) {
      case (?successMessage) {
        Debug.print(successMessage);

        // Agendar cita
        let nombre = "Juan Pérez";
        let areasMedicas = agenda.mostrarAreasMedicas();
        let areaMedica = areasMedicas[0];  // Ejemplo: Selecciona Cardiología
        let fecha = "10/04/2023";
        let hora = "15:00";
        let resultado = agenda.agendarCita(nombre, areaMedica, fecha, hora);
        Debug.print(resultado);

        // Llenado de datos del paciente
        let addPatientResult = await patientRecord.addPatient(
          num_seg, password, nombre, 30, "Masculino", 
          "Calle Falsa 123", ["Hipertensión"], ["Apendicectomía"], ["Penicilina"]
        );
        Debug.print(addPatientResult);

        let citas = agenda.obtenerCitas();
        Debug.print(Debug.show(citas));

        let patients = await patientRecord.getPatients();
        Debug.print(Debug.show(patients));
      };
      case (_) {
        Debug.print("Login fallido. Intente nuevamente.");
      };
    };
  };
};
