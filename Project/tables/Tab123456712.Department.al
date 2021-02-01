table 123456712 Department
{
    Caption = 'Department';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';


        }
        field(2; "Name"; Text[30])
        {
            Caption = 'Name';
        }

    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

}
