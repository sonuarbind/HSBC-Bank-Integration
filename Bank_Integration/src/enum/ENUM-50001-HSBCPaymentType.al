enum 50001 "HSBC Payment Type"
{
    Extensible = true;
    Caption = 'HSBC Payment Type';

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; NEFT)
    {
        Caption = 'NEFT';
    }
    value(2; RTGS)
    {
        Caption = 'RTGS';
    }
    value(3; IMPS)
    {
        Caption = 'IMPS';
    }
    value(4; "UPI Transfers")
    {
        Caption = 'UPI Transfers';
    }
}