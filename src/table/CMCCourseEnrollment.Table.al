table 50506 "CMC Course Enrollment"
{
    DataClassification = ToBeClassified;
    Caption = 'Course Enrollment', comment = 'ESP="Inscripción Curso",ENA="Inscripció Curs"';

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            TableRelation = Customer;
            Caption = 'Customer No.', comment = 'ESP="Nº Cliente",ENA="Nº Client"';
        }
        field(2; "Course Code"; Code[20])
        {
            TableRelation = "CMC Course";
            Caption = 'Course Code', comment = 'ESP="Código Curso",ENA="Codi Curs"';
        }
        field(3; "Enrollment Date"; Date)
        {
            Caption = 'Enrollment Date', comment = 'ESP="Fecha Inscripción",ENA="Data Inscripció"';
        }
    }

    keys
    {
        // Clave primaria compuesta para evitar inscripciones duplicadas
        key(PK; "Customer No.", "Course Code")
        {
            Clustered = true;
        }
    }
}