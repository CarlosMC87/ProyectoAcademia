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
}