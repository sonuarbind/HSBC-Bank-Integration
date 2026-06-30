xmlport 50001 "HSBC pain002 Import"
{
    Direction = Import;
    Format = Xml;
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
    begin
        UpdatePaymentStatus();
        Message('ACK Imported Successfully.\Original Message=%1\Status=%2', OriginalMsgId, GroupStatus);
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
        // Read ACK Date Time
        //--------------------------------------------------------
        if Format(AckDateTimeText) <> '' then
            if not Evaluate(AckDateTime, Format(AckDateTimeText)) then
                Error('Invalid ACK Date Time.');

        //--------------------------------------------------------
        // Validate Setup
        //--------------------------------------------------------
        // if not HSBCAppSetup.FindFirst() then
        //     Error('HSBC App Setup does not exist.');

        // HSBCAppSetup.TestField("Ack1 Message ID");
        // HSBCAppSetup.TestField("Ack1 Creation Date Time");
        // HSBCAppSetup.TestField("Ack1 Organisation BIC/BEI");
        // HSBCAppSetup.TestField("Ack1 Organisation ID");
        //--------------------------------------------------------
        // Validate ACK1 Information from Setup
        //--------------------------------------------------------
        // if (HSBCAppSetup."Ack1 Message ID" <> '') and (UpperCase(HSBCAppSetup."Ack1 Message ID") <> UpperCase(AckMsgId)) then
        //     Error('Original Message ID mismatch. Setup=%1 XML=%2', HSBCAppSetup."Ack1 Message ID", AckMsgId);

        // if (HSBCAppSetup."Ack1 Creation Date Time" <> 0DT) and (HSBCAppSetup."Ack1 Creation Date Time" <> AckDateTimeText) then
        //     Error('Creation Date Time mismatch. Setup=%1 XML=%2', HSBCAppSetup."Ack1 Creation Date Time", AckDateTimeText);

        // if (HSBCAppSetup."Ack1 Organisation BIC/BEI" <> '') and (UpperCase(HSBCAppSetup."Ack1 Organisation BIC/BEI") <> UpperCase(BICCode)) then
        //     Error('Organisation BIC mismatch. Setup=%1 XML=%2', HSBCAppSetup."Ack1 Organisation BIC/BEI", BICCode);

        // if (HSBCAppSetup."Ack1 Organisation ID" <> '') and (UpperCase(HSBCAppSetup."Ack1 Organisation ID") <> UpperCase(OrganisationId)) then
        //     Error('Organisation ID mismatch. Setup=%1 XML=%2', HSBCAppSetup."Ack1 Organisation ID", OrganisationId);

        //--------------------------------------------------------
        // Find Staging Records
        //--------------------------------------------------------
        HSBCPaymentStaging.Reset();
        HSBCPaymentStaging.SetRange("Message ID", CopyStr(OriginalMsgId, 1, MaxStrLen(HSBCPaymentStaging."Message ID")));

        if not HSBCPaymentStaging.FindSet() then
            Error('No staging records found for Message ID %1', OriginalMsgId);

        //--------------------------------------------------------
        // Calculate Totals
        //--------------------------------------------------------
        repeat
            TotalCount += 1;
            TotalAmount += HSBCPaymentStaging.Amount;
        until HSBCPaymentStaging.Next() = 0;

        StatusMismatch := false;

        if TotalCount <> NoOfTxns then
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
                // Save ACK1 Information
                //--------------------------------------------------------
                HSBCPaymentStaging."Ack1 Message ID" := AckMsgId;

                HSBCPaymentStaging."Ack1 Organisation BIC/BEI" := BICCode;

                HSBCPaymentStaging."Ack1 Organisation ID" := OrganisationId;

                HSBCPaymentStaging."Ack1 Creation Date Time" := AckDateTimeText;
                //--------------------------------------------------------
                // Save ACK Import Information
                //--------------------------------------------------------
                HSBCPaymentStaging."ACK1 File Imported" := true;

                //--------------------------------------------------------
                // Status
                //--------------------------------------------------------
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

                //--------------------------------------------------------
                // Insert Log Entry
                //--------------------------------------------------------
                HSBCLogEntries.InsertHSBCLog(HSBCPaymentStaging, Enum::"HSBC Log Type"::ACK1, '', '')

            until HSBCPaymentStaging.Next() = 0;

        Message('ACK Imported Successfully.\Original Message=%1\Status=%2\Transactions=%3\Amount=%4', OriginalMsgId, GroupStatus, NoOfTxns, ControlSum);
    end;

    var
        AckMsgId: Text[100];
        AckDateTimeText: DateTime;

        OriginalMsgId: Text[100];
        OriginalMsgType: Text[50];
        OriginalCreationDateTime: Text[50];

        BICCode: Text[50];
        OrganisationId: Text[100];

        GroupStatus: Text[20];

        NoOfTxns: Integer;
        ControlSum: Decimal;
}



