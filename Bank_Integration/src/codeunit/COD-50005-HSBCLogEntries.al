codeunit 50005 "HSBC Log Entries"
{
    procedure InsertHSBCLog(
        Staging: Record "HSBC Payment Staging";
        LogType: Enum "HSBC Log Type";
        ReasonCode: Code[20];
        AdditionalInfo: Text[250])
    var
        HSBCPaymentLog: Record "HSBC Payment Log";
        LogDateTime: DateTime;
    begin
        LogDateTime := CurrentDateTime();

        HSBCPaymentLog.Init();

        //========================================================
        // General Information
        //========================================================
        HSBCPaymentLog."Staging Entry No." := Staging."Entry No.";
        HSBCPaymentLog."Document No." := Staging."Document No.";
        HSBCPaymentLog."Vendor No." := Staging."Vendor No.";
        HSBCPaymentLog."Vendor Name" := Staging."Vendor Name";

        HSBCPaymentLog.Amount := Staging.Amount;
        HSBCPaymentLog."Currency Code" := Staging."Currency Code";

        HSBCPaymentLog."Beneficiary Account No." := Staging."Beneficiary Account No.";
        HSBCPaymentLog."Beneficiary Bank Code" := Staging."Beneficiary Bank Code";

        HSBCPaymentLog."Message ID" := Staging."Message ID";
        HSBCPaymentLog."Instruction ID" := Staging."Instruction ID";
        HSBCPaymentLog."End To End ID" := Staging."End To End ID";

        HSBCPaymentLog."Execution Date" := Staging."Execution Date";

        HSBCPaymentLog."Payment Status" := Staging."Payment Status";
        HSBCPaymentLog."Status Reason" := Staging."Status Reason";

        HSBCPaymentLog."Payment Send to Bank" := Staging."Payment Send to Bank";
        HSBCPaymentLog."Payment Push Bank" := Staging."Payment Push Bank";
        HSBCPaymentLog."ACK1 File Imported" := Staging."ACK1 File Imported";
        HSBCPaymentLog."Payment Received At Bank" := Staging."Payment Received At Bank";

        HSBCPaymentLog."Export Date Time" := Staging."Export Date Time";
        HSBCPaymentLog."ACK Date Time" := Staging."ACK Date Time";

        HSBCPaymentLog."Log Type" := LogType;

        //========================================================
        // ACK Information
        //========================================================
        HSBCPaymentLog."Ack1 Message ID" := Staging."Ack1 Message ID";
        HSBCPaymentLog."Ack1 Creation Date Time" := Staging."Ack1 Creation Date Time";
        HSBCPaymentLog."Ack1 Organisation ID" := Staging."Ack1 Organisation ID";
        HSBCPaymentLog."Ack1 Organisation BIC/BEI" := Staging."Ack1 Organisation BIC/BEI";

        HSBCPaymentLog."Ack2 Message ID" := Staging."Ack2 Message ID";
        HSBCPaymentLog."Ack2 Creation Date Time" := Staging."Ack2 Creation Date Time";
        HSBCPaymentLog."Ack2 Organisation ID" := Staging."Ack2 Organisation ID";
        HSBCPaymentLog."Ack2 Organisation BIC/BEI" := Staging."Ack2 Organisation BIC/BEI";

        //========================================================
        // UETR
        //========================================================
        HSBCPaymentLog."UETR No." := Staging."UETR No.";

        //========================================================
        // Reason Details
        //========================================================
        HSBCPaymentLog."Reason Code" := ReasonCode;
        HSBCPaymentLog."Additional Information" := AdditionalInfo;

        //========================================================
        // Audit Information
        //========================================================
        HSBCPaymentLog."Source File" := Staging."File Name";
        HSBCPaymentLog."Imported By" := UserId();
        HSBCPaymentLog."Imported Date Time" := LogDateTime;
        HSBCPaymentLog."Log Date Time" := LogDateTime;

        HSBCPaymentLog.Insert(true);
    end;
}


// codeunit 50006 "HSBC Log Entries"
// {
//     procedure InsertHSBCLog(Staging: Record "HSBC Payment Staging"; LogType: Enum "HSBC Log Type"; ReasonCode: Code[20]; AdditionalInfo: Text[250])
//     var
//         HSBCPaymentLog: Record "HSBC Payment Log";
//     begin
//         HSBCPaymentLog.Init();

//         // General Information
//         HSBCPaymentLog."Staging Entry No." := Staging."Entry No.";
//         HSBCPaymentLog."Document No." := Staging."Document No.";
//         HSBCPaymentLog."Vendor No." := Staging."Vendor No.";
//         HSBCPaymentLog."Vendor Name" := Staging."Vendor Name";
//         HSBCPaymentLog.Amount := Staging.Amount;
//         HSBCPaymentLog."Currency Code" := Staging."Currency Code";
//         HSBCPaymentLog."Currency Code" := Staging."Currency Code";
//         HSBCPaymentLog."Beneficiary Account No." := Staging."Beneficiary Account No.";
//         HSBCPaymentLog."Beneficiary Bank Code" := Staging."Beneficiary Bank Code";
//         HSBCPaymentLog."Message ID" := Staging."Message ID";
//         HSBCPaymentLog."End To End ID" := Staging."End To End ID";
//         HSBCPaymentLog."Instruction ID" := Staging."Instruction ID";
//         HSBCPaymentLog."Execution Date" := Staging."Execution Date";
//         HSBCPaymentLog."Payment Status" := Staging."Payment Status";
//         HSBCPaymentLog."Status Reason" := Staging."Status Reason";
//         HSBCPaymentLog."Payment Send to Bank" := Staging."Payment Send to Bank";
//         HSBCPaymentLog."Payment Push Bank" := Staging."Payment Push Bank";
//         HSBCPaymentLog."ACK1 File Imported" := Staging."ACK1 File Imported";
//         HSBCPaymentLog."Payment Received At Bank" := Staging."Payment Received At Bank";
//         HSBCPaymentLog."Export Date Time" := Staging."Export Date Time";
//         HSBCPaymentLog."Log Type" := LogType;


//         HSBCPaymentLog."ACK Date Time" := Staging."ACK Date Time";

//         case LogType of
//             Enum::"HSBC Log Type"::ACK1:
//                 begin

//                     HSBCPaymentLog."Ack1 Message ID" := Staging."Ack1 Message ID";
//                     HSBCPaymentLog."Ack1 Creation Date Time" := Staging."Ack1 Creation Date Time";
//                     HSBCPaymentLog."Ack1 Organisation ID" := Staging."Ack1 Organisation ID";
//                     HSBCPaymentLog."Ack1 Organisation BIC/BEI" := Staging."Ack1 Organisation BIC/BEI";
//                 end;

//             Enum::"HSBC Log Type"::ACK2:
//                 begin
//                     HSBCPaymentLog."Ack2 Message ID" := Staging."Ack2 Message ID";
//                     HSBCPaymentLog."Ack2 Creation Date Time" := Staging."Ack2 Creation Date Time";
//                     HSBCPaymentLog."Ack2 Organisation ID" := Staging."Ack2 Organisation ID";
//                     HSBCPaymentLog."Ack2 Organisation BIC/BEI" := Staging."Ack2 Organisation BIC/BEI";

//                     HSBCPaymentLog."Ack1 Message ID" := Staging."Ack1 Message ID";
//                     HSBCPaymentLog."Ack1 Creation Date Time" := Staging."Ack1 Creation Date Time";
//                     HSBCPaymentLog."Ack1 Organisation ID" := Staging."Ack1 Organisation ID";
//                     HSBCPaymentLog."Ack1 Organisation BIC/BEI" := Staging."Ack1 Organisation BIC/BEI";
//                 end;
//         end;

//         HSBCPaymentLog."UETR No." := Staging."UETR No.";
//         HSBCPaymentLog."Log Date Time" := CurrentDateTime();
//         HSBCPaymentLog."Reason Code" := ReasonCode;
//         HSBCPaymentLog."Additional Information" := AdditionalInfo;

//         HSBCPaymentLog."Imported By" := UserId();
//         HSBCPaymentLog."Imported Date Time" := CurrentDateTime();
//         HSBCPaymentLog."Source File" := Staging."File Name";

//         HSBCPaymentLog.Insert(true);
//     end;
// }