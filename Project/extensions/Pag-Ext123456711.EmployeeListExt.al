pageextension 123456711 EmployeeListExt extends "Employee List"
{
    layout
    {
        addafter("Last Name")
        {
            field("Department"; Rec."Department")
            {
                ApplicationArea = All;
                Caption = 'Department';
            }
        }
    }
}
