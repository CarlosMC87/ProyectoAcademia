table 50505 "CMC Course"
{
    DataClassification = ToBeClassified;
    Caption = 'Course', comment = 'ESP="Curso",ENA="Curs"';
    LookupPageId = "CMC Course List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code', comment = 'ESP="Código",ENA="Codi"';
            ToolTip = 'The code of the course', comment = 'ESP="Código del curso",ENA="Codi del curs"';
            NotBlank = true;
        }
        field(2; "Description"; Text[100])
        {
            Caption = 'Description', comment = 'ESP="Descripción",ENA="Descripció"';
            ToolTip = 'The description of the course', comment = 'ESP="Descripción del curso",ENA="Descripció del curs"';
        }
        field(3; "Price"; Decimal)
        {
            Caption = 'Price', comment = 'ESP="Precio",ENA="Preu"';
            ToolTip = 'The price of the course', comment = 'ESP="Precio del curso",ENA="Preu del curs"';
            MinValue = 0;
        }
        field(4; "Status"; enum "CMC Course Status")
        {
            Caption = 'Status', comment = 'ESP="Estado",ENA="Estat"';
            ToolTip = 'The status of the course', comment = 'ESP="Estado del curso",ENA="Estat del curs"';
        }
        //Obsoleto usar opciones:
        /*field(4; "Status"; Option)
        {
            Caption = 'Status', comment = 'ESP="Estado",ENA="Estat"';
            ToolTip = 'The status of the course', comment = 'ESP="Estado del curso",ENA="Estat del curs"';
            OptionMembers = Active,Closed,Standby;
            OptionCaption = 'Active,Closed,Standby', comment = 'ESP="Activo,Cerrado,En Espera",ENA="Actiu,Tancat,En Espera"';
        }
        */
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}