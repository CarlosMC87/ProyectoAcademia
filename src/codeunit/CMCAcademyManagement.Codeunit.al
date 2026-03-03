codeunit 50503 "CMC Academy Management"
{
    // Este procedimiento se ejecuta justo ANTES de que se guarde una nueva inscripción
    [EventSubscriber(ObjectType::Table, Database::"CMC Course Enrollment", 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertEnrollment(var Rec: Record "CMC Course Enrollment")
    var
        Course: Record "CMC Course";
        CourseClosedErr: Label 'The course %1 is Closed and does not accept new enrollments.', comment = 'ESP="El curso %1 está Cerrado y no acepta nuevas inscripciones.",ENA="El curs %1 està Tancat i no accepta noves inscripcions."';
        PrerequisiteErr: Label 'This course is On Hold. You need to complete BC-BASIC first.', comment = 'ESP="Este curso está En Espera. Necesitas completar BC-BASIC primero.",ENA="Aquest curs està En Espera. Necessites completar BC-BASIC primer."';
    begin
        // 0. Si no hay curso, no hacemos nada
        if not Course.Get(Rec."Course Code") then
            exit;

        // --- LÓGICA 1: BLOQUEO ABSOLUTO ---
        // Para cualquier curso que NO sea el básico, miramos si está cerrado.
        if Course.Status = Course.Status::Closed then
            Error(CourseClosedErr, Rec."Course Code");

        // --- LÓGICA 2: BLOQUEO CONDICIONAL (EN ESPERA) ---
        if Course.Status = Course.Status::Standby then
            // Si es el básico, no puede estar en espera de sí mismo, pero por seguridad lo dejamos pasar
            if Rec."Course Code" <> 'BC-BASIC' then
                if not CheckIfCustomerHasBasic(Rec."Customer No.") then
                    Error(PrerequisiteErr);
    end;

    // Este procedimiento impide borrar el curso básico si hay dependencia de otros cursos
    [EventSubscriber(ObjectType::Table, Database::"CMC Course Enrollment", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeDeleteEnrollment(var Rec: Record "CMC Course Enrollment")
    var
        OtherEnrollments: Record "CMC Course Enrollment";
        DeleteBasicErr: Label 'You cannot delete the BC-BASIC enrollment because this customer has other advanced courses. Delete the advanced courses first.', comment = 'ESP="No puedes borrar la inscripción de BC-BASIC porque este cliente tiene otros cursos avanzados. Borra primero los cursos avanzados.",ENA="No pots esborrar la inscripció de BC-BASIC perquè aquest client té altres cursos avançats. Esborra primer els cursos avançats."';
    begin
        // 1. ¿El usuario está intentando borrar el curso básico?
        if Rec."Course Code" = 'BC-BASIC' then begin

            // 2. Buscamos si el cliente tiene CUALQUIER OTRA inscripción
            OtherEnrollments.SetRange("Customer No.", Rec."Customer No.");
            // Filtramos para NO contar la que estamos intentando borrar ahora
            OtherEnrollments.SetFilter("Course Code", '<>%1', 'BC-BASIC');
            // 3. Si encontramos algo, bloqueamos el borrado
            if not OtherEnrollments.IsEmpty() then
                Error(DeleteBasicErr);
        end;
    end;

    // Función auxiliar para mantener el código limpio (Objetivo 3)
    local procedure CheckIfCustomerHasBasic(CustomerNo: Code[20]): Boolean
    var
        Enrollment: Record "CMC Course Enrollment";
    begin
        Enrollment.SetRange("Customer No.", CustomerNo);
        Enrollment.SetRange("Course Code", 'BC-BASIC');
        // Si NO está vacío, es que tiene el curso.
        exit(not Enrollment.IsEmpty());
    end;

    // 1. Lógica AL: Crear funciones GetTotalCourses y GetTotalInvestment para calcular
    // datos agregados en tiempo de ejecución.
    // Función auxiliar para contar cursos
    procedure GetTotalCourses(CustomerNo: Code[20]): Integer
    var
        Enrollment: Record "CMC Course Enrollment";
    begin
        Enrollment.SetRange("Customer No.", CustomerNo);
        // Si queremos contar solo los activos, descomentar la línea de abajo
        // Enrollment.SetFilter("Status", '<>%1', Enrollment.Status::Cancelled);
        exit(Enrollment.Count());
    end;

    // Función auxiliar para sumar precios.
    procedure GetTotalInvestment(CustomerNo: Code[20]): Decimal
    var
        Enrollment: Record "CMC Course Enrollment";
        Total: Decimal;
    begin
        Enrollment.SetRange("Customer No.", CustomerNo);
        // Recorremos las inscripciones del cliente.
        if Enrollment.FindSet() then
            repeat
                Total += GetCoursePrice(Enrollment."Course Code");
            until Enrollment.Next() = 0;
        exit(Total);
    end;

    // Función auxiliar para obtener el precio de un curso.
    procedure GetCoursePrice(CourseCode: Code[20]): Decimal
    var
        Course: Record "CMC Course";
    begin
        if Course.Get(CourseCode) then
            exit(Course.Price);
        exit(0);
    end;

    // Función auxiliar para obtener la descripción de un curso.
    procedure GetCourseDescription(CourseCode: Code[20]): Text
    var
        Course: Record "CMC Course";
    begin
        if Course.Get(CourseCode) then
            exit(Course.Description);
        exit('');
    end;

    procedure GetCustomerName(CustNo: Code[20]): Text[100]
    var
        Cust: Record Customer;
    begin
        if Cust.Get(CustNo) then
            exit(Cust.Name);
        exit('');
    end;

    procedure SendHistoryByEmail(CustNo: Code[20])
    var
        Customer: Record Customer;
        Email: Codeunit Email;
        TempBlob: Codeunit "Temp Blob";
        EmailMsg: Codeunit "Email Message";
        ReportRecRef: RecordRef;
        FldRef: FieldRef;
        OutStr: OutStream;
        InStr: InStream;
        MailSubjectMsg: Label 'Course History - %1', comment = 'ESP="Historial Cursos - %1",ENA="Historial Cursos - %1"';
    begin
        // 1. Validaciones
        if not Customer.Get(CustNo) then exit;
        if Customer."E-Mail" = '' then
            Error('El cliente %1 no tiene email.', Customer.Name);

        // 2. Preparar Filtro (Corregido para image_89a826.png)
        ReportRecRef.Open(Database::Customer);
        FldRef := ReportRecRef.Field(Customer.FieldNo("No."));
        FldRef.SetRange(CustNo); // Usamos el valor recibido por parámetro

        // 3. Generar PDF
        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(Report::"CMC Customer History", '', ReportFormat::Pdf, OutStr, ReportRecRef);
        TempBlob.CreateInStream(InStr);

        // 4. Crear Mensaje
        EmailMsg.Create(Customer."E-Mail", StrSubstNo(MailSubjectMsg, Customer.Name), 'Adjuntamos su historial.', true);
        EmailMsg.AddAttachment('History.pdf', 'application/pdf', InStr);

        // 5. Abrir el editor (Corregido según image_89a422.png)
        // Usamos el nuevo nombre del método y el escenario por defecto
        Email.OpenInEditor(EmailMsg, Enum::"Email Scenario"::Default);
    end;

    /// <summary>
    /// Suscriptor para auditar cambios de precio en la tabla Curso.
    /// Utiliza 'xRec' para capturar el valor histórico (antes de la modificación) 
    /// y 'Rec' para el valor nuevo. Cada cambio genera un registro único en la 
    /// tabla de histórico, permitiendo un seguimiento cronológico exacto de la 
    /// evolución de precios, incluyendo fecha, hora y usuario.
    /// @param Rec El registro actual (después de la modificación).
    /// @param xRec El registro anterior (antes de la modificación).
    /// </summary>

    [EventSubscriber(ObjectType::Table, Database::"CMC Course", 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifyEventCourse(var Rec: Record "CMC Course"; var xRec: Record "CMC Course")
    var
        CoursePriceHistory: Record "CMC Course Price History";
    begin
        // 1. Solo registramos si el precio ha cambiado de verdad
        if Rec.Price = xRec.Price then
            exit;

        CoursePriceHistory.Reset();
        CoursePriceHistory.Init();
        // Asignamos la clave primaria del curso
        CoursePriceHistory."Course Code" := Rec.Code;
        // 2. LA CLAVE: El precio anterior viene de xRec (el pasado)
        CoursePriceHistory."Old Price" := xRec.Price;
        // 3. El precio nuevo viene de Rec (el presente)
        CoursePriceHistory."New Price" := Rec.Price;
        CoursePriceHistory."Change Date" := CurrentDateTime;
        CoursePriceHistory."User ID" := UserId;
        // 4. Insertamos una línea nueva cada vez para ver la evolución
        CoursePriceHistory.Insert(true);
    end;
}