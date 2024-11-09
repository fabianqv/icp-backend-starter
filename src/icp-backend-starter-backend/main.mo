import Array "mo:base/Array";

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
    ) : async () {
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
