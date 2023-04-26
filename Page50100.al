// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

page 50100 TableCleanupLog
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = TableCleanupLog;
    UsageCategory = History;
    Caption = 'Table Cleanup Log';
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                }
                field("Table Name"; Rec."Table Name")
                {
                    ApplicationArea = All;
                }
                field("Cleared by User ID"; Rec."Cleared by User ID")
                {
                    ApplicationArea = All;
                }
                field("Cleared DateTime"; Rec."Cleared DateTime")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}