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
        field(4; "Course Price"; Decimal)
        {
            Caption = 'Course Price', comment = 'ESP="Precio Curso",ENA="Preu Curs"';
            Editable = false;
            // Buscamos el precio en la tabla maestra de Cursos
            FieldClass = FlowField;
            CalcFormula = lookup("CMC Course".Price where(Code = field("Course Code")));
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