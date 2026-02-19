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
    }
}