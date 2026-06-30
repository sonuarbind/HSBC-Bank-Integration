enum 50011 "HSBC Log Type"
{
    Extensible = true;
    Caption = 'HSBC Log Type';

    value(0; Export)
    {
        Caption = 'Export';
    }
    value(1; ACK1)
    {
        Caption = 'ACK1';
    }
    value(2; ACK2)
    {
        Caption = 'ACK2';
    }
    value(3; StatusUpdate)
    {
        Caption = 'Status Update';
    }
    value(4; Error)
    {
        Caption = 'Error';
    }
}