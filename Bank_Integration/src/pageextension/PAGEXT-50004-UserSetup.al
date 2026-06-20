pageextension 50004 UserSetup extends "User Setup"
{
    layout
    {
        addafter("Register Time")
        {
            field("HSBC App Setup Access"; Rec."HSBC App Setup Access")
            {
                ApplicationArea = All;
            }
            field("HSBC Payment Access"; Rec."HSBC Payment Access")
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