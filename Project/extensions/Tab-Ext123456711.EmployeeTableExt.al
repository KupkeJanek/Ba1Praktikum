tableextension 123456711 EmployeeTableExt extends Employee
{
    fields
    {
        field(99; Department; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Department."No.";
        }
    }
}
