pageextension 50506 "CMC Customer List Ext" extends "Customer List"
{
    layout
    {

    }

    actions
    {
        // addlast añade el botón al área de "Reporting" (Informe).
        addlast(Reporting)
        {
            action(PrintCustomerHistoryList)
            {
                ApplicationArea = All;
                // Estas propiedades hacen que aparezca directamente en la barra de "Informe".
                Promoted = true;
                PromotedCategory = Report;
                PromotedOnly = true;
                Image = PrintReport;
                Caption = 'Imprimir Historial', comment = 'ESP="Imprimir Historial",ENA="Imprimir Historial"';
                ToolTip = 'Genera el informe del historial de inscripciones del cliente seleccionado.', comment = 'ESP="Genera el informe del historial de este cliente.",ENA="Genera l''informe de l''historial d''aquest client."';
                trigger OnAction()
                var
                    CustRec: Record Customer;
                begin
                    // En una lista, 'Rec' ya es el cliente seleccionado.
                    CustRec.SetRange("No.", Rec."No.");

                    // Ejecutamos el informe (true = muestra ventana de filtros, false = no impresora sistema)
                    if not CustRec.IsEmpty() then
                        Report.Run(Report::"CMC Customer History", true, false, CustRec);
                end;
            }
        }
    }
}