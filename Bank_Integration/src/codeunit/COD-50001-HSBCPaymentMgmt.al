codeunit 50001 "HSBC Payment Mgmt"
{
    procedure GeneratePaymentFile(var SelectedPayments: Record "HSBC Payment Staging")
    var
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        FileName: Text;

        PaymentRec: Record "HSBC Payment Staging";
        GLSetup: Record "General Ledger Setup";
        NoSeries: Codeunit "No. Series";

        PaymentFileNo: Code[30];
        LineNo: Integer;

        HSBCLogEntriesCU: Codeunit "HSBC Log Entries";
    begin
        GLSetup.Get();
        GLSetup.TestField("HSBC Payment File Nos.");

        PaymentFileNo := NoSeries.GetNextNo(GLSetup."HSBC Payment File Nos.", Today);

        LineNo := 1;

        // Update only selected records
        if SelectedPayments.FindSet(true) then
            repeat

                SelectedPayments.TestField("Payment Push Bank", false);

                SelectedPayments."Payment File No." := PaymentFileNo;
                SelectedPayments."Message ID" := PaymentFileNo;

                SelectedPayments."Instruction ID" := CopyStr('I' + Format(LineNo) + PaymentFileNo, 1, MaxStrLen(SelectedPayments."Instruction ID"));

                SelectedPayments."End To End ID" := CopyStr('E' + Format(LineNo) + PaymentFileNo, 1, MaxStrLen(SelectedPayments."End To End ID"));

                SelectedPayments.Modify(true);

                LineNo += 1;

            until SelectedPayments.Next() = 0;

        Commit();

        PaymentRec."Message ID" := PaymentFileNo;
        FileName := PaymentFileNo + '.xml';

        TempBlob.CreateOutStream(OutStr);

        // Export only selected records
        PaymentRec.Reset();
        PaymentRec.SetRange("Payment File No.", PaymentFileNo);

        XmlPort.Export(XmlPort::"HSBC pain001 Export", OutStr, PaymentRec);

        TempBlob.CreateInStream(InStr);

        DownloadFromStream(InStr, '', '', '', FileName);

        // Mark only exported records
        PaymentRec.Reset();
        PaymentRec.SetRange("Payment File No.", PaymentFileNo);

        if PaymentRec.FindSet() then
            repeat

                PaymentRec."Payment Push Bank" := true;
                PaymentRec."Export Date Time" := CurrentDateTime;

                PaymentRec.Validate("Payment Status", PaymentRec."Payment Status"::Exported);

                PaymentRec.Modify(true);

                // Create Export Log
                HSBCLogEntriesCU.InsertHSBCLog(PaymentRec, Enum::"HSBC Log Type"::Export, '', '');
            until PaymentRec.Next() = 0;

        Message('HSBC Payment XML generated successfully. File No. %1', PaymentFileNo);
    end;
}
