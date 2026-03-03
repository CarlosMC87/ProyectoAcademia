enum 50505 "CMC Course Status"
{
    Extensible = true;

    value(0; Active)
    {
        Caption = 'Active', Comment = 'ESP="Activo",ENA="Actiu"';
    }
    value(1; Closed)
    {
        Caption = 'Closed', Comment = 'ESP="Cerrado",ENA="Tancat"';
    }
    value(2; Standby)
    {
        Caption = 'Standby', Comment = 'ESP="En Espera",ENA="En Espera"';
    }

}