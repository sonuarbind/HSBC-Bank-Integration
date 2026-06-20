table 50002 "HSBC ACK Log"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "ACK Message ID"; Code[50]) { }

        field(3; "Original Message ID"; Code[50]) { }

        field(4; "Message Type"; Code[35]) { }

        field(5; "ACK Date Time"; DateTime) { }

        field(6; "No. Of Transactions"; Integer) { }

        field(7; "Control Sum"; Decimal) { }

        field(8; Status; Code[10]) { }

        field(9; "Status Reason"; Text[250]) { }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

        key(Key1; "Original Message ID")
        {
        }
    }
}