actor PatientRecord {

    type PatientInfo = {
        name: Text;
        age: Nat;
        gender: Text;
        address: Text;
        diseases: [Text];
        conditions: [Text];
        allergies: [Text];
    };

    var patients : [PatientInfo] = [];

    public func addPatient(
        name: Text, age: Nat, gender: Text, address: Text,
        diseases: [Text], conditions: [Text], allergies: [Text]
    ) : async () {
        let newPatient : PatientInfo = {
            name = name;
            age = age;
            gender = gender;
            address = address;
            diseases = diseases;
            conditions = conditions;
            allergies = allergies;
        };
        patients := Array.append(patients, [newPatient]);
    };

    public func getPatients() : async [PatientInfo] {
        return patients;
    };
};
