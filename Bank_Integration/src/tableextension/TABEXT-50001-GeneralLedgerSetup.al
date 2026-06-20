tableextension 50001 GLSetup extends "General Ledger Setup"
{
    fields
    {
        field(50000; "HSBC Payment File Nos."; Code[20])
        {
            Caption = 'HSBC Payment File Nos.';
            TableRelation = "No. Series";
        }
    }
}