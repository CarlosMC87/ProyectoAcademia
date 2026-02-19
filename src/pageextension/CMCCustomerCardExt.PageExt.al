pageextension 50505 "CMC Customer Card Ext" extends "Customer Card"
{
    layout
    {
        // Añadimos los cursos al final de la ficha del cliente
        addlast(Content)
        {
            part(CourseEnrollments; "CMC Course Enrollm. Subpage")
            {
                ApplicationArea = All;
                // Conectamos el Nº de Cliente de la subpágina con el Nº de la ficha actual
                SubPageLink = "Customer No." = field("No.");
            }
        }
    }
}