tableextension 50505 "CMC Customer Table Ext" extends Customer
{
    fields
    {
        field(50505; "CMC Total Courses"; Integer)
        {
            Caption = 'Total Courses', comment = 'ESP="Total Cursos",ENA="Total Cursos"';
            Editable = false;
            FieldClass = FlowField;
            // Contamos cuántas inscripciones tiene este cliente
            CalcFormula = count("CMC Course Enrollment" where("Customer No." = field("No.")));
        }

        field(50506; "CMC Total Investment"; Decimal)
        {
            Caption = 'Total Investment', comment = 'ESP="Inversión Total",ENA="Inversió Total"';
            Editable = false;
            FieldClass = FlowField;
            // Sumamos los precios de sus cursos inscritos
            CalcFormula = sum("CMC Course Enrollment"."Course Price" where("Customer No." = field("No.")));
        }
        // Campo para saber si el cliente tiene pagos pendientes
        field(50507; "CMC Unpaid Balance"; Boolean)
        {
            Caption = 'Unpaid Balance', comment = 'ESP="Impago",ENA="Impagament"';
            DataClassification = CustomerContent;
        }

        // Comentario que solo se imprimirá si el booleano anterior es TRUE
        field(50508; "CMC Notes"; Text[300])
        {
            Caption = 'Notes', comment = 'ESP="Notas",ENA="Notes"';
            DataClassification = CustomerContent;
        }
    }
}