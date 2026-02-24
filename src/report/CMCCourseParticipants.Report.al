report 50505 "CMC Course Participants"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Course Participants', comment = 'ESP="Participantes por Curso",ENA="Participants per Curs"';
    DefaultRenderingLayout = CMCRDLCLayout;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(Course; "CMC Course")
        {
            PrintOnlyIfDetail = false;
            column(CourseCode; Code) { }
            column(CourseCodeCapLbl; CourseCodeCapLbl) { }
            column(CourseDescription; Description) { }
            column(CourseDescriptionCapLbl; CourseDescriptionCapLbl) { }
            column(CourseTxtCapLbl; CourseTxtCapLbl) { }
            column(ReportTitleLbl; ReportTitleLbl) { }
            column(CustomerNoCapLbl; CustomerNoCapLbl) { }
            column(CustomerNameCapLbl; CustomerNameCapLbl) { }
            column(DateCapLbl; DateCapLbl) { }
            column(CoursePriceCapLbl; CoursePriceCapLbl) { }
            column(CopyRightCapLbl; CopyRightCapLbl) { }
            column(DeveloperAutorCapLbl; DeveloperAutorCapLbl) { }
            column(DeveloperAutorNameCapLbl; DeveloperAutorNameCapLbl) { }
            column(CompanyInfoDescriptionCapLbl; CompanyInfoDescriptionCapLbl) { }
            dataitem(Enrollment; "CMC Course Enrollment")
            {
                DataItemLink = "Course Code" = field("Code");
                column(CustomerNo; "Customer No.") { }
                column(CustomerName; GetCustomerName("Customer No.")) { }
                column(EnrollmentDate; "Enrollment Date") { }
                column(Course_Price; "Course Price") { }
            }
        }
    }

    rendering
    {
        layout(CMCRDLCLayout)
        {
            Caption = 'CMC Layout', comment = 'ESP="Diseño CMC",ENA="Diseño CMC"';
            Type = RDLC;
            LayoutFile = 'src/layouts/CMCCourseParticipants.rdl';
        }
    }

    local procedure GetCustomerName(CustNo: Code[20]): Text[100]
    var
        Cust: Record Customer;
    begin
        if Cust.Get(CustNo) then
            exit(Cust.Name);
        exit('');
    end;

    // Sección de etiquetas para el layout
    var
        ReportTitleLbl: Label 'Course Participants List', comment = 'ESP="Listado de Participantes por Curso",ENA="Llistat de Participants per Curs"';
        DateCapLbl: Label 'Enrollment Date', comment = 'ESP="Fecha Inscripción",ENA="Data Inscripció"';
        CourseCodeCapLbl: Label 'Course Code', comment = 'ESP="Código del Curso",ENA="Codi del Curs"';
        CourseDescriptionCapLbl: Label 'Course Description', comment = 'ESP="Descripción del Curso",ENA="Descripció del Curs"';
        CustomerNoCapLbl: Label 'Customer No.', comment = 'ESP="Nº Cliente",ENA="Nº Client"';
        CustomerNameCapLbl: Label 'Name', comment = 'ESP="Nombre",ENA="Nom"';
        CourseTxtCapLbl: Label 'Course', comment = 'ESP="Curso",ENA="Curs"';
        CoursePriceCapLbl: Label 'Price', comment = 'ESP="Precio",ENA="Preu"';
        CopyRightCapLbl: Label 'Copyright © 2026';
        DeveloperAutorCapLbl: Label 'Developer: ', comment = 'ESP="Desarrollador: ",ENA="Desenvolupador: "';
        DeveloperAutorNameCapLbl: Label 'Carlos Merina Cirera', comment = 'ESP="Carlos Merina Cirera",ENA="Carlos Merina Cirera"';
        CompanyInfoDescriptionCapLbl: Label 'Created with the sole purpose of training the staff of Olivia Sistemas S.L.', comment = 'ESP="Creado con el unico fin de formar al personal de Olivia Sistemas S.L.",ENA="Creat amb l''unic fi de formar al personal de Olivia Sistemas S.L."';
}