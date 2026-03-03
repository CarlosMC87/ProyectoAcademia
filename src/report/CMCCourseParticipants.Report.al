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
            column(CourseDescription; Description) { }
            column(TxtCourseCodeCapLbl; TxtCourseCodeCapLbl) { }
            column(TxtCourseDescriptionCapLbl; TxtCourseDescriptionCapLbl) { }
            column(TxtCourseCapLbl; TxtCourseCapLbl) { }
            column(TxtReportTitleLbl; TxtReportTitleLbl) { }
            column(TxtCustomerNoCapLbl; TxtCustomerNoCapLbl) { }
            column(TxtCustomerNameCapLbl; TxtCustomerNameCapLbl) { }
            column(TxtDateCapLbl; TxtDateCapLbl) { }
            column(TxtCoursePriceCapLbl; TxtCoursePriceCapLbl) { }
            column(TxtCopyRightCapLbl; TxtCopyRightCapLbl) { }
            column(TxtDeveloperAutorCapLbl; TxtDeveloperAutorCapLbl) { }
            column(TxtDeveloperAutorNameCapLbl; TxtDeveloperAutorNameCapLbl) { }
            column(TxtCompanyInfoDescriptionCapLbl; TxtCompanyInfoDescriptionCapLbl) { }
            dataitem(Enrollment; "CMC Course Enrollment")
            {
                DataItemLink = "Course Code" = field("Code");
                column(CustomerNo; "Customer No.") { }
                column(CustomerName; AcademyMgt.GetCustomerName("Customer No.")) { }
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

    // Sección de etiquetas para el layout
    var
        AcademyMgt: Codeunit "CMC Academy Management";
        TxtReportTitleLbl: Label 'Course Participants List', comment = 'ESP="Listado de Participantes por Curso",ENA="Llistat de Participants per Curs"';
        TxtDateCapLbl: Label 'Enrollment Date', comment = 'ESP="Fecha Inscripción",ENA="Data Inscripció"';
        TxtCourseCodeCapLbl: Label 'Course Code', comment = 'ESP="Código del Curso",ENA="Codi del Curs"';
        TxtCourseDescriptionCapLbl: Label 'Course Description', comment = 'ESP="Descripción del Curso",ENA="Descripció del Curs"';
        TxtCourseCapLbl: Label 'Course', comment = 'ESP="Curso",ENA="Curs"';
        TxtCoursePriceCapLbl: Label 'Price', comment = 'ESP="Precio",ENA="Preu"';
        TxtCustomerNoCapLbl: Label 'Customer No.', comment = 'ESP="Nº Cliente",ENA="Nº Client"';
        TxtCustomerNameCapLbl: Label 'Name', comment = 'ESP="Nombre",ENA="Nom"';
        TxtCopyRightCapLbl: Label 'Copyright © 2026';
        TxtDeveloperAutorCapLbl: Label 'Developer: ', comment = 'ESP="Desarrollador: ",ENA="Desenvolupador: "';
        TxtDeveloperAutorNameCapLbl: Label 'Carlos Merina Cirera', comment = 'ESP="Carlos Merina Cirera",ENA="Carlos Merina Cirera"';
        TxtCompanyInfoDescriptionCapLbl: Label 'Created with the sole purpose of training the staff of Olivia Sistemas S.L.', comment = 'ESP="Creado con el unico fin de formar al personal de Olivia Sistemas S.L.",ENA="Creat amb l''unic fi de formar al personal de Olivia Sistemas S.L."';
}