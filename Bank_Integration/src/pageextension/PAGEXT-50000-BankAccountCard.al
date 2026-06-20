pageextension 50000 BankAccountCard extends "Bank Account Card"
{
    layout
    {
        modify("IFSC Code")
        {
            Visible = true;
        }
        addafter(Blocked)
        {
            field("HSBC Bank"; Rec."HSBC Bank")
            {
                ApplicationArea = All;
            }
            field("HSBC BIC Code"; Rec."HSBC BIC Code")
            {
                ApplicationArea = All;
            }

            field("HSBC Company ID"; Rec."HSBC Company ID")
            {
                ApplicationArea = All;
            }
        }
    }
}