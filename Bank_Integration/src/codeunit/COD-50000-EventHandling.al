codeunit 50000 "Payment Voucher Subscriber"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterInitBankAccLedgEntry, '', false, false)]
    local procedure GenJnlPostLine_OnAfterInitBankAccLedgEntry(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        HSBCPaymentStaging: Record "HSBC Payment Staging";
        VendorBankAccount: Record "Vendor Bank Account";
        BankAccount: Record "Bank Account";
        CompanyInfo: Record "Company Information";
        VendorRec: Record Vendor;
    begin

        if BankAccountLedgerEntry."Bank Account No." = '' then
            exit;

        if not BankAccount.Get(BankAccountLedgerEntry."Bank Account No.") then
            exit;

        if not BankAccount."HSBC Bank" then
            exit;

        // HSBC Bank
        if BankAccount."HSBC Bank" then begin
            if GenJournalLine."HSBC Payment Type" = GenJournalLine."HSBC Payment Type"::" " then
                Error('HSBC Payment Type must be selected because the Balance Bank Account "%1" is configured as an HSBC Bank.', BankAccount."No.");
        end else begin
            // Non-HSBC Bank
            if GenJournalLine."HSBC Payment Type" <> GenJournalLine."HSBC Payment Type"::" " then
                GenJournalLine.Validate("HSBC Payment Type", GenJournalLine."HSBC Payment Type"::" ");
        end;

        CompanyInfo.Get();

        HSBCPaymentStaging.Init();

        HSBCPaymentStaging."Document No." := GenJournalLine."Document No.";
        HSBCPaymentStaging."Vendor No." := GenJournalLine."Bal. Account No.";
        HSBCPaymentStaging."Vendor Name" := GenJournalLine.Description;
        HSBCPaymentStaging.Amount := Abs(GenJournalLine."Amount (LCY)");
        HSBCPaymentStaging."Currency Code" := GenJournalLine."Currency Code";
        HSBCPaymentStaging."Beneficiary Account No." := GenJournalLine."Account No.";
        HSBCPaymentStaging."HSBC Payment Type" := GenJournalLine."HSBC Payment Type";


        VendorBankAccount.Reset();
        VendorBankAccount.SetRange("Vendor No.", GenJournalLine."Bal. Account No.");
        if VendorBankAccount.FindFirst() then begin
            HSBCPaymentStaging."Beneficiary Account No." := VendorBankAccount."Bank Account No.";
            HSBCPaymentStaging."Beneficiary Bank Code" := VendorBankAccount."Bank Branch No.";
            HSBCPaymentStaging."Beneficiary Bank Name" := VendorBankAccount.Name;
            HSBCPaymentStaging."SWIFT Code" := VendorBankAccount."SWIFT Code";
            HSBCPaymentStaging."IFSC Code" := VendorBankAccount."IFSC Code";
        end else
            Error('Vendor Bank Account not found. Vendor No. = %1, Bank Code = %2', GenJournalLine."Bal. Account No.", GenJournalLine."Recipient Bank Account");

        if VendorRec.Get(GenJournalLine."Bal. Account No.") then begin
            HSBCPaymentStaging."Vendor Name" := VendorRec.Name;
            HSBCPaymentStaging."Debtor Address 1" := VendorRec.Address;
            HSBCPaymentStaging."Debtor Address 2" := VendorRec."Address 2";
            HSBCPaymentStaging."Country/Region Code" := VendorRec."Country/Region Code";

        end;

        if GenJournalLine."External Document No." <> '' then
            HSBCPaymentStaging."Payment Reference" := GenJournalLine."External Document No."
        else
            HSBCPaymentStaging."Payment Reference" := GenJournalLine."Document No.";

        // HSBCPaymentStaging."End To End ID" := CopyStr('E' + GenJournalLine."Document No.", 1, 50);
        HSBCPaymentStaging."Execution Date" := Format(Today, 0, '<Year4>-<Month,2>-<Day,2>');
        HSBCPaymentStaging."Debtor Name" := BankAccount.Name;
        HSBCPaymentStaging."Debtor Account No." := BankAccount."Bank Account No.";
        HSBCPaymentStaging."Debtor BIC" := BankAccount."HSBC BIC Code";
        HSBCPaymentStaging."Bank Address 1" := BankAccount.Address;
        HSBCPaymentStaging."Bank Address 2" := BankAccount."Address 2";
        HSBCPaymentStaging."SWIFT Code" := BankAccount."SWIFT Code";
        HSBCPaymentStaging."Bank Country/Region Code" := BankAccount."Country/Region Code";
        HSBCPaymentStaging."Payment Type" := 'NURG';
        HSBCPaymentStaging."Charge Bearer" := 'SHAR';
        HSBCPaymentStaging."Payment Status" := HSBCPaymentStaging."Payment Status"::Open;
        HSBCPaymentStaging."Status Reason" := '';
        HSBCPaymentStaging."Payment Send to Bank" := true;

        HSBCPaymentStaging.Insert(true);
    end;



    procedure MoveToHistory()
    var
        HSBCPaymentStaging: Record "HSBC Payment Staging";
        HSBCPaymentStagingHistory: Record "HSBC Payment Staging History";
    begin
        HSBCPaymentStaging.Reset();
        HSBCPaymentStaging.SetRange("Payment Status", HSBCPaymentStaging."Payment Status"::ACCP);

        if HSBCPaymentStaging.FindSet() then
            repeat
                HSBCPaymentStagingHistory.Init();

                HSBCPaymentStagingHistory.TransferFields(HSBCPaymentStaging);

                HSBCPaymentStagingHistory."History Entry No." := GetNextHistoryEntryNo();

                HSBCPaymentStagingHistory.Insert(true);

                HSBCPaymentStaging.Delete(true);

            until HSBCPaymentStaging.Next() = 0;
    end;

    local procedure GetNextHistoryEntryNo(): Integer
    var
        HSBCPaymentStagingHistory: Record "HSBC Payment Staging History";
    begin
        HSBCPaymentStagingHistory.Reset();

        if HSBCPaymentStagingHistory.FindLast() then
            exit(HSBCPaymentStagingHistory."History Entry No." + 1);

        exit(1);
    end;
}