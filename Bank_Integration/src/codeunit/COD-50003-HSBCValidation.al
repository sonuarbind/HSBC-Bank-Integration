codeunit 50003 "HSBC Validation"
{
    procedure ValidateBatch(BatchNo: Code[20])
    var
        PaymentLine: Record "HSBC Payment Staging";
    begin
        PaymentLine.SetRange("Batch No.", BatchNo);

        if PaymentLine.FindSet() then
            repeat
                ValidateLine(PaymentLine);
            until PaymentLine.Next() = 0;

        Message('Batch validation completed.');
    end;

    procedure ValidateLine(var PaymentLine: Record "HSBC Payment Staging")
    begin
        PaymentLine.TestField("Vendor Name");
        PaymentLine.TestField("Beneficiary Account No.");
        PaymentLine.TestField("Beneficiary Bank Code");
        PaymentLine.TestField(Amount);

        if PaymentLine.Amount <= 0 then
            Error('Amount must be greater than zero.');
    end;

    procedure GeneratePaymentXML(BatchNo: Code[20])
    begin
        Message('XML generation logic will call XMLPort 50100.');
    end;
}