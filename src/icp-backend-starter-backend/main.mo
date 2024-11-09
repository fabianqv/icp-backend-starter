actor PatientLogin {

    type Patient = {
        insuranceNumber: Text;
        uniqueKey: Text;
        name: Text;
    };

    var patients : [Patient] = [
        {insuranceNumber = "123456789", uniqueKey = "clave123", name = "Juan Perez"},
        {insuranceNumber = "987654321", uniqueKey = "clave987", name = "Maria Lopez"}
    ];

    public func login(insuranceNumber: Text, password: Text) : async ?Text {
        for (patient in patients.vals()) {
            if (patient.insuranceNumber == insuranceNumber and patient.uniqueKey == password) {
                return ?("Login exitoso. Bienvenido, " # patient.name # "!");
            }
        };
        return null;
    };
};
