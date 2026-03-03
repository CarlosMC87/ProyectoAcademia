page 50505 "CMC Course List"
{
    PageType = List;
    SourceTable = "CMC Course";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Courses', comment = 'ESP="Cursos",ENA="Cursos"';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    Tooltip = 'The code of the course', comment = 'ESP="Código del curso",ENA="Codi del curs"';
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    Tooltip = 'The description of the course', comment = 'ESP="Descripción del curso",ENA="Descripció del curs"';
                }
                field("Price"; Rec."Price")
                {
                    ApplicationArea = All;
                    Tooltip = 'The price of the course', comment = 'ESP="Precio del curso",ENA="Preu del curs"';
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    Tooltip = 'The status of the course', comment = 'ESP="Estado del curso",ENA="Estat del curs"';
                }
            }
        }
    }

    // --- AQUÍ AÑADIMOS EL BOTÓN PARA IMPRIMIR INFORME---
    actions
    {
        area(Reporting) // Esto lo coloca en la pestaña de Informes
        {
            action(PrintParticipants)
            {
                Caption = 'Print Participants', comment = 'ESP="Imprimir Participantes",ENA="Imprimir Participants"';
                ToolTip = 'View the list of students enrolled in the selected course.', comment = 'ESP="Ver la lista de alumnos inscritos en el curso seleccionado.",ENA="Veure la llista d''alumnes inscrits en el curs seleccionat."';
                ApplicationArea = All;
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    CourseRec: Record "CMC Course";
                begin
                    // Filtramos el informe para que solo salga el curso que tenemos seleccionado en la lista
                    CourseRec.SetRange(Code, Rec.Code);
                    Report.Run(Report::"CMC Course Participants", true, false, CourseRec);
                end;
            }
        }
        area(Navigation)
        {
            action(ShowHistory)
            {
                Caption = 'Show History', comment = 'ESP="Mostrar Historial",ENA="Mostrar Historial"';
                ToolTip = 'View the history of the selected course.', comment = 'ESP="Ver el historial del curso seleccionado.",ENA="Veure l''historial del curs seleccionat."';
                ApplicationArea = All;
                Image = History;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    PriceHistory: Record "CMC Course Price History";
                begin
                    PriceHistory.Reset();
                    // 1. Filtramos la tabla de destino por el código del curso actual
                    PriceHistory.SetRange("Course Code", Rec.Code);

                    // 2. Abrimos la página pasando el registro ya filtrado
                    Page.Run(Page::"CMC Course Price History List", PriceHistory);
                end;
            }
        }
    }
}