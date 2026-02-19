permissionset 50500 All
{
    Assignable = true;
    Permissions = tabledata "My Table" = RIMD,
        table "My Table" = X,
        report MyReport = X,
        codeunit MyCodeunit = X,
        page MyPage = X;
}