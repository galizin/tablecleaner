table 50100 TableCleanupLog
{
    DataPerCompany = true;

    fields
    {
        field(1; "Entry No."; Integer)
        {

        }
        field(2; "Table ID"; Integer)
        {
            //TableRelation=Object.ID where (Type = const (Table));
            trigger OnValidate();
            var
                recref: RecordRef;
            begin
                recref.Open("Table ID");
                "Table Name" := recref.Name;
            end;
        }
        field(3; "Table Name"; Text[30])
        {

        }
        field(4; "Cleared by User ID"; Text[30])
        {

        }
        field(5; "Cleared DateTime"; DateTime)
        {

        }
        field(6; "Number of Records Deleted"; Integer)
        {

        }
    }
    keys
    {
        key(PrimaryKey; "Entry No.")
        {
            Clustered = true;
        }
    }

}