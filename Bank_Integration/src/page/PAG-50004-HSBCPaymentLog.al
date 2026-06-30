page 50004 "HSBC Payment Log Page"
{
    ApplicationArea = All;
    Caption = 'HSBC Payment Log Page';
    PageType = List;
    SourceTable = "HSBC Payment Log";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Payment Send to Bank"; Rec."Payment Send to Bank")
                {
                    ToolTip = 'Specifies the value of the Payment Send to Bank field.', Comment = '%';
                }
                field("Payment Push Bank"; Rec."Payment Push Bank")
                {
                    ToolTip = 'Specifies the value of the Payment Push Bank field.', Comment = '%';
                }
                field("Payment Received At Bank"; Rec."Payment Received At Bank")
                {
                    ToolTip = 'Specifies the value of the Payment Received At Bank field.', Comment = '%';
                }
                field("ACK1 File Imported"; Rec."ACK1 File Imported")
                {
                    ToolTip = 'Specifies the value of the ACK1 File Imported field.', Comment = '%';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Staging Entry No."; Rec."Staging Entry No.")
                {
                    ToolTip = 'Specifies the value of the Staging Entry No. field.', Comment = '%';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field.', Comment = '%';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ToolTip = 'Specifies the value of the Vendor Name field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.', Comment = '%';
                }
                field("Beneficiary Account No."; Rec."Beneficiary Account No.")
                {
                    ToolTip = 'Specifies the value of the Beneficiary Account No. field.', Comment = '%';
                }
                field("Beneficiary Bank Code"; Rec."Beneficiary Bank Code")
                {
                    ToolTip = 'Specifies the value of the Beneficiary Bank Code field.', Comment = '%';
                }
                field("End To End ID"; Rec."End To End ID")
                {
                    ToolTip = 'Specifies the value of the End To End ID field.', Comment = '%';
                }
                field("Instruction ID"; Rec."Instruction ID")
                {
                    ToolTip = 'Specifies the value of the Instruction ID field.', Comment = '%';
                }
                field("Message ID"; Rec."Message ID")
                {
                    ToolTip = 'Specifies the value of the Message ID field.', Comment = '%';
                }
                field("Payment File No."; Rec."Payment File No.")
                {
                    ToolTip = 'Specifies the value of the Payment File No. field.', Comment = '%';
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ToolTip = 'Specifies the value of the Batch No. field.', Comment = '%';
                }
                field("Execution Date"; Rec."Execution Date")
                {
                    ToolTip = 'Specifies the value of the Execution Date field.', Comment = '%';
                }
                field("Payment Status"; Rec."Payment Status")
                {
                    ToolTip = 'Specifies the value of the Payment Status field.', Comment = '%';
                }
                field("Status Reason"; Rec."Status Reason")
                {
                    ToolTip = 'Specifies the value of the Status Reason field.', Comment = '%';
                }

                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
                field("Export Date Time"; Rec."Export Date Time")
                {
                    ToolTip = 'Specifies the value of the Export Date Time field.', Comment = '%';
                }
                field("ACK Date Time"; Rec."ACK Date Time")
                {
                    ToolTip = 'Specifies the value of the ACK Date Time field.', Comment = '%';
                }
                field("Ack1 Message ID"; Rec."Ack1 Message ID")
                {
                    ToolTip = 'Specifies the value of the Ack1 Message ID field.', Comment = '%';
                }
                field("Ack1 Creation Date Time"; Rec."Ack1 Creation Date Time")
                {
                    ToolTip = 'Specifies the value of the Ack1 Creation Date Time field.', Comment = '%';
                }
                field("Ack1 Organisation BIC/BEI"; Rec."Ack1 Organisation BIC/BEI")
                {
                    ToolTip = 'Specifies the value of the Ack1 Organisation BIC/BEI field.', Comment = '%';
                }
                field("Ack1 Organisation ID"; Rec."Ack1 Organisation ID")
                {
                    ToolTip = 'Specifies the value of the Ack1 Organisation ID field.', Comment = '%';
                }
                field("Ack2 Message ID"; Rec."Ack2 Message ID")
                {
                    ToolTip = 'Specifies the value of the Ack2 Message ID field.', Comment = '%';
                }
                field("Ack2 Creation Date Time"; Rec."Ack2 Creation Date Time")
                {
                    ToolTip = 'Specifies the value of the Ack2 Creation Date Time field.', Comment = '%';
                }
                field("Ack2 Organisation BIC/BEI"; Rec."Ack2 Organisation BIC/BEI")
                {
                    ToolTip = 'Specifies the value of the Ack2 Organisation BIC/BEI field.', Comment = '%';
                }
                field("Ack2 Organisation ID"; Rec."Ack2 Organisation ID")
                {
                    ToolTip = 'Specifies the value of the Ack2 Organisation ID field.', Comment = '%';
                }
                field("UETR No."; Rec."UETR No.")
                {
                    ToolTip = 'Specifies the value of the UETR No. field.', Comment = '%';
                }
                field("Log Type"; Rec."Log Type")
                {
                    ToolTip = 'Specifies the value of the Log Type field.', Comment = '%';
                }
                field("Log Date Time"; Rec."Log Date Time")
                {
                    ToolTip = 'Specifies the value of the Log Date Time field.', Comment = '%';
                }
                field("Processed By"; Rec."Processed By")
                {
                    ToolTip = 'Specifies the value of the Processed By field.', Comment = '%';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                }
                field("File Name"; Rec."File Name")
                {
                    ToolTip = 'Specifies the value of the File Name field.', Comment = '%';
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup_Rec: Record "User Setup";
    begin
        if GuiAllowed then begin
            UserSetup_Rec.Get(UserId);
            if not UserSetup_Rec."HSBC Payment Access" then
                Error('You do not have permission to access this page.');
        end;
    end;
}
