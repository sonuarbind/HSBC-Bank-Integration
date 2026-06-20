pageextension 50002 VendBankAccountCard extends "Vendor Bank Account Card"
{
    layout
    {
        addafter("SWIFT Code")
        {
            field("IFSC Code"; Rec."IFSC Code")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}