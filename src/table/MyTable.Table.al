table 50500 "My Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "MyField"; Integer)
        {
            Caption = 'MyField';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "MyField")
        {
            Clustered = true;
        }
    }

}