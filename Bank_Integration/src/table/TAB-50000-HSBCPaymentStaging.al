table 50000 "HSBC Payment Staging"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Beneficiary Account No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Beneficiary Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Beneficiary Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Payment Reference"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "End To End ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Message ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Execution Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Payment Status"; Enum "HSBC Payment Status")
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Status Reason"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "HSBC Payment"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Payment Push Bank"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "File Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "ACK Received"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Debtor Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(22; "Debtor Account No."; Code[50])
        {
            DataClassification = CustomerContent;
        }

        field(23; "Debtor BIC"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(24; "Payment Type"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(25; "Charge Bearer"; Code[10])
        {
            DataClassification = CustomerContent;
        }

        field(26; "Remittance Email"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(27; "Remittance ID"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(28; "Export Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
        }

        field(29; "ACK Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(30; "Batch No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(31; "Payment File No."; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(32; "Instruction ID"; Code[50])
        {
            DataClassification = CustomerContent;
        }

        field(33; "Debtor Country"; Code[10])
        {
        }

        field(34; "Debtor Address 1"; Text[100])
        {
        }

        field(35; "Debtor Address 2"; Text[100])
        {
        }

        field(36; "Creditor Country"; Code[10])
        {
        }

        field(37; "Creditor Address 1"; Text[100])
        {
        }

        field(38; "Creditor Address 2"; Text[100])
        {
        }

        field(39; "Creditor Address 3"; Text[100])
        {
        }

        field(40; "Remittance Method"; Code[10])
        {
        }

        field(41; "Bank Country"; Code[10])
        {
        }

        field(42; "Local Instrument"; Code[20])
        {
        }

        field(43; "Category Purpose"; Code[20])
        {
        }
        field(44; "Bank Address 1"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(45; "Bank Address 2"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(46; "SWIFT Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "IFSC Code"; Code[11])
        {
            Caption = 'IFSC Code';
        }
        field(48; "Country/Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Bank Country/Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Payment Received At Bank"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "HSBC Payment Type"; Enum "HSBC Payment Type")
        {
            DataClassification = ToBeClassified;
        }
        field(53; "ACK BIC Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(54; "ACK Organisation ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
