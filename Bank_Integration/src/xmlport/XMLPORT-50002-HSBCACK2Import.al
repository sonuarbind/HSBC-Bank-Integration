xmlport 50002 "HSBC ACK2 Import"
{
    Caption = 'HSBC ACK2 Import';
    Direction = Import;
    Format = Xml;

    schema
    {
        textelement(Document)
        {
            XmlName = 'Document';

            textelement(CstmrPmtStsRpt)
            {

                //=====================================================
                // GROUP HEADER
                //=====================================================

                textelement(GrpHdr)
                {

                    textelement(MsgId)
                    {
                        trigger OnAfterAssignVariable()
                        begin
                            AckMsgId := MsgId;
                        end;
                    }
                    textelement(CreDtTm)
                    {
                        trigger OnAfterAssignVariable()
                        begin
                            Evaluate(AckDateTimeText, CreDtTm);
                        end;
                    }
                    textelement(InitgPty)
                    {
                        MinOccurs = Zero;

                        textelement(Id)
                        {
                            MinOccurs = Zero;

                            textelement(OrgId)
                            {
                                MinOccurs = Zero;

                                textelement(BICOrBEI)
                                {
                                    MinOccurs = Zero;

                                    trigger OnAfterAssignVariable()
                                    begin
                                        BICCode := BICOrBEI;
                                    end;
                                }
                                textelement(Othr)
                                {
                                    MinOccurs = Zero;

                                    textelement(OtherId)
                                    {
                                        XmlName = 'Id';

                                        MinOccurs = Zero;

                                        trigger OnAfterAssignVariable()
                                        begin
                                            OrganisationId := OtherId;
                                        end;
                                    }
                                }
                            }
                        }
                    }
                }
                //=====================================================
                // ORIGINAL GROUP INFORMATION
                //=====================================================
                textelement(OrgnlGrpInfAndSts)
                {

                    textelement(OrgnlMsgId)
                    {
                        trigger OnAfterAssignVariable()
                        begin
                            OriginalMsgId := OrgnlMsgId;
                        end;
                    }
                    textelement(OrgnlMsgNmId)
                    {
                        trigger OnAfterAssignVariable()
                        begin
                            OriginalMsgType := OrgnlMsgNmId;
                        end;
                    }
                    textelement(OrgnlCreDtTm)
                    {
                        MinOccurs = Zero;

                        trigger OnAfterAssignVariable()
                        begin
                            OriginalCreationDateTime := OrgnlCreDtTm;
                        end;
                    }
                    textelement(OrgnlNbOfTxs)
                    {
                        trigger OnAfterAssignVariable()
                        begin
                            Evaluate(NoOfTransactions, OrgnlNbOfTxs);
                        end;
                    }
                    textelement(OrgnlCtrlSum)
                    {
                        trigger OnAfterAssignVariable()
                        begin
                            Evaluate(ControlSum, OrgnlCtrlSum);
                        end;
                    }
                    textelement(GrpSts)
                    {
                        trigger OnAfterAssignVariable()
                        begin
                            GroupStatus := UpperCase(GrpSts);
                        end;
                    }
                }
                //=====================================================
                // ORIGINAL PAYMENT INFORMATION
                //=====================================================
                textelement(OrgnlPmtInfAndSts)
                {
                    textelement(OrgnlPmtInfId)
                    {
                        trigger OnAfterAssignVariable()
                        begin
                            OriginalPaymentInfoId := OrgnlPmtInfId;
                        end;
                    }
                    textelement(OrgnlNbOfTxs2)
                    {
                        XmlName = 'OrgnlNbOfTxs';

                        trigger OnAfterAssignVariable()
                        begin
                            Evaluate(PaymentInfoNoOfTxs, OrgnlNbOfTxs2);
                        end;
                    }
                    textelement(OrgnlCtrlSum2)
                    {
                        XmlName = 'OrgnlCtrlSum';

                        trigger OnAfterAssignVariable()
                        begin
                            Evaluate(PaymentInfoCtrlSum, OrgnlCtrlSum2);
                        end;
                    }
                    textelement(PmtInfSts)
                    {
                        trigger OnAfterAssignVariable()
                        begin
                            PaymentInfoStatus := UpperCase(PmtInfSts);
                        end;
                    }
                    //=================================================
                    // TRANSACTION LOOP
                    //=================================================
                    textelement(TxInfAndSts)
                    {
                        MinOccurs = Zero;
                        MaxOccurs = Unbounded;

                        textelement(StsId)
                        {
                            trigger OnAfterAssignVariable()
                            begin
                                StatusId := StsId;
                            end;
                        }

                        textelement(OrgnlEndToEndId)
                        {
                            trigger OnAfterAssignVariable()
                            begin
                                EndToEndID := OrgnlEndToEndId;
                            end;
                        }
                        textelement(TxSts)
                        {
                            trigger OnAfterAssignVariable()
                            begin
                                TransactionStatus := UpperCase(TxSts);
                            end;
                        }
                        textelement(StsRsnInf)
                        {
                            MinOccurs = Zero;

                            textelement(Rsn)
                            {
                                MinOccurs = Zero;

                                textelement(RsnCd)
                                {
                                    XmlName = 'Cd';

                                    trigger OnAfterAssignVariable()
                                    begin
                                        ReasonCode := RsnCd;
                                    end;
                                }
                            }

                            textelement(AddtlInf)
                            {
                                MinOccurs = Zero;

                                trigger OnAfterAssignVariable()
                                begin
                                    if TransactionStatus = 'ACCP' then begin
                                        UETR := AddtlInf;
                                    end else begin
                                        if AdditionalInfo1 = '' then
                                            AdditionalInfo1 := AddtlInf
                                        else
                                            AdditionalInfo2 := AddtlInf;
                                    end;
                                end;
                            }
                        }
                        textelement(OrgnlTxRef)
                        {
                            textelement(Amt)
                            {
                                textelement(InstdAmt)
                                {
                                    textattribute(Ccy)
                                    {
                                        XmlName = 'Ccy';

                                        trigger OnAfterAssignVariable()
                                        begin
                                            CurrencyCode := Ccy;
                                        end;
                                    }
                                    trigger OnAfterAssignVariable()
                                    begin
                                        Evaluate(TransactionAmount, InstdAmt);
                                    end;
                                }
                            }
                            textelement(ReqdExctnDt)
                            {
                                trigger OnAfterAssignVariable()
                                begin
                                    Evaluate(ExecutionDate, ReqdExctnDt);
                                end;
                            }
                            //=========================================
                            // Debtor
                            //=========================================
                            textelement(Dbtr)
                            {
                                textelement(DbtrName)
                                {
                                    XmlName = 'Nm';

                                    trigger OnAfterAssignVariable()
                                    begin
                                        DebtorName := DbtrName;
                                    end;
                                }
                            }

                            //=========================================
                            // Debtor Account
                            //=========================================
                            textelement(DbtrAcct)
                            {
                                textelement(Id1)
                                {
                                    XmlName = 'Id';

                                    textelement(Othr1)
                                    {
                                        XmlName = 'Othr';

                                        textelement(DbtrAccount)
                                        {
                                            XmlName = 'Id';

                                            trigger OnAfterAssignVariable()
                                            begin
                                                DebtorAccount := DbtrAccount;
                                            end;
                                        }
                                    }
                                }
                            }

                            //=========================================
                            // Debtor Agent
                            //=========================================
                            textelement(DbtrAgt)
                            {
                                textelement(FinInstnId)
                                {
                                    textelement(DbtrBIC)
                                    {
                                        XmlName = 'BIC';

                                        trigger OnAfterAssignVariable()
                                        begin
                                            DebtorBIC := DbtrBIC;
                                        end;
                                    }
                                }
                            }

                            //=========================================
                            // Creditor Agent
                            //=========================================
                            textelement(CdtrAgt)
                            {
                                textelement(FinInstnId2)
                                {
                                    XmlName = 'FinInstnId';

                                    textelement(ClrSysMmbId)
                                    {
                                        textelement(MmbId)
                                        {
                                            trigger OnAfterAssignVariable()
                                            begin
                                                CreditorBankCode := MmbId;
                                            end;
                                        }
                                    }
                                }
                            }

                            //=========================================
                            // Creditor
                            //=========================================
                            textelement(Cdtr)
                            {
                                textelement(CdtrName)
                                {
                                    XmlName = 'Nm';

                                    trigger OnAfterAssignVariable()
                                    begin
                                        CreditorName := CdtrName;
                                    end;
                                }
                            }

                            //=========================================
                            // Creditor Account
                            //=========================================
                            textelement(CdtrAcct)
                            {
                                textelement(Id2)
                                {
                                    XmlName = 'Id';

                                    textelement(Othr2)
                                    {
                                        XmlName = 'Othr';

                                        textelement(CdtrAccount)
                                        {
                                            XmlName = 'Id';

                                            trigger OnAfterAssignVariable()
                                            begin
                                                CreditorAccount := CdtrAccount;
                                            end;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    trigger OnPostXmlPort()
    var
        PaymentSubscriber: Codeunit "Payment Voucher Subscriber";
    begin
        UpdatePaymentStatus();
        PaymentSubscriber.MoveToHistory();

        Message('ACK2 Imported Successfully.\' + 'Original Message ID : %1\' + 'Group Status : %2', OriginalMsgId, TransactionStatus);
    end;


    local procedure UpdatePaymentStatus()
    var
        HSBCPaymentStaging: Record "HSBC Payment Staging";
        // HSBCAppSetup: Record "HSBC App Setup";
        AckDateTime: DateTime;
        TotalAmount: Decimal;
        TotalCount: Integer;
        StatusMismatch: Boolean;
        HSBCLogEntries: Codeunit "HSBC Log Entries";
    begin
        //--------------------------------------------------------
        // Convert ACK Date Time
        if Format(AckDateTimeText) <> '' then
            if not Evaluate(AckDateTime, Format(AckDateTimeText)) then
                Error('Invalid ACK Date Time.');

        //--------------------------------------------------------
        // Validate Setup
        //--------------------------------------------------------
        // if not HSBCAppSetup.FindFirst() then
        //     Error('HSBC App Setup does not exist.');

        // HSBCAppSetup.TestField("Ack2 Message ID");
        // HSBCAppSetup.TestField("Ack2 Creation Date Time");
        // HSBCAppSetup.TestField("Ack2 Organisation BIC/BEI");
        // HSBCAppSetup.TestField("Ack2 Organisation ID");
        //--------------------------------------------------------
        // Validate ACK1 Information from Setup
        //--------------------------------------------------------
        // if (HSBCAppSetup."Ack2 Message ID" <> '') and (UpperCase(HSBCAppSetup."Ack2 Message ID") <> UpperCase(AckMsgId)) then
        //     Error('Original Message ID mismatch. Setup=%1 XML=%2', HSBCAppSetup."Ack2 Message ID", AckMsgId);

        // if (HSBCAppSetup."Ack2 Creation Date Time" <> 0DT) and (HSBCAppSetup."Ack2 Creation Date Time" <> AckDateTimeText) then
        //     Error('Creation Date Time mismatch. Setup=%1 XML=%2', HSBCAppSetup."Ack2 Creation Date Time", AckDateTimeText);

        // if (HSBCAppSetup."Ack2 Organisation BIC/BEI" <> '') and (UpperCase(HSBCAppSetup."Ack2 Organisation BIC/BEI") <> UpperCase(BICCode)) then
        //     Error('Organisation BIC mismatch. Setup=%1 XML=%2', HSBCAppSetup."Ack2 Organisation BIC/BEI", BICCode);

        // if (HSBCAppSetup."Ack2 Organisation ID" <> '') and (UpperCase(HSBCAppSetup."Ack2 Organisation ID") <> UpperCase(OrganisationId)) then
        //     Error('Organisation ID mismatch. Setup=%1 XML=%2', HSBCAppSetup."Ack2 Organisation ID", OrganisationId);




        // //--------------------------------------------------------
        // // Find Staging Records
        // //--------------------------------------------------------
        HSBCPaymentStaging.Reset();
        HSBCPaymentStaging.SetRange("Message ID", CopyStr(OriginalMsgId, 1, MaxStrLen(HSBCPaymentStaging."Message ID")));

        if not HSBCPaymentStaging.FindSet() then
            Error('No staging records found for Original Message ID %1', OriginalMsgId);

        //--------------------------------------------------------
        // Calculate totals
        //--------------------------------------------------------
        TotalAmount := 0;
        TotalCount := 0;

        repeat
            TotalCount += 1;
            TotalAmount += HSBCPaymentStaging.Amount;
        until HSBCPaymentStaging.Next() = 0;

        //--------------------------------------------------------
        // Validate Count & Amount
        //--------------------------------------------------------
        StatusMismatch := false;

        if TotalCount <> PaymentInfoNoOfTxs then
            StatusMismatch := true;

        if Round(TotalAmount, 0.01) <> Round(ControlSum, 0.01) then
            StatusMismatch := true;

        //--------------------------------------------------------
        // Update Records
        //--------------------------------------------------------
        HSBCPaymentStaging.Reset();
        HSBCPaymentStaging.SetRange("Message ID", CopyStr(OriginalMsgId, 1, MaxStrLen(HSBCPaymentStaging."Message ID")));

        if HSBCPaymentStaging.FindSet(true) then
            repeat

                //--------------------------------------------------------
                // Original Message ID
                //--------------------------------------------------------
                if UpperCase(HSBCPaymentStaging."Message ID") <> UpperCase(OriginalMsgId) then
                    Error('Original Message ID mismatch. Staging=%1 XML=%2', HSBCPaymentStaging."Message ID", OriginalMsgId);

                //--------------------------------------------------------
                // Payment Information ID (If available in table)
                //--------------------------------------------------------
                // if UpperCase(HSBCPaymentStaging."Payment Information ID") <>
                //    UpperCase(OriginalPaymentInfoId)
                // then
                //     Error('Payment Information ID mismatch.');

                //--------------------------------------------------------
                // Amount
                //--------------------------------------------------------
                if Round(HSBCPaymentStaging.Amount, 0.01) <> Round(TransactionAmount, 0.01) then
                    Error('Amount mismatch. Staging=%1 XML=%2', HSBCPaymentStaging.Amount, TransactionAmount);

                //--------------------------------------------------------
                // Currency
                //--------------------------------------------------------
                // if UpperCase(HSBCPaymentStaging."Currency Code") <> UpperCase(CurrencyCode) then
                //     Error('Currency mismatch. Staging=%1 XML=%2', HSBCPaymentStaging."Currency Code", CurrencyCode);

                //--------------------------------------------------------
                // Execution Date
                //--------------------------------------------------------
                if HSBCPaymentStaging."Execution Date" <> ExecutionDate then
                    Error('Execution Date mismatch. Staging=%1 XML=%2', HSBCPaymentStaging."Execution Date", ExecutionDate);

                //--------------------------------------------------------
                // Debtor Name
                //--------------------------------------------------------
                if UpperCase(DelChr(HSBCPaymentStaging."Debtor Name", '=', ' ')) <> UpperCase(DelChr(DebtorName, '=', ' ')) then
                    Error('Debtor Name mismatch. Staging=%1 XML=%2', HSBCPaymentStaging."Debtor Name", DebtorName);

                //--------------------------------------------------------
                // Debtor Account
                //--------------------------------------------------------
                if UpperCase(HSBCPaymentStaging."Debtor Account No.") <> UpperCase(DebtorAccount) then
                    Error('Debtor Account mismatch. Staging=%1 XML=%2', HSBCPaymentStaging."Debtor Account No.", DebtorAccount);

                //--------------------------------------------------------
                // Debtor BIC
                //--------------------------------------------------------
                if UpperCase(HSBCPaymentStaging."SWIFT Code") <> UpperCase(DebtorBIC) then
                    Error('Debtor BIC mismatch. Staging=%1 XML=%2', HSBCPaymentStaging."SWIFT Code", DebtorBIC);

                //--------------------------------------------------------
                // Vendor Name
                //--------------------------------------------------------
                if UpperCase(DelChr(HSBCPaymentStaging."Vendor Name", '=', ' ')) <> UpperCase(DelChr(CreditorName, '=', ' ')) then
                    Error('Vendor Name mismatch. Staging=%1 XML=%2', HSBCPaymentStaging."Vendor Name", CreditorName);

                //--------------------------------------------------------
                // Beneficiary Account
                //--------------------------------------------------------
                if UpperCase(HSBCPaymentStaging."Beneficiary Account No.") <> UpperCase(CreditorAccount) then
                    Error('Beneficiary Account mismatch. Staging=%1 XML=%2', HSBCPaymentStaging."Beneficiary Account No.", CreditorAccount);

                //--------------------------------------------------------
                // Beneficiary Bank Code
                //--------------------------------------------------------
                if UpperCase(HSBCPaymentStaging."Beneficiary Bank Code") <> UpperCase(CreditorBankCode) then
                    Error('Beneficiary Bank Code mismatch. Staging=%1 XML=%2', HSBCPaymentStaging."Beneficiary Bank Code", CreditorBankCode);

                //--------------------------------------------------------
                // End To End ID
                //--------------------------------------------------------
                if UpperCase(HSBCPaymentStaging."End To End ID") <> UpperCase(EndToEndID) then
                    Error('End To End ID mismatch. Staging=%1 XML=%2', HSBCPaymentStaging."End To End ID", EndToEndID);

                //--------------------------------------------------------
                // Duplicate Import
                //--------------------------------------------------------
                if HSBCPaymentStaging."Payment Received At Bank" then
                    Error('ACK2 already imported for Message ID %1.', OriginalMsgId);

                //--------------------------------------------------------
                // Update fields
                //--------------------------------------------------------

                HSBCPaymentStaging."Ack2 Message ID" := AckMsgId;
                HSBCPaymentStaging."Ack2 Creation Date Time" := AckDateTimeText;
                HSBCPaymentStaging."Ack2 Organisation BIC/BEI" := BICCode;
                HSBCPaymentStaging."Ack2 Organisation ID" := OrganisationId;
                HSBCPaymentStaging."UETR No." := UETR;
                // HSBCPaymentStaging."Ack2 Message ID" := HSBCAppSetup."Ack2 Message ID";

                // HSBCPaymentStaging."Ack2 Creation Date Time" := HSBCAppSetup."Ack2 Creation Date Time";

                // HSBCPaymentStaging."Ack2 Organisation BIC/BEI" := HSBCAppSetup."Ack2 Organisation BIC/BEI";

                // HSBCPaymentStaging."Ack2 Organisation ID" := HSBCAppSetup."Ack2 Organisation ID";

                //--------------------------------------------------------
                // Save ACK Import Information
                //--------------------------------------------------------
                HSBCPaymentStaging."Payment Received At Bank" := true;
                HSBCPaymentStaging."ACK Date Time" := AckDateTime;

                //--------------------------------------------------------
                // Status
                //--------------------------------------------------------
                if StatusMismatch then begin
                    HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::RJCT;

                    HSBCPaymentStaging."Status Reason" := StrSubstNo('ACK Validation Failed. HSBC Txns=%1, BC Txns=%2, HSBC Amount=%3, BC Amount=%4', PaymentInfoNoOfTxs, TotalCount, ControlSum, TotalAmount);

                end else begin

                    case TransactionStatus of
                        'ACTC':
                            begin
                                HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::ACTC;
                                HSBCPaymentStaging."Status Reason" := 'Technical Validation Successful';
                            end;

                        'ACCP':
                            begin
                                HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::ACCP;
                                HSBCPaymentStaging."Status Reason" := 'Accepted By HSBC';
                            end;

                        'ACSP':
                            begin
                                HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::ACSP;
                                HSBCPaymentStaging."Status Reason" := 'Settlement Processing Started';
                            end;

                        'ACSC':
                            begin
                                HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::ACSC;
                                HSBCPaymentStaging."Status Reason" := 'Payment Completed Successfully';
                            end;

                        'RJCT':
                            begin
                                HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::RJCT;
                                HSBCPaymentStaging."Status Reason" := 'Rejected By HSBC';
                            end;

                        'PDNG':
                            begin
                                HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::PDNG;
                                HSBCPaymentStaging."Status Reason" := 'Pending At HSBC';
                            end;
                    end;
                end;

                HSBCPaymentStaging.Modify(true);
                //--------------------------------------------------------
                // Insert Log Entry
                //--------------------------------------------------------
                HSBCLogEntries.InsertHSBCLog(HSBCPaymentStaging, Enum::"HSBC Log Type"::ACK2, ReasonCode, AdditionalInfo1);

            until HSBCPaymentStaging.Next() = 0;

        Message('ACK Imported Successfully.\Original Message=%1\Status=%2\Transactions=%3\Amount=%4', OriginalMsgId, TransactionStatus, PaymentInfoNoOfTxs, ControlSum);
    end;

    var
        HSBCPaymentStaging: Record "HSBC Payment Staging";
        AckDateTime: DateTime;
        ExecutionDate: text[10];
        TransactionAmount: Decimal;
        AckMsgId: Code[100];
        AckDateTimeText: DateTime;
        BICCode: Code[20];
        OrganisationId: Code[50];
        OriginalMsgId: Code[100];
        OriginalMsgType: Code[50];
        OriginalCreationDateTime: Text;
        NoOfTransactions: Integer;
        ControlSum: Decimal;
        GroupStatus: Code[10];
        OriginalPaymentInfoId: Code[100];
        PaymentInfoNoOfTxs: Integer;
        PaymentInfoCtrlSum: Decimal;
        PaymentInfoStatus: Code[20];
        StatusId: Code[50];
        EndToEndID: Code[50];
        TransactionStatus: Code[10];
        ReasonCode: Code[20];
        AdditionalInfo1: Text[250];
        AdditionalInfo2: Text[250];
        CurrencyCode: Code[10];
        DebtorName: Text[100];
        DebtorAccount: Code[50];
        DebtorBIC: Code[20];
        CreditorBankCode: Code[30];
        CreditorName: Text[100];
        CreditorAccount: Code[50];
        NoOfTxns: Integer;
        UETR: Text[100];
}
