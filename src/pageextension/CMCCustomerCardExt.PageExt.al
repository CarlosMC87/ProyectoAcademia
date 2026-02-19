pageextension 50505 "CMC Customer Card Ext" extends "Customer Card"
{
    layout
    {
        //Añadimos los cursos al final de la ficha del cliente
        addlast(Content)
        {
            part(CourseEnrollments; "CMC Course Enrollm. Subpage")
            {
                ApplicationArea = All;
                //Conectamos el Nº de Cliente de la subpágina con el Nº de la ficha actual
                SubPageLink = "Customer No." = field("No.");
            }
        }

        addlast(General)
        {
            group("CMC AcademySummary")
            {
                Caption = 'Academy Summary', comment = 'ESP="Resumen Academia",ENA="Resum Acadèmia"';

                //Usamos variables en lugar de campos Rec
                field(TotalCoursesVar; TotalCoursesVar)
                {
                    ApplicationArea = All;
                    Caption = 'Total Courses', comment = 'ESP="Total Cursos",ENA="Total Cursos"';
                    ToolTip = 'Total number of courses enrolled', comment = 'ESP="Número total de cursos inscritos",ENA="Número total de cursos inscrits"';
                    Editable = false;
                }
                field(TotalInvestmentVar; TotalInvestmentVar)
                {
                    ApplicationArea = All;
                    Caption = 'Total Investment', comment = 'ESP="Inversión Total",ENA="Inversió Total"';
                    ToolTip = 'Total amount invested in training', comment = 'ESP="Total invertido en formación",ENA="Total invertit en formació"';
                    Editable = false;
                }
            }
        }
    }
    var
        TotalCoursesVar: Integer;
        TotalInvestmentVar: Decimal;

    //Este trigger se ejecuta cada vez que cambias de cliente o abres la ficha
    trigger OnAfterGetRecord()
    begin
        CalculateAcademyStats();
    end;

    local procedure CalculateAcademyStats()
    var
        CourseEnrollment: Record "CMC Course Enrollment";
    begin
        //Reset de variables
        TotalCoursesVar := 0;
        TotalInvestmentVar := 0;

        //Filtramos las inscripciones de este cliente
        CourseEnrollment.SetRange("Customer No.", Rec."No.");

        if CourseEnrollment.FindSet() then
            repeat
                TotalCoursesVar += 1;
                //Calculamos el precio (esto es más seguro que el FlowField anterior)
                TotalInvestmentVar += GetCoursePrice(CourseEnrollment."Course Code");
            until CourseEnrollment.Next() = 0;
    end;

    local procedure GetCoursePrice(CourseCode: Code[20]): Decimal
    var
        Course: Record "CMC Course";
    begin
        if Course.Get(CourseCode) then
            exit(Course.Price);
        exit(0);
    end;
}