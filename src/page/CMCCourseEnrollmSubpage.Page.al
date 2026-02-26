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
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Customer No.', Comment = 'ESP="Nº Cliente",ENA="Nº Client"';
                }

                field("Course Price"; Rec."Course Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Course Price', Comment = 'ESP="Precio Curso",ENA="Preu Curs"';
                }
                field("Enrollment Date"; Rec."Enrollment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enrollment Date', Comment = 'ESP="Fecha inscripción",ENA="Data inscripció"';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            // Este 'group' es el que crea el desplegable
            group(CMCAcademyActions)
            {
                Caption = 'More Actions', comment = 'ESP="Mas Acciones",ENA="Mes Accions"';
                action(PrintHistory)
                {
                    // Estas propiedades hacen que aparezca directamente en la barra de 'Informe'
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    Image = PrintReport;
                    Caption = 'Imprimir Historial', comment = 'ESP="Imprimir Historial",ENA="Imprimir Historial"';
                    ToolTip = 'Genera el informe del historial de este cliente.', comment = 'ESP="Genera el informe del historial de este cliente.",ENA="Genera l''informe de l''historial d''aquest client."';

                    trigger OnAction()
                    var
                        CustRec: Record Customer;
                    begin
                        // Filtramos el informe para el cliente de la línea actual
                        CustRec.SetRange("No.", Rec."Customer No.");
                        if CustRec.FindFirst() then
                            Report.Run(Report::"CMC Customer History", true, false, CustRec);
                    end;
                }
            }
        }
    }
}