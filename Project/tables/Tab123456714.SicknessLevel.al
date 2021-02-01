table 123456714 SicknessLevel
{
    Caption = 'SicknessLevel';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No"; Integer)
        {
            Caption = 'PK';
            NotBlank = true;
            AutoIncrement = true;
        }

        field(2; "Datum"; Date)
        {
            Caption = 'Datum';
        }

        field(4; "KFehlzeiten"; Decimal)
        {
            Caption = 'Krankheitsbedingte Fehlzeiten in Tagen';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum(EmployeeTimeTable.Krankheitsstand where(Date = Field(Datum), EmployeeNo = FIELD("Employee No. Filter"), DepartmentNo = FIELD("Department No Filter")));
        }
        field(5; "SumSollArbeitszeit"; Decimal)
        {
            Caption = 'Summe der Soll Arbeitszeit';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum(EmployeeTimeTable.SArbeitszeit where(Date = Field(Datum), EmployeeNo = FIELD("Employee No. Filter"), DepartmentNo = FIELD("Department No Filter")));
        }
        field(6; "SumIstArbeitszeit"; Decimal)
        {
            Caption = 'Summe der IST Arbeitszeit';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum(EmployeeTimeTable.IArbeitszeit where(Date = Field(Datum), EmployeeNo = FIELD("Employee No. Filter"), DepartmentNo = FIELD("Department No Filter")));
        }

        field(9; "Employee No. Filter"; Code[20])
        {
            Caption = 'Employee No. Filter';
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }

        field(11; "Department No Filter"; Code[20])
        {
            Caption = 'Department Filter';
            FieldClass = FlowFilter;
            TableRelation = Department;

        }
    }
    keys
    {
        key(Key1; "No")
        {
            Clustered = true;
        }
    }
}
