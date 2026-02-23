permissionset 50501 AllPermission
{
    Assignable = true;
    Permissions = tabledata "CMC Course" = RIMD,
        table "CMC Course Enrollment" = X,
        page "CMC Course List" = X,
        tabledata "CMC Course Enrollment" = RIMD,
        table "CMC Course" = X,
        report MyReport = X,
        codeunit "CMC Academy Management" = X;
}