report 50506 "CMC Customer History"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Customer Enrollment History', comment = 'ESP="Historial Inscripciones Cliente",ENA="Historial Inscripcions Client"';
    DefaultRenderingLayout = HistoryRDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            PrintOnlyIfDetail = false;

            // Datos del cliente
            column(CustomerNo; "No.") { }
            column(CustomerName; Name) { }
            column(CustomerAddress; Address) { }
            column(CustomerAddress2; "Address 2") { }
            column(CustomerCity; City) { }
            column(CustomerPostCode; "Post Code") { }
            column(CustomerCountry; "Country/Region Code") { }
            column(CustomerPhone; "Phone No.") { }
            column(CustomerEmail; "E-Mail") { }
            column(CustomerVATNo; "VAT Registration No.") { }

            // Calculamos los totales antes de enviar la fila al dataset
            column(TotalCourses; AcademyMgt.GetTotalCourses("No.")) { }
            column(TotalInvestment; AcademyMgt.GetTotalInvestment("No.")) { }

            // Etiquetas Labels
            column(TxtReportTitleLbl; TxtReportTitleLbl) { }
            column(TxtCourseCodeCapLbl; TxtCourseCodeCapLbl) { }
            column(TxtCourseDescriptionCapLbl; TxtCourseDescriptionCapLbl) { }
            column(TxtPriceCapLbl; TxtPriceCapLbl) { }
            column(TxtDateCapLbl; TxtDateCapLbl) { }
            column(TxtTotalCoursesCapLbl; TxtTotalCoursesCapLbl) { }
            column(TxtTotalInvCapLbl; TxtTotalInvCapLbl) { }
            column(TxtCopyRightCapLbl; TxtCopyRightCapLbl) { }
            column(TxtDeveloperAutorCapLbl; TxtDeveloperAutorCapLbl) { }
            column(TxtDeveloperAutorNameCapLbl; TxtDeveloperAutorNameCapLbl) { }
            column(TxtCompanyInfoDescriptionCapLbl; TxtCompanyInfoDescriptionCapLbl) { }
            column(TxtCustomerHeaderLbl; TxtCustomerHeaderLbl) { }

            dataitem(Enrollment; "CMC Course Enrollment")
            {
                DataItemLink = "Customer No." = field("No.");
                column(CourseCode; "Course Code") { }
                column(CoursePrice; "Course Price") { }
                column(EnrollmentDate; "Enrollment Date") { }
                column(CourseDescription; AcademyMgt.GetCourseDescription("Course Code")) { }
            }
        }
    }

    rendering
    {
        layout(HistoryRDLC)
        {
            Type = RDLC;
            LayoutFile = './src/layouts/CMCCustomerHistory.rdl';
        }
    }

    var
        AcademyMgt: Codeunit "CMC Academy Management";

        // Etiquetes Labels
        TxtCustomerHeaderLbl: Label 'CUSTOMER', comment = 'ESP="CLIENTE",ENA="CLIENT"';
        TxtReportTitleLbl: Label 'Historial de Inscripciones', comment = 'ESP="Historial Inscripciones Cliente",ENA="Historial Inscripcions Client"';
        TxtCourseCodeCapLbl: Label 'Curse', comment = 'ESP="Curso",ENA="Curs"';
        TxtPriceCapLbl: Label 'Precio', comment = 'ESP="Precio",ENA="Preu"';
        TxtDateCapLbl: Label 'Fecha Inscripción', comment = 'ESP="Fecha Inscripción",ENA="Data Inscripció"';
        TxtTotalCoursesCapLbl: Label 'Total Cursos', comment = 'ESP="Total Cursos",ENA="Total Cursos"';
        TxtCourseDescriptionCapLbl: Label 'Description', Comment = 'ESP="Descripción",ENA="Descripció"';
        TxtTotalInvCapLbl: Label 'Inversión Total', comment = 'ESP="Inversión Total",ENA="Inversió Total"';
        TxtCopyRightCapLbl: Label 'Copyright © 2026';
        TxtDeveloperAutorCapLbl: Label 'Developer: ', comment = 'ESP="Desarrollador: ",ENA="Desenvolupador: "';
        TxtDeveloperAutorNameCapLbl: Label 'Carlos Merina Cirera';
        TxtCompanyInfoDescriptionCapLbl: Label 'Created with the sole purpose of training the staff of Olivia Sistemas S.L.', comment = 'ESP="Creado con el unico fin de formar al personal de Olivia Sistemas S.L.",ENA="Creat amb l''unic fi de formar al personal de Olivia Sistemas S.L."';
}