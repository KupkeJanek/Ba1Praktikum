page 123456712 JKMyEmployeeAbsence
{

    Caption = 'JKMyEmployeeAbsence';
    PageType = ListPart;
    SourceTable = JKmyEmployeeAbsence;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cause of Absence Code"; Rec."Cause of Absence Code")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Monat"; Rec."Monat")
                {
                    ApplicationArea = All;
                }
                field("Quartal"; Rec."Quartal")
                {
                    ApplicationArea = All;
                }

                field("Jahr"; Rec."Jahr")
                {
                    ApplicationArea = All;
                }
                field("Department"; Rec."Department")
                {
                    ApplicationArea = all;
                }
                field("Gender"; Rec."Gender")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

}
