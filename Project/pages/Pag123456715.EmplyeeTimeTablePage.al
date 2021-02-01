page 123456715 EmplyeeTimeTablePage
{

    Caption = 'EmplyeeTimeTablePage';
    PageType = ListPart;
    SourceTable = EmployeeTimeTable;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(EmployeeNo; Rec.EmployeeNo)
                {
                    ApplicationArea = All;
                }
                field(Krankheitsstand; Rec.Krankheitsstand)
                {
                    ApplicationArea = All;
                }
                field(IArbeitszeit; Rec.IArbeitszeit)
                {
                    ApplicationArea = All;
                }
                field(SArbeitszeit; Rec.SArbeitszeit)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
