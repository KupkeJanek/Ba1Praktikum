page 123456711 Ba1_Praktikum
{

    Caption = 'Ba1_Praktikum';
    PageType = Document;
    PromotedActionCategories = 'One, TWO, THREE, Absence operations, Text manipulation, Numeric calculator';

    layout
    {
        area(content)
        {
            group(EingabeParameter)
            {
                field("Start Datum"; startDate)
                {
                    ApplicationArea = All;
                }
                field("End Datum"; endDate)
                {
                    ApplicationArea = All;
                }
                field("Mitarbeiter"; selEmployee)
                {
                    ApplicationArea = All;
                    Caption = 'Employee';
                    Lookup = true;
                    TableRelation = Employee;
                    trigger OnValidate()
                    begin

                        setEmployeeFilter(selEmployee)
                    end;

                }
                field("Department"; selDepartment)
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                    Lookup = true;
                    TableRelation = Department;
                    trigger OnValidate()
                    begin

                        setDepartmentFilter(selDepartment)
                    end;

                }


                field("Gender"; selGender)
                {
                    ApplicationArea = All;
                    Caption = 'Gender';
                    trigger OnValidate()
                    begin

                        setGenderFilter(selGender);
                    end;

                }


            }


            group(Ergebnisse)
            {
                usercontrol(Chart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
                {
                    ApplicationArea = All;

                }
                field("Montags"; mondaysCount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Dienstags"; tuesdaysCount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Mittwochs"; wednesDaysCount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Donnerstags"; thursdaysCount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Freitags"; fridaysCount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Samstags"; saturdaysCount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sonntags"; sundaysCount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(Abwesenheiten)
            {
                part("Mitarbeiter Abwesenheiten"; JKMyEmployeeAbsence)
                {
                    ApplicationArea = all;
                }
            }

        }
    }

    actions
    {

        area(Processing)
        {
            action("TMP Daten löschen")
            {
                ApplicationArea = all;
                ToolTip = 'Temporäre Abwesenheitsdaten löschen';
                Image = "8ball";
                trigger OnAction()
                begin
                    resetTmpData();
                end;
            }
            action("Datum übernehmen")
            {
                ApplicationArea = all;
                ToolTip = 'Übernehmen des Datums';
                Image = "8ball";
                trigger OnAction()
                begin
                    rec03.DeleteAll();
                    rec5207.SetRange("From date", startDate, endDate);
                    rec5207.SetRange("Cause of Absence Code", 'KRANK');

                    IF rec5207.FindFirst() then begin
                        repeat
                            rec03."Employee No." := rec5207."Employee No.";
                            rec03."Entry No." := rec5207."Entry No.";
                            rec03."From Date" := rec5207."From Date";
                            rec03."To Date" := rec5207."To Date";
                            rec03."Cause of Absence Code" := rec5207."Cause of Absence Code";
                            rec03.Description := rec5207.Description;
                            rec03."Quantity (Base)" := rec5207."Quantity (Base)";
                            rec03."Monat" := Date2DMY(rec5207."From Date", 2);
                            rec03."Jahr" := Date2DMY(rec5207."From Date", 3);
                            case Date2DMY(rec5207."From Date", 2) of
                                1, 2, 3:
                                    rec03."Quartal" := 1;
                                4, 5, 6:
                                    rec03."Quartal" := 2;
                                7, 8, 9:
                                    rec03."Quartal" := 3;
                                10, 11, 12:
                                    rec03."Quartal" := 4;
                            end;
                            rec03.Insert();

                        until rec5207.next = 0;
                        Message('Es wurden ' + Format((rec5207.Count())) + ' Datensätze zu Ihrer Suche gefunden');

                    end;
                end;
            }
            action("Clear Filter")
            {
                ApplicationArea = all;
                ToolTip = 'Alle Filter löschen';
                Image = "8ball";
                trigger OnAction()
                begin
                    Clear(rec03);
                    calcKrankheitsdaten();
                end;
            }


            action("Krankmeldungen verteilen")
            {
                ApplicationArea = all;
                ToolTip = 'Es sollen die Krankheitstage auf die Wochentage verteilt werden';
                Image = "8ball";
                trigger OnAction()
                begin
                    mondaysCount := 0;
                    tuesdaysCount := 0;
                    wednesDaysCount := 0;
                    thursdaysCount := 0;
                    fridaysCount := 0;
                    saturdaysCount := 0;
                    sundaysCount := 0;
                    IF rec7602.FindFirst() then begin
                        if rec03.FindFirst() then begin
                            repeat
                                for tmpDat := rec03."From Date" to rec03."To Date" do
                                    if NOT CU7600.IsNonworkingDay(tmpDat, rec7602) then begin
                                        case Date2DWY(tmpDat, 1) of
                                            1:
                                                mondaysCount := mondaysCount + 1;
                                            2:
                                                tuesdaysCount := tuesdaysCount + 1;
                                            3:
                                                wednesDaysCount := wednesDaysCount + 1;
                                            4:
                                                thursdaysCount := thursdaysCount + 1;
                                            5:
                                                fridaysCount := fridaysCount + 1;
                                            6:
                                                saturdaysCount := saturdaysCount + 1;
                                            7:
                                                sundaysCount := sundaysCount + 1;
                                        end;
                                    end;

                            until rec03.next = 0;
                        end;
                    end;
                    initKrankmeldungsChart();
                end;
            }
            action("1. Quartal")
            {
                ApplicationArea = all;
                ToolTip = 'Nach dem ersten Quartal filtern';
                Image = "8ball";
                trigger OnAction()
                begin
                    rec03.SetRange("Quartal", 1);
                    calcKrankheitsdaten();
                end;
            }
            action("2. Quartal")
            {
                ApplicationArea = all;
                ToolTip = 'Nach dem ersten Quartal filtern';
                Image = "8ball";
                trigger OnAction()
                begin
                    rec03.SetRange("Quartal", 2);
                    calcKrankheitsdaten();
                end;
            }
            action("3. Quartal")
            {
                ApplicationArea = all;
                ToolTip = 'Nach dem ersten Quartal filtern';
                Image = "8ball";
                trigger OnAction()
                begin
                    rec03.SetRange("Quartal", 3);
                    calcKrankheitsdaten();
                end;
            }
            action("4. Quartal")
            {
                ApplicationArea = all;
                ToolTip = 'Nach dem ersten Quartal filtern';
                Image = "8ball";
                trigger OnAction()
                begin
                    rec03.SetRange("Quartal", 4);
                    calcKrankheitsdaten();
                end;
            }
            action("2019")
            {
                ApplicationArea = all;
                ToolTip = 'Nach 2019 Filtern';
                Image = "8ball";
                trigger OnAction()
                begin
                    setYearFilter(2019);
                    calcKrankheitsdaten();
                end;
            }
            action("2020")
            {
                ApplicationArea = all;
                ToolTip = 'Nach 2020 Filtern';
                Image = "8ball";
                trigger OnAction()
                begin
                    setYearFilter(2020);
                    calcKrankheitsdaten();
                end;
            }
            action("2021")
            {
                ApplicationArea = all;
                ToolTip = 'Nach 2021 Filtern';
                Image = "8ball";
                trigger OnAction()
                begin
                    setYearFilter(2021);
                    calcKrankheitsdaten();
                end;
            }


        }
    }
    trigger OnOpenPage();
    begin
        startDate := 20190301D;
        endDate := 20210301D;
        rec03.DeleteAll();
    end;

    local procedure calcKrankheitsdaten()
    begin
        mondaysCount := 0;
        tuesdaysCount := 0;
        wednesDaysCount := 0;
        thursdaysCount := 0;
        fridaysCount := 0;
        saturdaysCount := 0;
        sundaysCount := 0;
        IF rec7602.FindFirst() then begin
            if rec03.FindFirst() then begin
                repeat
                    for tmpDat := rec03."From Date" to rec03."To Date" do
                        if NOT CU7600.IsNonworkingDay(tmpDat, rec7602) then begin
                            case Date2DWY(tmpDat, 1) of
                                1:
                                    mondaysCount := mondaysCount + 1;
                                2:
                                    tuesdaysCount := tuesdaysCount + 1;
                                3:
                                    wednesDaysCount := wednesDaysCount + 1;
                                4:
                                    thursdaysCount := thursdaysCount + 1;
                                5:
                                    fridaysCount := fridaysCount + 1;
                                6:
                                    saturdaysCount := saturdaysCount + 1;
                                7:
                                    sundaysCount := sundaysCount + 1;
                            end;
                        end;

                until rec03.next = 0;
            end;
        end;
        initKrankmeldungsChart();
    end;

    local procedure initKrankmeldungsChart()
    begin
        Buffer.Initialize();
        Buffer.AddMeasure('Krankmeldungen Verteilung', 1, Buffer."Data Type"::Integer, Buffer."Chart Type"::Column);
        Buffer.SetXAxis('Wochentag', Buffer."Data Type"::String);
        Buffer.AddColumn('Montag');
        Buffer.SetValueByIndex(0, 0, mondaysCount);
        Buffer.AddColumn('Dienstag');
        Buffer.SetValueByIndex(0, 1, tuesdaysCount);
        Buffer.AddColumn('Mittwoch');
        Buffer.SetValueByIndex(0, 2, wednesDaysCount);
        Buffer.AddColumn('Donnerstag');
        Buffer.SetValueByIndex(0, 3, thursdaysCount);
        Buffer.AddColumn('Freitag');
        Buffer.SetValueByIndex(0, 4, fridaysCount);
        Buffer.AddColumn('Samstag');
        Buffer.SetValueByIndex(0, 5, saturdaysCount);
        Buffer.AddColumn('Sonntag');
        Buffer.SetValueByIndex(0, 6, sundaysCount);
        Buffer.Update(CurrPage.Chart);

    end;

    local procedure setDepartmentFilter(department: Code[20])
    begin
        rec03.SetRange(Department, department);
        calcKrankheitsdaten();
    end;

    local procedure setYearFilter(year: Integer)
    begin
        rec03.SetRange(Jahr, year);
        calcKrankheitsdaten();
    end;

    local procedure setEmployeeFilter(employee: Code[20])
    begin
        rec03.SetRange("Employee No.", employee);
        calcKrankheitsdaten();
    end;

    local procedure setGenderFilter(gender: Integer)
    begin
        if (gender = 1) then begin
            rec03.SetRange("Gender", 1);
        end else begin
            rec03.SetRange("Gender", 2);
        end;


        calcKrankheitsdaten();
    end;

    local procedure resetTmpData()
    begin
        Clear(rec03);
        rec03.DeleteAll();
        startDate := 20190301D;
        endDate := 20210301D;
        mondaysCount := 0;
        thursdaysCount := 0;
        wednesDaysCount := 0;
        tuesdaysCount := 0;
        fridaysCount := 0;
        saturdaysCount := 0;
        sundaysCount := 0;
        calcKrankheitsdaten();
    end;

    var
        startDate: date;
        endDate: date;
        tmpDat: date;
        mondaysCount: Integer;
        tuesdaysCount: Integer;
        wednesDaysCount: Integer;
        thursdaysCount: Integer;
        fridaysCount: Integer;
        saturdaysCount: Integer;
        sundaysCount: Integer;
        counter: Integer;
        selDepartment: Code[20];
        selEmployee: Code[20];
        selGender: Integer;
        rec5207: Record 5207;
        rec03: Record 123456711;
        rec04: Record 123456712;
        rec7602: Record 7602;
        CU7600: Codeunit 7600;
        Buffer: Record "Business Chart Buffer" temporary;


}
