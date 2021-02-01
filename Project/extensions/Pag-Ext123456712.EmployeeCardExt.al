pageextension 123456712 EmployeeCardExt extends "Employee Card"
{
    layout
    {

        addafter(General)
        {
            field("Department"; Rec.Department)
            {
                ApplicationArea = All;

            }
        }
    }
}
