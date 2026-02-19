page 50506 "CMC Course Enrollm. Subpage"
{
    PageType = ListPart;
    SourceTable = "CMC Course Enrollment";
    Caption = 'Course Enrollments', comment = 'ESP="Inscripciones a Cursos",ENA="Inscripcions a Cursos"';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Course Code', Comment = 'ESP="Codigo curso",ENA="Codi curs"';
                }
                field("Enrollment Date"; Rec."Enrollment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enrollment Date', Comment = 'ESP="Fecha inscripción",ENA="Data inscripció"';
                }
            }
        }
    }
}