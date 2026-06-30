table 50004 "HSBC Payment Log"
{
    Caption = 'HSBC Payment Log';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Staging Entry No."; Integer)
        {
            Caption = 'Staging Entry No.';
        }
        field(3; "Document No."; Code[20])
        {
        }
        field(4; "Vendor No."; Code[20])
        {
        }
        field(5; "Vendor Name"; Text[100])
        {
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; "Currency Code"; Code[10])
        {
        }
        field(8; "Beneficiary Account No."; Text[50])
        {
        }
        field(9; "Beneficiary Bank Code"; Code[20])
        {
        }
        field(10; "End To End ID"; Code[50])
        {
        }
        field(11; "Instruction ID"; Code[50])
        {
        }
        field(12; "Message ID"; Code[50])
        {
        }
        field(13; "Payment File No."; Code[30])
        {
        }
        field(14; "Batch No."; Code[20])
        {
        }
        field(15; "Execution Date"; Text[10])
        {
        }
        field(16; "Payment Status"; Enum "HSBC Payment Status")
        {
        }
        field(17; "Status Reason"; Text[250])
        {
        }
        field(18; "Payment Send to Bank"; Boolean)
        {
        }
        field(19; "Payment Push Bank"; Boolean)
        {
        }
        field(20; "Payment Received At Bank"; Boolean)
        {
        }
        field(21; "ACK1 File Imported"; Boolean)
        {
        }
        field(22; Posted; Boolean)
        {
        }
        field(23; "Export Date Time"; DateTime)
        {
        }
        field(24; "ACK Date Time"; DateTime)
        {
        }

        // ACK1 Information
        field(25; "Ack1 Message ID"; Code[50])
        {
        }
        field(26; "Ack1 Creation Date Time"; DateTime)
        {
        }
        field(27; "Ack1 Organisation BIC/BEI"; Code[20])
        {
        }
        field(28; "Ack1 Organisation ID"; Code[50])
        {
        }

        // ACK2 Information
        field(29; "Ack2 Message ID"; Code[50])
        {
        }
        field(30; "Ack2 Creation Date Time"; DateTime)
        {
        }
        field(31; "Ack2 Organisation BIC/BEI"; Code[20])
        {
        }
        field(32; "Ack2 Organisation ID"; Code[50])
        {
        }
        field(33; "UETR No."; Text[100])
        {
        }

        // Log Information
        field(34; "Log Type"; Enum "HSBC Log Type")
        {
            Caption = 'Log Type';
        }
        field(35; "Log Date Time"; DateTime)
        {
        }
        field(36; "Processed By"; Code[50])
        {
        }
        field(37; "Remarks"; Text[250])
        {
        }
        field(38; "File Name"; Text[100])
        {
        }
        field(39; "Reason Code"; Code[20])
        {
            Caption = 'Reason Code';
            DataClassification = CustomerContent;
        }
        field(40; "Additional Information"; Text[250])
        {
            Caption = 'Additional Information';
            DataClassification = CustomerContent;
        }
        field(41; "Imported By"; Code[50])
        {
            Caption = 'Imported By';
            DataClassification = SystemMetadata;
        }
        field(42; "Imported Date Time"; DateTime)
        {
            Caption = 'Imported Date Time';
            DataClassification = SystemMetadata;
        }
        field(43; "Source File"; Text[100])
        {
            Caption = 'Source File';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

        key(Key1; "Staging Entry No.")
        {
        }

        key(Key2; "Message ID")
        {
        }

        key(Key3; "End To End ID")
        {
        }

        key(Key4; "UETR No.")
        {
        }
    }
}