tableextension 50003 MyExtension extends "User Setup"
{
    fields
    {
        field(50000; "HSBC App Setup Access"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "HSBC Payment Access"; Boolean)
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