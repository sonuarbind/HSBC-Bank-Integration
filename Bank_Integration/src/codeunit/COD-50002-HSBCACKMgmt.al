codeunit 50002 "Update Payment Status"
{
    procedure UpdatePaymentStatus()
    var
        AckLog: Record "HSBC ACK Log";
        PaymentStaging: Record "HSBC Payment Staging";
    begin
        if not AckLog.FindLast() then
            exit;

        PaymentStaging.SetRange("Message ID", AckLog."Original Message ID");

        if PaymentStaging.FindSet() then
            repeat

                case AckLog.Status of

                    'ACTC':
                        PaymentStaging."Payment Status" := PaymentStaging."Payment Status"::ACTC;

                    'ACCP':
                        PaymentStaging."Payment Status" := PaymentStaging."Payment Status"::ACCP;

                    'ACSP':
                        PaymentStaging."Payment Status" := PaymentStaging."Payment Status"::ACSP;

                    'ACSC':
                        PaymentStaging."Payment Status" := PaymentStaging."Payment Status"::ACSC;

                    'RJCT':
                        PaymentStaging."Payment Status" := PaymentStaging."Payment Status"::RJCT;

                    'PDNG':
                        PaymentStaging."Payment Status" := PaymentStaging."Payment Status"::PDNG;
                end;

                PaymentStaging."ACK Received" := true;
                PaymentStaging."ACK Date Time" := CurrentDateTime;
                PaymentStaging."Status Reason" := AckLog."Status Reason";

                PaymentStaging.Modify();

            until PaymentStaging.Next() = 0;
    end;
}