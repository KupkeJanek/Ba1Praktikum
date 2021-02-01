table 123456713 WorkingHours
{
    Caption = 'WorkingHours';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

}
