page 50506 "CMC Course Enrollm. Subpage"
{
    PageType = ListPart;
    SourceTable = "CMC Course Enrollment";
    Caption = 'Course Enrollments', comment = 'ESP="Inscripciones a Cursos",ENA="Inscripcions a Cursos"';

    layout
    {
        area(Content)
        {
            group(PaymentStatus)
            {
                Caption = 'Estado de Pago y Notas', comment = 'ESP="Estado de Pago y Notas",ENA="Estat de Pagament i Notes"';

                field(UnpaidVar; UnpaidVar)
                {
                    ApplicationArea = All;
                    Caption = 'Unpaid', comment = 'ESP="Impago",ENA="Impagament"';
                    ToolTip = 'Unpaid', comment = 'ESP="Impago",ENA="Impagament"';

                    trigger OnValidate()
                    var
                        Cust: Record Customer;
                    begin
                        if Cust.Get(Rec."Customer No.") then begin
                            Cust."CMC Unpaid Balance" := UnpaidVar;
                            Cust.Modify();
                        end;
                    end;
                }

                field(NotesVar; NotesVar)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Caption = 'Notes', comment = 'ESP="Notas",ENA="Notes"';
                    ToolTip = 'Notes', comment = 'ESP="Notas",ENA="Notes"';
                    // Solo permitimos editar la nota si el check de impago está activo
                    Editable = UnpaidVar;

                    trigger OnValidate()
                    var
                        Cust: Record Customer;
                    begin
                        if Cust.Get(Rec."Customer No.") then begin
                            Cust."CMC Notes" := NotesVar;
                            Cust.Modify();
                        end;
                    end;
                }
            }
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
                action(SendHistoryByEmail)
                {
                    // Estas propiedades hacen que aparezca directamente en la barra de 'Informe'
                    PromotedCategory = Report;
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    Image = Email;
                    Caption = 'Send historial', comment = 'ESP="Enviar historial",ENA="Enviar historial"';
                    ToolTip = 'Genera el informe del historial de este cliente.', comment = 'ESP="Genera el informe del historial de este cliente.",ENA="Genera l''informe de l''historial d''aquest client."';

                    trigger OnAction()
                    begin
                        // Llamamos a la nueva función de la Codeunit
                        AcademyMgt.SendHistoryByEmail(Rec."Customer No.");
                    end;

                }
            }
        }
    }
    var
        AcademyMgt: Codeunit "CMC Academy Management";
        UnpaidVar: Boolean;
        NotesVar: Text[300];

    trigger OnAfterGetCurrRecord()
    var
        Cust: Record Customer;
    begin
        // Cargamos los datos del cliente cada vez que entramos o cambiamos de ficha
        if Cust.Get(Rec."Customer No.") then begin
            UnpaidVar := Cust."CMC Unpaid Balance";
            NotesVar := Cust."CMC Notes";
        end;
    end;
}