table 123456711 JKmyEmployeeAbsence
{
    Caption = 'Abwesenheiten';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(4; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(5; "Cause of Absence Code"; Code[10])
        {
            Caption = 'Cause of Absence Code';
            TableRelation = "Cause of Absence";
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(12; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;

        }
        field(7; "Monat"; Integer)
        {
            Caption = 'Monat';

        }
        field(8; "Quartal"; Integer)
        {
            Caption = 'Quartal';

        }
        field(9; "Jahr"; Integer)
        {
            Caption = 'Jahr';

        }
        field(10; "Department"; Code[20])
        {

            FieldClass = FlowField;
            CalcFormula = lookup(Employee.Department where("No." = Field("Employee No.")));
        }
        field(11; "Gender"; Enum "Employee Gender")
        {

            FieldClass = FlowField;
            CalcFormula = lookup(Employee.Gender where("No." = Field("Employee No.")));
        }

    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Employee No.", "From Date")
        {
        }
        key(Key3; "From Date", "To Date")
        {
        }
    }
    fieldgroups
    {
    }
}
