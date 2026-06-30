xmlport 50000 "HSBC pain001 Export"
{
    Direction = Export;
    Format = Xml;
    Encoding = UTF8;
    UseDefaultNamespace = true;
    DefaultNamespace = 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03';

    schema
    {
        textelement(Document)
        {
            XmlName = 'Document';

            textelement(CstmrCdtTrfInitn)
            {
                //------------------------------------
                // Group Header
                //------------------------------------
                textelement(GrpHdr)
                {
                    textelement(MsgId)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            MsgId := GlobalMessageID;
                        end;
                    }

                    textelement(CreDtTm)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            CreDtTm := CreationDateTimeTxt;
                        end;
                    }

                    textelement(Authstn)
                    {
                        textelement(Cd)
                        {
                            trigger OnBeforePassVariable()
                            begin
                                Cd := 'FSUM';
                            end;
                        }
                    }

                    textelement(NbOfTxs)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            NbOfTxs := Format(TransactionCount);
                        end;
                    }
                    textelement(CtrlSum)
                    {
                        trigger OnBeforePassVariable()
                        var
                            AmountText: Text;
                            DotPos: Integer;
                        begin
                            AmountText := Format(Round(TotalAmount, 0.01));

                            DotPos := StrPos(AmountText, '.');

                            if DotPos = 0 then
                                AmountText += '.00'
                            else
                                if StrLen(CopyStr(AmountText, DotPos + 1)) = 1 then
                                    AmountText += '0';

                            CtrlSum := AmountText;
                        end;
                    }

                    textelement(InitgPty)
                    {
                        textelement(Nm)
                        {
                            trigger OnBeforePassVariable()
                            begin
                                Nm := DebtorName;
                            end;
                        }

                        textelement(Id)
                        {
                            textelement(OrgId)
                            {
                                textelement(Othr)
                                {
                                    textelement(Id_Company)
                                    {
                                        XmlName = 'Id';

                                        trigger OnBeforePassVariable()
                                        begin
                                            Id_Company := HSBCCompanyID;
                                        end;
                                    }
                                }
                            }
                        }
                    }
                }

                //------------------------------------
                // Payment Information
                //------------------------------------
                textelement(PmtInf)
                {
                    textelement(PmtInfId)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            PmtInfId := GlobalMessageID;
                        end;
                    }

                    textelement(PmtMtd)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            PmtMtd := 'TRF';
                        end;
                    }

                    textelement(PmtTpInf)
                    {
                        textelement(SvcLvl)
                        {
                            textelement(SvcLvlCd)
                            {
                                XmlName = 'Cd';

                                trigger OnBeforePassVariable()
                                begin
                                    SvcLvlCd := 'NURG';
                                end;
                            }
                        }

                        textelement(LclInstrm)
                        {
                            textelement(Prtry)
                            {
                                trigger OnBeforePassVariable()
                                begin
                                    Prtry := 'SALA';
                                end;
                            }
                        }

                        textelement(CtgyPurp)
                        {
                            textelement(CtgyPurpCd)
                            {
                                XmlName = 'Cd';

                                trigger OnBeforePassVariable()
                                begin
                                    CtgyPurpCd := 'SALA';
                                end;
                            }
                        }
                    }

                    textelement(ReqdExctnDt)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            ReqdExctnDt := Format(Today, 0, '<Year4>-<Month,2>-<Day,2>');
                        end;
                    }

                    //------------------------------------
                    // Debtor
                    //------------------------------------
                    textelement(Dbtr)
                    {
                        textelement(DbtrNm)
                        {
                            XmlName = 'Nm';

                            trigger OnBeforePassVariable()
                            begin
                                DbtrNm := DebtorName;
                            end;
                        }

                        textelement(PstlAdr)
                        {
                            textelement(Ctry)
                            {
                                trigger OnBeforePassVariable()
                                begin
                                    Ctry := CountryReasoncode;
                                end;
                            }

                            textelement(AdrLine1)
                            {
                                XmlName = 'AdrLine';

                                trigger OnBeforePassVariable()
                                begin
                                    AdrLine1 := DebtorAddr1;
                                end;
                            }

                            textelement(AdrLine2)
                            {
                                XmlName = 'AdrLine';

                                trigger OnBeforePassVariable()
                                begin
                                    AdrLine2 := DebtorAddr2;
                                end;
                            }
                        }

                        textelement(CtryOfRes)
                        {
                            trigger OnBeforePassVariable()
                            begin
                                CtryOfRes := CountryReasoncode;
                            end;
                        }
                    }

                    //------------------------------------
                    // Debtor Account
                    //------------------------------------
                    textelement(DbtrAcct)
                    {
                        textelement(Id_Dbtr)
                        {
                            XmlName = 'Id';

                            textelement(Othr_Dbtr)
                            {
                                XmlName = 'Othr';

                                textelement(DbtrAccNo)
                                {
                                    XmlName = 'Id';

                                    trigger OnBeforePassVariable()
                                    begin
                                        DbtrAccNo := BeneficiaryAccountNo;
                                    end;
                                }
                            }
                        }

                        textelement(Ccy)
                        {
                            trigger OnBeforePassVariable()
                            begin
                                Ccy := 'INR';
                            end;
                        }
                    }

                    //------------------------------------
                    // Debtor Agent
                    //------------------------------------
                    textelement(DbtrAgt)
                    {
                        textelement(FinInstnId)
                        {

                            textelement(BIC)
                            {
                                trigger OnBeforePassVariable()
                                begin
                                    BIC := SWIFTCode;
                                end;
                            }

                            textelement(BankNm)
                            {
                                XmlName = 'Nm';

                                trigger OnBeforePassVariable()
                                begin
                                    BankNm := DebtorBankName;
                                end;
                            }

                            textelement(PstlAdr_Bank)
                            {
                                XmlName = 'PstlAdr';

                                textelement(BankCountry)
                                {
                                    XmlName = 'Ctry';

                                    trigger OnBeforePassVariable()
                                    begin
                                        BankCountry := BankCountryRegionCode;
                                    end;
                                }
                            }
                        }
                    }

                    textelement(ChrgBr)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            ChrgBr := 'SHAR';
                        end;
                    }

                    //------------------------------------
                    // Transactions
                    //------------------------------------
                    tableelement(Payment; "HSBC Payment Staging")
                    {
                        XmlName = 'CdtTrfTxInf';

                        textelement(PmtId)
                        {
                            textelement(InstrId)
                            {
                                trigger OnBeforePassVariable()
                                begin
                                    InstrId := Payment."Instruction ID";
                                end;
                            }

                            textelement(EndToEndId)
                            {
                                trigger OnBeforePassVariable()
                                begin
                                    EndToEndId := Payment."End To End ID";
                                end;
                            }
                        }

                        textelement(Amt)
                        {
                            // textelement(InstdAmt)
                            // {
                            //     XmlName = 'InstdAmt';

                            //     trigger OnBeforePassVariable()
                            //     begin
                            //         InstdAmt := Format(Payment.Amount);
                            //     end;
                            // }
                            textelement(InstdAmt)
                            {
                                XmlName = 'InstdAmt';

                                textattribute(CcyAttr)
                                {
                                    XmlName = 'Ccy';

                                    trigger OnBeforePassVariable()
                                    begin
                                        CcyAttr := 'INR';
                                    end;
                                }

                                trigger OnBeforePassVariable()
                                var
                                    AmountText: Text;
                                begin
                                    AmountText := Format(Round(Payment.Amount, 0.01));
                                    if StrPos(AmountText, '.') = 0 then
                                        AmountText += '.00'
                                    else
                                        if StrLen(CopyStr(AmountText, StrPos(AmountText, '.') + 1)) = 1 then
                                            AmountText += '0';

                                    InstdAmt := AmountText;
                                end;

                            }
                        }

                        textelement(CdtrAgt)
                        {
                            textelement(FinInstnId_Cdtr)
                            {
                                XmlName = 'FinInstnId';

                                textelement(ClrSysMmbId)
                                {
                                    textelement(MmbId)
                                    {
                                        trigger OnBeforePassVariable()
                                        begin
                                            MmbId := Payment."Debtor Account No."
                                        end;
                                    }
                                }

                                textelement(CdtrBankNm)
                                {
                                    XmlName = 'Nm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        CdtrBankNm := Payment."Debtor Name"
                                    end;
                                }

                                textelement(CdtrBankPstlAdr)
                                {
                                    XmlName = 'PstlAdr';

                                    textelement(CdtrBankCountry)
                                    {
                                        XmlName = 'Ctry';

                                        trigger OnBeforePassVariable()
                                        begin
                                            CdtrBankCountry := BankCountryRegionCode;
                                        end;
                                    }

                                    textelement(CdtrBankAdrLine1)
                                    {
                                        XmlName = 'AdrLine';

                                        trigger OnBeforePassVariable()
                                        begin
                                            CdtrBankAdrLine1 := Payment."Bank Address 1";
                                        end;
                                    }

                                    textelement(CdtrBankAdrLine2)
                                    {
                                        XmlName = 'AdrLine';

                                        trigger OnBeforePassVariable()
                                        begin
                                            CdtrBankAdrLine2 := Payment."Bank Address 2";
                                        end;
                                    }
                                }
                            }
                        }

                        // textelement(Cdtr)
                        // {
                        //     textelement(CdtrNm)
                        //     {
                        //         XmlName = 'Nm';

                        //         trigger OnBeforePassVariable()
                        //         begin
                        //             CdtrNm := CompanyInfo.Name;
                        //         end;
                        //     }
                        // }

                        textelement(Cdtr)
                        {
                            textelement(CdtrNm)
                            {
                                XmlName = 'Nm';

                                trigger OnBeforePassVariable()
                                begin
                                    CdtrNm := CompanyInfo.Name;
                                end;
                            }

                            textelement(CdtrPstlAdr)
                            {
                                XmlName = 'PstlAdr';

                                textelement(CdtrAdrLine1)
                                {
                                    XmlName = 'AdrLine';

                                    trigger OnBeforePassVariable()
                                    begin
                                        CdtrAdrLine1 := CompanyInfo.Address;
                                    end;
                                }

                                textelement(CdtrAdrLine2)
                                {
                                    XmlName = 'AdrLine';

                                    trigger OnBeforePassVariable()
                                    begin
                                        CdtrAdrLine2 := CompanyInfo."Address 2";
                                    end;
                                }
                            }
                        }

                        textelement(CdtrAcct)
                        {
                            textelement(Id_Cdtr)
                            {
                                XmlName = 'Id';

                                textelement(Othr_Cdtr)
                                {
                                    XmlName = 'Othr';

                                    textelement(CdtrAccNo)
                                    {
                                        XmlName = 'Id';

                                        trigger OnBeforePassVariable()
                                        begin
                                            CdtrAccNo := Payment."Debtor Account No.";
                                        end;
                                    }
                                }
                            }
                        }

                        textelement(RmtInf)
                        {
                            textelement(Ustrd)
                            {
                                trigger OnBeforePassVariable()
                                begin
                                    Ustrd := Payment."Payment Reference";
                                end;
                            }
                        }
                        trigger OnAfterGetRecord()
                        var
                            HSBCLogEntriesCU: Codeunit "HSBC Log Entries";
                        begin
                            TransactionNo += 1;

                            // Payment."Instruction ID" := CopyStr('I' + Format(TransactionNo) + PaymentFileNo, 1, MaxStrLen(Payment."Instruction ID"));

                            // Payment."End To End ID" := CopyStr('E' + Format(TransactionNo) + PaymentFileNo, 1, MaxStrLen(Payment."End To End ID"));

                            // Payment."Message ID" := GlobalMessageID;
                            // Payment."Payment File No." := PaymentFileNo;

                            Payment."Payment Push Bank" := true;
                            Payment."Payment Send to Bank" := true;
                            Payment."Export Date Time" := CurrentDateTime;
                            Payment.Modify();
                        end;
                    }
                }
            }
        }
    }
    trigger OnPreXmlPort()
    var
        GLSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit "No. Series";
        BankAcc: Record "Bank Account";
    begin
        CompanyInfo.Get();
        GLSetup.Get();
        GLSetup.TestField("HSBC Payment File Nos.");

        // PaymentFileNo := NoSeriesMgt.GetNextNo(GLSetup."HSBC Payment File Nos.", Today, true);

        BankAcc.SetRange("HSBC Bank", true);

        if not BankAcc.FindFirst() then
            Error('No HSBC Bank Account configured.');

        HSBCCompanyID := BankAcc."HSBC Company ID";
        DebtorAccountNo := BankAcc."Bank Account No.";
        DebtorBIC := BankAcc."HSBC BIC Code";
        DebtorBankName := BankAcc.Name;

        // GlobalMessageID := PaymentFileNo;

        CreationDateTimeTxt := Format(CurrentDateTime, 0, '<Year4>-<Month,2>-<Day,2>T<Hours24,2>:<Minutes,2>:<Seconds,2>');


        TransactionCount := 0;
        TotalAmount := 0;

        if Payment.FindSet() then
            repeat
                TransactionCount += 1;
                TotalAmount += Payment.Amount;
            until Payment.Next() = 0;

        if TransactionCount = 0 then
            Error('No records available for export.');

        FirstPayment.Reset();
        FirstPayment.SetRange("Payment Push Bank", false);
        if FirstPayment.FindFirst() then begin
            DebtorName := FirstPayment."Vendor Name";
            DebtorAddr1 := FirstPayment."Debtor Address 1";
            DebtorAddr2 := FirstPayment."Debtor Address 2";
            CountryReasoncode := FirstPayment."Country/Region Code";
            BeneficiaryAccountNo := FirstPayment."Beneficiary Account No.";
            SWIFTCode := FirstPayment."SWIFT Code";
            BankCountryRegionCode := FirstPayment."Bank Country/Region Code";
            GlobalMessageID := FirstPayment."Message ID";
        end;
    end;


    var
        CompanyInfo: Record "Company Information";
        HSBCPaymentStagingRec: Record "HSBC Payment Staging";

        HSBCCompanyID: Code[50];
        DebtorAccountNo: Code[50];
        DebtorBIC: Code[20];
        DebtorBankName: Text[100];

        GlobalMessageID: Code[50];
        CreationDateTimeTxt: Text[30];

        TransactionCount: Integer;
        TransactionNo: Integer;

        PaymentFileNo: Code[30];

        TotalAmount: Decimal;
        FirstPayment: Record "HSBC Payment Staging";
        DebtorName: Text[100];
        DebtorAddr1: Text[100];
        DebtorAddr2: Text[100];
        CountryReasoncode: Code[10];
        BeneficiaryAccountNo: Text[50];
        SWIFTCode: Code[20];
        BankCountryRegionCode: Code[10];
}
