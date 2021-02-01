table 123456715 EmployeeTimeTable
{
    Caption = 'EmployeeTimeTable';
    DataClassification = ToBeClassified;

    fields
    {
        field(99; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

        }
        field(1; "EmployeeNo"; Code[20])
        {
            Caption = 'Employee No';
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(2; "Date"; Date)
        {
            Caption = 'Datum';
            DataClassification = ToBeClassified;
        }
        field(3; "IArbeitszeit"; Decimal)
        {
            Caption = 'Ist Arbeitszeit';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(4; "SArbeitszeit"; Decimal)
        {
            Caption = 'Soll Arbeitszeit';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(5; "DepartmentNo"; Code[20])
        {
            Caption = 'Department No';
            DataClassification = ToBeClassified;
            TableRelation = Department."No.";
        }
        field(6; "Krankheitsstand"; Decimal)
        {
            Caption = 'Krankheitsstand';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
    }
    keys
    {
        key(Key1; "No.")
        {

        }

    }

}
