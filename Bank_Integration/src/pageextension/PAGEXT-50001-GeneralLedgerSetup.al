pageextension 50001 GeneralLedgerSetup extends "General Ledger Setup"
{
    layout
    {
        addlast(General)
        {
            field("HSBC Payment File Nos."; Rec."HSBC Payment File Nos.")
            {
                ApplicationArea = All;
            }
        }
    }
}