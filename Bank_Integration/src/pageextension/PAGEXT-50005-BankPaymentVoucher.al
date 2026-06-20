pageextension 50005 BankPaymentVoucher extends "Bank Payment Voucher"
{
    layout
    {
        addafter("Account No.")
        {
            field("HSBC Payment Type"; Rec."HSBC Payment Type")
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