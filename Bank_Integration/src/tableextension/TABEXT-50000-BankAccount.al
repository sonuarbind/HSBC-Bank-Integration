tableextension 50000 BankAccount extends "Bank Account"
{
    fields
    {
        field(50000; "HSBC Bank"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "HSBC BIC Code"; Code[20])
        {
            Caption = 'HSBC BIC Code';
            DataClassification = CustomerContent;
        }

        field(50002; "HSBC Company ID"; Code[50])
        {
            Caption = 'HSBC Company ID';
            DataClassification = CustomerContent;
        }

    }
}