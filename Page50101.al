page 50101 CleanupControl
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = TableCleanupLog;
    SourceTableTemporary = true;
    Caption = 'Table Cleanup';
    AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                }
                field("Table Name"; Rec."Table Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RunCleanup)
            {
                ApplicationArea = All;
                Caption = 'Run Cleanup';
                trigger OnAction();
                var
                    recref: RecordRef;
                    logrec: Record TableCleanupLog;
                    accctl: Record "Access Control";
                    questionNo, lastEntryNo : Integer;
                begin
                    Rec.Reset;
                    if Rec.Find('-') then begin
                        accctl.SetRange("User Security ID", UserSecurityId);
                        accctl.SetRange("Role ID", 'SUPER');
                        accctl.SetRange("Company Name", '');
                        if accctl.IsEmpty then begin
                            Message(Text001);
                            exit;
                        end;
                        for questionNo := 1 to 3 do begin
                            if not Confirm(Text002, false, questionNo) then begin
                                exit;
                            end;
                        end;
                        logrec.FindLast;
                        lastEntryNo := logrec."Entry No.";
                        repeat
                            if Rec."Table ID" <> 50100 then begin
                                logrec."Entry No." := lastEntryNo;
                                lastEntryNo += 1;
                                logrec."Cleared by User ID" := UserId;
                                logrec."Cleared DateTime" := CurrentDateTime;
                                logrec."Number of Records Deleted" := recref.Count;
                                logrec.Validate("Table ID", rec."Table ID");
                                logrec.Insert;
                                recref.Open(Rec."Table ID");
                                recref.DeleteAll(false);
                            end;
                        until rec.Next = 0;
                        Message(Text001);
                    end
                    else begin
                        Message(Text003);
                    end;
                end;
            }
        }
    }
    var
        Text000: Label 'Cleanup completed.';
        Text001: Label 'You must be administrator to run this function.';
        Text002: Label 'Question %1: Are you sure you want to clean up all selected tables?';
        Text003: Label 'No records for cleanup were selected.';
}