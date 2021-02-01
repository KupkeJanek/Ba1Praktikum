page 123456714 SicknessLevelPage
{

    Caption = 'SicknessLevelPage';
    PageType = List;
    SourceTable = SicknessLevel;

    layout
    {
        area(content)
        {
            group(Parameter)
            {
                field("Start Datum"; startDate)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("End Datum"; endDate)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Datum; Rec.Datum)
                {
                    ApplicationArea = All;
                }
                field(KFehlzeiten; Rec.KFehlzeiten)
                {
                    ApplicationArea = All;
                }

                field(SumIstArbeitszeit; Rec.SumIstArbeitszeit)
                {
                    ApplicationArea = All;
                }
                field(SumSollArbeitszeit; Rec.SumSollArbeitszeit)
                {
                    ApplicationArea = All;
                }
            }
            usercontrol(Chart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = All;

            }
            group(MitarbeiterTimeTable)
            {
                part("Mitarbeiter TimeTable"; EmplyeeTimeTablePage)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {

        area(Navigation)
        {
            action("Datum übernehmen")
            {
                ApplicationArea = all;
                ToolTip = 'Datum übernehmen';
                Image = "8ball";
                trigger OnAction()
                begin
                    initEmployeeTimeTable();
                end;
            }
        }
    }



    trigger OnOpenPage()
    begin
        startDate := 20190301D;
        endDate := 20210301D;
        rec01.DeleteAll();

    end;

    local procedure initEmployeeTimeTable()
    begin
        rec01.DeleteAll();
        counter := 1;
        for tmpDate := startDate to endDate do
            if rec02.FindFirst() then begin
                repeat
                    rec01."No." := counter;
                    rec01.Date := tmpDate;
                    rec01.EmployeeNo := rec02."No.";
                    rec01.DepartmentNo := rec02.Department;
                    rec01.SArbeitszeit := 0;
                    rec01.IArbeitszeit := 0;
                    if rec7602.FindFirst() then begin
                        if NOT CU7600.IsNonworkingDay(tmpDate, rec7602) then begin
                            rec01.SArbeitszeit := 1;
                            rec01.IArbeitszeit := 1;
                            rec5207.SetRange("Employee No.", rec02."No.");

                            if rec5207.FindFirst() then begin
                                repeat
                                    for secondTmpDate := rec5207."From Date" to rec5207."To Date" do
                                        if secondTmpDate = tmpDate then begin
                                            if rec5207."Unit of Measure Code" = 'STUNDE' then begin
                                                case rec5207."Cause of Absence Code" of
                                                    'URLAUB':
                                                        begin
                                                            rec01.SArbeitszeit := rec01.SArbeitszeit - rec5207."Quantity (Base)";
                                                            rec01.IArbeitszeit := rec01.IArbeitszeit - rec5207."Quantity (Base)";
                                                        end;

                                                    else begin
                                                            rec01.IArbeitszeit := rec01.IArbeitszeit - rec5207."Quantity (Base)";
                                                        end;
                                                end
                                            end else begin
                                                case rec5207."Cause of Absence Code" of
                                                    'URLAUB':
                                                        begin
                                                            rec01.SArbeitszeit := 0;
                                                            rec01.IArbeitszeit := 0;
                                                        end;

                                                    else begin
                                                            rec01.IArbeitszeit := 0;
                                                        end;
                                                end
                                            end;
                                        end;
                                until rec5207.Next() = 0;
                            end;
                        end;
                    end;

                    if ((rec01.IArbeitszeit = 0) and (rec01.SArbeitszeit > 0)) then begin
                        rec01.Krankheitsstand := 1;
                    end else
                        if ((rec01.IArbeitszeit > 0) and (rec01.SArbeitszeit > 0)) then begin
                            rec01.Krankheitsstand := 1 - rec01.IArbeitszeit / rec01.SArbeitszeit;
                        end;

                    rec01.Insert();
                    counter := counter + 1;
                until rec02.next = 0;

            end;


        initSicknessLevel();


    end;

    local procedure initSicknessLevel()
    begin
        rec03.DeleteAll();
        counter := 1;
        for tmpDate := startDate to endDate do begin
            rec03.Datum := tmpDate;
            rec03.No := counter;
            rec03.Insert();
            counter := counter + 1;
        end;
    end;

    var
        startDate: Date;
        endDate: Date;
        tmpDate: Date;
        secondTmpDate: Date;
        counter: Integer;

        rec01: REcord EmployeeTimeTable;
        rec02: Record Employee;
        rec03: Record SicknessLevel;

        rec7602: Record 7602;
        rec5207: Record 5207;

        CU7600: Codeunit 7600;
        Buffer: Record "Business Chart Buffer" temporary;


}
