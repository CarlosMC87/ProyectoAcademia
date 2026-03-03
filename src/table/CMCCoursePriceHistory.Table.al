/// <summary>
/// Esta tabla funciona como un "log" o diario de cambios. 
/// No tiene interfaz propia (de momento), su único objetivo es almacenar 
/// cada vez que un precio antiguo cambia a uno nuevo, guardando también 
/// el usuario y la fecha exacta del movimiento.
/// </summary>

table 50507 "CMC Course Price History"
{
    DataClassification = CustomerContent;
    Caption = 'Course Price History', comment = 'ESP="Historial Precios Curso",ENA="Historial Preus Curs"';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.', comment = 'ESP="Nº Movimiento",ENA="Nº Moviment"';
        }
        field(2; "Course Code"; Code[20])
        {
            TableRelation = "CMC Course";
            Caption = 'Course Code', comment = 'ESP="Código Curso",ENA="Codi Curs"';
        }
        field(3; "Old Price"; Decimal)
        {
            Caption = 'Old Price', comment = 'ESP="Precio Anterior",ENA="Preu Anterior"';
        }
        field(4; "New Price"; Decimal)
        {
            Caption = 'New Price', comment = 'ESP="Precio Nuevo",ENA="Preu Nou"';
        }
        field(5; "Change Date"; DateTime)
        {
            Caption = 'Change Date', comment = 'ESP="Fecha Cambio",ENA="Data Canvi"';
        }
        field(6; "User ID"; Code[20])
        {
            Caption = 'User ID', comment = 'ESP="Usuario",ENA="Usuari"';
        }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
    }
}