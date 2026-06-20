xmlport 50001 "HSBC pain002 Import"
{
    Direction = Import;
    Format = Xml;

    // DefaultNamespace = 'urn:iso:std:iso:20022:tech:xsd:pain.002.001.03';
    // UseDefaultNamespace = true;

    schema
    {
        textelement(Document)
        {
            textelement(CstmrPmtStsRpt)
            {
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
                            AckDateTimeText := CreDtTm;
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
                            Evaluate(NoOfTxns, OrgnlNbOfTxs);
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
            }
        }
    }

    trigger OnPostXmlPort()
    var
        PaymentSubscriber: Codeunit "Payment Voucher Subscriber";
    begin
        UpdatePaymentStatus();

        PaymentSubscriber.MoveToHistory();

        Message('ACK Imported Successfully.\Original Message=%1\Status=%2', OriginalMsgId, GroupStatus);
    end;

    local procedure UpdatePaymentStatus()
    var
        HSBCPaymentStaging: Record "HSBC Payment Staging";
        AckDateTime: DateTime;
        TotalAmount: Decimal;
        TotalCount: Integer;
        StatusMismatch: Boolean;
    begin
        // Convert ACK Date Time
        if AckDateTimeText <> '' then
            if not Evaluate(AckDateTime, AckDateTimeText) then
                AckDateTime := CurrentDateTime();

        // Validate required fields
        if AckMsgId = '' then
            Error('ACK Message ID is blank.');

        if OriginalMsgId = '' then
            Error('Original Message ID is blank.');

        if GroupStatus = '' then
            Error('Group Status is blank.');

        // Find records
        HSBCPaymentStaging.Reset();
        HSBCPaymentStaging.SetRange("Message ID", CopyStr(OriginalMsgId, 1, MaxStrLen(HSBCPaymentStaging."Message ID")));

        if not HSBCPaymentStaging.FindSet() then
            Error('No staging records found for Original Message ID %1', OriginalMsgId);

        // Calculate totals
        TotalAmount := 0;
        TotalCount := 0;

        repeat
            TotalCount += 1;
            TotalAmount += HSBCPaymentStaging.Amount;
        until HSBCPaymentStaging.Next() = 0;

        // Validate count and amount
        StatusMismatch := false;

        if TotalCount <> NoOfTxns then
            StatusMismatch := true;

        if Round(TotalAmount, 0.01) <>
           Round(ControlSum, 0.01)
        then
            StatusMismatch := true;

        // Re-open for update
        HSBCPaymentStaging.Reset();
        HSBCPaymentStaging.SetRange("Message ID", CopyStr(OriginalMsgId, 1, MaxStrLen(HSBCPaymentStaging."Message ID")));

        if HSBCPaymentStaging.FindSet(true) then
            repeat

                HSBCPaymentStaging."ACK Received" := true;
                HSBCPaymentStaging."Payment Received At Bank" := true;
                HSBCPaymentStaging."ACK Date Time" := AckDateTime;

                // Validation failed
                if StatusMismatch then begin

                    HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::RJCT;

                    HSBCPaymentStaging."Status Reason" := StrSubstNo('ACK Validation Failed. HSBC Txns=%1, BC Txns=%2, HSBC Amount=%3, BC Amount=%4', NoOfTxns, TotalCount, ControlSum, TotalAmount);

                end else begin

                    case GroupStatus of

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

                        else begin
                            HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::RJCT;

                            HSBCPaymentStaging."Status Reason" := StrSubstNo('Unknown HSBC Status %1', GroupStatus);
                        end;
                    end;
                end;

                HSBCPaymentStaging.Modify(true);

            until HSBCPaymentStaging.Next() = 0;

        Message('ACK Imported Successfully.\Original Message=%1\Status=%2\Transactions=%3\Amount=%4', OriginalMsgId, GroupStatus, NoOfTxns, ControlSum);
    end;


    // local procedure UpdatePaymentStatus()
    // var
    //     HSBCPaymentStaging: Record "HSBC Payment Staging";
    //     AckDateTime: DateTime;
    //     TotalAmount: Decimal;
    //     TotalCount: Integer;
    // begin
    //     // ==========================
    //     // Basic ACK Validations
    //     // ==========================

    //     if AckMsgId = '' then
    //         Error('ACK Message ID is blank.');

    //     if OriginalMsgId = '' then
    //         Error('Original Message ID is blank.');

    //     if GroupStatus = '' then
    //         Error('Group Status is blank.');

    //     case GroupStatus of
    //         'ACTC', 'ACCP', 'ACSP', 'ACSC', 'RJCT', 'PDNG':
    //             ;
    //         else
    //             Error('Invalid HSBC Status %1', GroupStatus);
    //     end;

    //     // Convert ACK Date Time
    //     if AckDateTimeText <> '' then
    //         if not Evaluate(AckDateTime, AckDateTimeText) then
    //             AckDateTime := CurrentDateTime();

    //     // ==========================
    //     // Find Matching Records
    //     // ==========================

    //     HSBCPaymentStaging.Reset();
    //     HSBCPaymentStaging.SetRange("Message ID", CopyStr(OriginalMsgId, 1, MaxStrLen(HSBCPaymentStaging."Message ID")));

    //     if not HSBCPaymentStaging.FindSet() then
    //         Error('No staging records found for Original Message ID %1', OriginalMsgId);

    //     // ==========================
    //     // Duplicate ACK Validation
    //     // ==========================

    //     if HSBCPaymentStaging."ACK Received" then
    //         Error('ACK already received for Message ID %1', OriginalMsgId);

    //     // ==========================
    //     // Count Validation
    //     // ==========================

    //     TotalCount := 0;
    //     TotalAmount := 0;

    //     repeat
    //         TotalCount += 1;
    //         TotalAmount += HSBCPaymentStaging.Amount;
    //     until HSBCPaymentStaging.Next() = 0;

    //     if TotalCount <> NoOfTxns then
    //         Error('Transaction Count Mismatch.\HSBC=%1\Business Central=%2', NoOfTxns, TotalCount);

    //     // ==========================
    //     // Amount Validation
    //     // ==========================

    //     if Round(TotalAmount, 0.01) <>
    //        Round(ControlSum, 0.01)
    //     then
    //         Error('Control Sum Mismatch.\HSBC=%1\Business Central=%2', ControlSum, TotalAmount);

    //     // ==========================
    //     // Update Records
    //     // ==========================

    //     HSBCPaymentStaging.Reset();
    //     HSBCPaymentStaging.SetRange("Message ID", CopyStr(OriginalMsgId, 1, MaxStrLen(HSBCPaymentStaging."Message ID")));

    //     if HSBCPaymentStaging.FindSet(true) then
    //         repeat

    //             HSBCPaymentStaging."ACK Received" := true;
    //             HSBCPaymentStaging."Received At Bank" := true;
    //             HSBCPaymentStaging."ACK Date Time" := AckDateTime;

    //             case GroupStatus of

    //                 'ACTC':
    //                     begin
    //                         HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::ACTC;

    //                         HSBCPaymentStaging."Status Reason" := 'Technical Validation Successful';
    //                     end;

    //                 'ACCP':
    //                     begin
    //                         HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::ACCP;

    //                         HSBCPaymentStaging."Status Reason" := 'Accepted By HSBC';
    //                     end;

    //                 'ACSP':
    //                     begin
    //                         HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::ACSP;

    //                         HSBCPaymentStaging."Status Reason" := 'Settlement Processing Started';
    //                     end;

    //                 'ACSC':
    //                     begin
    //                         HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::ACSC;

    //                         HSBCPaymentStaging."Status Reason" := 'Payment Completed Successfully';
    //                     end;

    //                 'RJCT':
    //                     begin
    //                         HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::RJCT;

    //                         HSBCPaymentStaging."Status Reason" := 'Rejected By HSBC';
    //                     end;

    //                 'PDNG':
    //                     begin
    //                         HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::PDNG;

    //                         HSBCPaymentStaging."Status Reason" := 'Pending At HSBC';
    //                     end;
    //             end;

    //             HSBCPaymentStaging.Modify(true);

    //         until HSBCPaymentStaging.Next() = 0;

    //     Message('ACK Imported Successfully.\Original Message=%1\Status=%2\Transactions=%3\Amount=%4', OriginalMsgId, GroupStatus, NoOfTxns, ControlSum);
    // end;


    // local procedure UpdatePaymentStatus()
    // var
    //     HSBCPaymentStaging: Record "HSBC Payment Staging";
    //     AckDateTime: DateTime;
    //     TotalAmount: Decimal;
    //     TotalCount: Integer;
    //     StatusMismatch: Boolean;
    // begin

    //     // Convert ACK DateTime
    //     if AckDateTimeText <> '' then
    //         if not Evaluate(AckDateTime, AckDateTimeText) then
    //             AckDateTime := CurrentDateTime();

    //     // Find matching records
    //     if not FindMatchingRecords(HSBCPaymentStaging) then
    //         Error('No staging records found for Original Message ID %1', OriginalMsgId);

    //     // Calculate totals
    //     TotalAmount := 0;
    //     TotalCount := 0;

    //     if HSBCPaymentStaging.FindSet() then
    //         repeat
    //             TotalAmount += HSBCPaymentStaging.Amount;
    //             TotalCount += 1;
    //         until HSBCPaymentStaging.Next() = 0;

    //     // Validate ACK values
    //     StatusMismatch := false;

    //     if TotalCount <> NoOfTxns then
    //         StatusMismatch := true;

    //     if Round(TotalAmount, 0.01) <> Round(ControlSum, 0.01) then
    //         StatusMismatch := true;

    //     // Re-open records for update
    //     if not FindMatchingRecords(HSBCPaymentStaging) then
    //         Error('No staging records found for Original Message ID %1', OriginalMsgId);

    //     if HSBCPaymentStaging.FindSet(true) then
    //         repeat

    //             HSBCPaymentStaging."ACK Received" := true;
    //             HSBCPaymentStaging."Received At Bank" := true;
    //             HSBCPaymentStaging."ACK Date Time" := AckDateTime;

    //             if StatusMismatch then begin

    //                 HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::RJCT;

    //                 HSBCPaymentStaging."Status Reason" := StrSubstNo('ACK Validation Failed. HSBC Txns=%1, BC Txns=%2, HSBC Amount=%3, BC Amount=%4', NoOfTxns, TotalCount, ControlSum, TotalAmount);

    //             end else begin

    //                 case GroupStatus of

    //                     'ACTC':
    //                         begin
    //                             HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::ACTC;

    //                             HSBCPaymentStaging."Status Reason" := 'Technical validation successful';
    //                         end;

    //                     'ACCP':
    //                         begin
    //                             HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::ACCP;

    //                             HSBCPaymentStaging."Status Reason" := 'Accepted by HSBC';
    //                         end;

    //                     'ACSP':
    //                         begin
    //                             HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::ACSP;

    //                             HSBCPaymentStaging."Status Reason" := 'Payment processing started';
    //                         end;

    //                     'ACSC':
    //                         begin
    //                             HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::ACSC;

    //                             HSBCPaymentStaging."Status Reason" := 'Payment completed successfully';
    //                         end;

    //                     'RJCT':
    //                         begin
    //                             HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::RJCT;

    //                             HSBCPaymentStaging."Status Reason" := 'Rejected by HSBC';
    //                         end;

    //                     'PDNG':
    //                         begin
    //                             HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::PDNG;

    //                             HSBCPaymentStaging."Status Reason" := 'Pending at HSBC';
    //                         end;

    //                     else begin
    //                         HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::PDNG;

    //                         HSBCPaymentStaging."Status Reason" := StrSubstNo('Unknown HSBC Status %1', GroupStatus);
    //                     end;
    //                 end;
    //             end;

    //             HSBCPaymentStaging.Modify(true);

    //         until HSBCPaymentStaging.Next() = 0;

    //     Message('ACK Imported Successfully.\Original Message=%1\Status=%2\Transactions=%3\Amount=%4', OriginalMsgId, GroupStatus, NoOfTxns, ControlSum);
    // end;


    local procedure FindMatchingRecords(var HSBCPaymentStaging: Record "HSBC Payment Staging"): Boolean
    begin

        // Match by Message ID
        HSBCPaymentStaging.Reset();
        HSBCPaymentStaging.SetRange("Message ID", CopyStr(OriginalMsgId, 1, MaxStrLen(HSBCPaymentStaging."Message ID")));

        if HSBCPaymentStaging.FindFirst() then
            exit(true);

        // Match by Payment File No.
        HSBCPaymentStaging.Reset();
        HSBCPaymentStaging.SetRange("Payment File No.", CopyStr(OriginalMsgId, 1, MaxStrLen(HSBCPaymentStaging."Payment File No.")));

        if HSBCPaymentStaging.FindFirst() then
            exit(true);

        // Match by Batch No.
        HSBCPaymentStaging.Reset();
        HSBCPaymentStaging.SetRange("Batch No.", CopyStr(OriginalMsgId, 1, MaxStrLen(HSBCPaymentStaging."Batch No.")));

        if HSBCPaymentStaging.FindFirst() then
            exit(true);

        exit(false);
    end;

    var
        AckMsgId: Text[100];
        AckDateTimeText: Text[100];

        OriginalMsgId: Text[100];
        OriginalMsgType: Text[50];
        OriginalCreationDateTime: Text[50];

        BICCode: Text[50];
        OrganisationId: Text[100];

        GroupStatus: Text[20];

        NoOfTxns: Integer;
        ControlSum: Decimal;
}



