tableextension 50002 VendBankAccount extends "Vendor Bank Account"
{
    fields
    {
        field(50000; "IFSC Code"; Code[11])
        {
            Caption = 'IFSC Code';
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