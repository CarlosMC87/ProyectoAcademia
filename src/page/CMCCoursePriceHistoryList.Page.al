/// <summary>
/// Página de tipo List para la consulta de auditoría. 
/// Configurada como 'Editable = false' para garantizar la integridad 
/// de los datos históricos. Incluye 'UsageCategory = Lists' para que 
/// sea localizable desde el buscador principal de Business Central.
/// </summary>
page 50508 "CMC Course Price History List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CMC Course Price History";
    Editable = false; // El historial no se debe tocar
    Caption = 'Course Price History', comment = 'ESP="Historial Precios Curso",ENA="Historial Preus Curs"';

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Entry No.', comment = 'ESP="Nº Movimiento",ENA="Nº Moviment"';
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    TableRelation = "CMC Course";
                    ToolTip = 'Course Code', comment = 'ESP="Código Curso",ENA="Codi Curs"';
                }
                field("Old Price"; Rec."Old Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Old Price', comment = 'ESP="Precio Anterior",ENA="Preu Anterior"';
                }
                field("New Price"; Rec."New Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'New Price', comment = 'ESP="Precio Nuevo",ENA="Preu Nou"';
                }
                field("Change Date"; Rec."Change Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Change Date', comment = 'ESP="Fecha Cambio",ENA="Data Canvi"';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'User ID', comment = 'ESP="Usuario",ENA="Usuari"';
                }
            }
        }
    }
}