page 50000 "HSBC Payment Staging"
{
    ApplicationArea = All;
    Caption = 'HSBC Payment Staging';
    PageType = List;
    SourceTable = "HSBC Payment Staging";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Payment Push Bank"; Rec."Payment Push Bank")
                {
                    ToolTip = 'Specifies the value of the Payment Push Bank field.', Comment = '%';
                }
                field("Payment Received At Bank"; Rec."Payment Received At Bank")
                {
                    ToolTip = 'Specifies the value of the Payment Received At Bank field.', Comment = '%';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
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
                field("HSBC Payment Type"; Rec."HSBC Payment Type")
                {
                    ToolTip = 'Specifies the value of the HSBC Payment Type field.', Comment = '%';
                }
                field("Beneficiary Account No."; Rec."Beneficiary Account No.")
                {
                    ToolTip = 'Specifies the value of the Beneficiary Account No. field.', Comment = '%';
                }
                field("Beneficiary Bank Code"; Rec."Beneficiary Bank Code")
                {
                    ToolTip = 'Specifies the value of the Beneficiary Bank Code field.', Comment = '%';
                }
                field("Beneficiary Bank Name"; Rec."Beneficiary Bank Name")
                {
                    ToolTip = 'Specifies the value of the Beneficiary Bank Name field.', Comment = '%';
                }
                field("IFSC Code"; Rec."IFSC Code")
                {
                    ToolTip = 'Specifies the value of the IFSC Code field.', Comment = '%';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the Country/Region Code field.', Comment = '%';
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ToolTip = 'Specifies the value of the Payment Reference field.', Comment = '%';
                }
                field("End To End ID"; Rec."End To End ID")
                {
                    ToolTip = 'Specifies the value of the End To End ID field.', Comment = '%';
                }
                field("Message ID"; Rec."Message ID")
                {
                    ToolTip = 'Specifies the value of the Message ID field.', Comment = '%';
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
                field("HSBC Payment"; Rec."HSBC Payment")
                {
                    ToolTip = 'Specifies the value of the HSBC Payment field.', Comment = '%';
                }
                field("File Name"; Rec."File Name")
                {
                    ToolTip = 'Specifies the value of the File Name field.', Comment = '%';
                }
                field("ACK Received"; Rec."ACK Received")
                {
                    ToolTip = 'Specifies the value of the ACK Received field.', Comment = '%';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
                field("Debtor Name"; Rec."Debtor Name")
                {
                    ToolTip = 'Specifies the value of the Debtor Name field.', Comment = '%';
                }
                field("Debtor Account No."; Rec."Debtor Account No.")
                {
                    ToolTip = 'Specifies the value of the Debtor Account No. field.', Comment = '%';
                }
                field("SWIFT Code"; Rec."SWIFT Code")
                {
                    ToolTip = 'Specifies the value of the SWIFT Code field.', Comment = '%';
                }
                field("Bank Address 1"; Rec."Bank Address 1")
                {
                    ToolTip = 'Specifies the value of the Bank Address 1 field.', Comment = '%';
                }
                field("Bank Address 2"; Rec."Bank Address 2")
                {
                    ToolTip = 'Specifies the value of the Bank Address 2 field.', Comment = '%';
                }
                field("Bank Country/Region Code"; Rec."Bank Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the Bank Country/Region Code field.', Comment = '%';
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ToolTip = 'Specifies the value of the Payment Type field.', Comment = '%';
                }
                field("Charge Bearer"; Rec."Charge Bearer")
                {
                    ToolTip = 'Specifies the value of the Charge Bearer field.', Comment = '%';
                }
                field("Remittance Email"; Rec."Remittance Email")
                {
                    ToolTip = 'Specifies the value of the Remittance Email field.', Comment = '%';
                }
                field("Remittance ID"; Rec."Remittance ID")
                {
                    ToolTip = 'Specifies the value of the Remittance ID field.', Comment = '%';
                }
                field("Export Date Time"; Rec."Export Date Time")
                {
                    ToolTip = 'Specifies the value of the Export Date Time field.', Comment = '%';
                }
                field("ACK Date Time"; Rec."ACK Date Time")
                {
                    ToolTip = 'Specifies the value of the ACK Date Time field.', Comment = '%';
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ToolTip = 'Specifies the value of the Batch No. field.', Comment = '%';
                }
                field("Payment File No."; Rec."Payment File No.")
                {
                    ToolTip = 'Specifies the value of the Payment File No. field.', Comment = '%';
                }
                field("Instruction ID"; Rec."Instruction ID")
                {
                    ToolTip = 'Specifies the value of the Instruction ID field.', Comment = '%';
                }
                field("Debtor Country"; Rec."Debtor Country")
                {
                    ToolTip = 'Specifies the value of the Debtor Country field.', Comment = '%';
                }
                field("Debtor Address 1"; Rec."Debtor Address 1")
                {
                    ToolTip = 'Specifies the value of the Debtor Address 1 field.', Comment = '%';
                }
                field("Debtor Address 2"; Rec."Debtor Address 2")
                {
                    ToolTip = 'Specifies the value of the Debtor Address 2 field.', Comment = '%';
                }
                field("Creditor Country"; Rec."Creditor Country")
                {
                    ToolTip = 'Specifies the value of the Creditor Country field.', Comment = '%';
                }
                field("Creditor Address 1"; Rec."Creditor Address 1")
                {
                    ToolTip = 'Specifies the value of the Creditor Address 1 field.', Comment = '%';
                }
                field("Creditor Address 2"; Rec."Creditor Address 2")
                {
                    ToolTip = 'Specifies the value of the Creditor Address 2 field.', Comment = '%';
                }
                field("Creditor Address 3"; Rec."Creditor Address 3")
                {
                    ToolTip = 'Specifies the value of the Creditor Address 3 field.', Comment = '%';
                }
                field("Remittance Method"; Rec."Remittance Method")
                {
                    ToolTip = 'Specifies the value of the Remittance Method field.', Comment = '%';
                }
                field("Bank Country"; Rec."Bank Country")
                {
                    ToolTip = 'Specifies the value of the Bank Country field.', Comment = '%';
                }
                field("Local Instrument"; Rec."Local Instrument")
                {
                    ToolTip = 'Specifies the value of the Local Instrument field.', Comment = '%';
                }
                field("Category Purpose"; Rec."Category Purpose")
                {
                    ToolTip = 'Specifies the value of the Category Purpose field.', Comment = '%';
                }



            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Push For Payment")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = Export;

                trigger OnAction()
                var
                    HSBCMgmt: Codeunit "HSBC Payment Mgmt";
                    SelectedPayments: Record "HSBC Payment Staging";
                begin
                    CurrPage.SetSelectionFilter(SelectedPayments);
                    HSBCMgmt.GeneratePaymentFile(SelectedPayments);
                end;
            }

            action("Update Payment Status")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = Import;

                trigger OnAction()
                var
                    HSBCAck: Codeunit "Update Payment Status";
                begin
                    HSBCAck.UpdatePaymentStatus();
                end;
            }

            action(GenerateXML)
            {
                Caption = 'Generate XML';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = Export;
                trigger OnAction()
                var
                    HSBCMgmt: Codeunit "HSBC Payment Mgmt";
                    SelectedPayments: Record "HSBC Payment Staging";
                begin
                    CurrPage.SetSelectionFilter(SelectedPayments);
                    HSBCMgmt.GeneratePaymentFile(SelectedPayments);
                end;
            }

            action(ImportACK)
            {
                Caption = 'Import ACK';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = Import;
                trigger OnAction()
                var
                    AckProcessor: Codeunit "HSBC ACK Processor";
                begin
                    AckProcessor.ImportACK();
                end;
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
