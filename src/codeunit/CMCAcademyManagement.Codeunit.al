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
}