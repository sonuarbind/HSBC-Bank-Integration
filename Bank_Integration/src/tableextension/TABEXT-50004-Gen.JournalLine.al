tableextension 50004 GenJournalLine extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "HSBC Payment Type"; Enum "HSBC Payment Type")
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}