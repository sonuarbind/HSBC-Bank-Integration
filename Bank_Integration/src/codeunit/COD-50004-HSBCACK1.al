codeunit 50004 "HSBC ACK Processor"
{
    procedure ImportACK1()
    var
        FileName: Text;
        InS: InStream;
    begin
        if not UploadIntoStream('Select HSBC ACK 1 File', '', 'XML Files (*.xml)|*.xml', FileName, InS) then
            exit;

        XmlPort.Import(XmlPort::"HSBC pain002 Import", InS);

        Message('ACK File %1 imported successfully.', FileName);
    end;
}





// codeunit 50004 "HSBC ACK Processor"
// {
//     // procedure ImportACK()
//     // var
//     //     FileName: Text;
//     //     InS: InStream;
//     // begin
//     //     UploadIntoStream('Select HSBC ACK File', '', 'XML Files (*.xml)|*.xml', FileName, InS);

//     //     XmlPort.Import(XmlPort::"HSBC pain002 Import", InS);

//     //     Message('ACK Imported Successfully.');
//     // end;


//     procedure ImportACK()
//     var
//         FileName: Text;
//         InS: InStream;
//         UpdateStatus: Codeunit "Update Payment Status";
//     begin
//         UploadIntoStream('Select HSBC ACK File', '', 'XML Files (*.xml)|*.xml', FileName, InS);

//         XmlPort.Import(XmlPort::"HSBC pain002 Import", InS);

//         UpdateStatus.UpdatePaymentStatus();

//         Message('ACK Imported and Status Updated Successfully.');
//     end;

//     procedure UpdateTransactionStatus(
//         MessageID: Code[50];
//         StatusCode: Code[10];
//         Reason: Text[250])
//     var
//         PaymentLine: Record "HSBC Payment Staging";
//     begin
//         PaymentLine.SetRange("Message ID", MessageID);

//         if PaymentLine.FindSet() then
//             repeat

//                 case StatusCode of
//                     'ACCP':
//                         PaymentLine."Payment Status" := PaymentLine."Payment Status"::ACCP;

//                     'ACTC':
//                         PaymentLine."Payment Status" := PaymentLine."Payment Status"::ACTC;

//                     'ACSP':
//                         PaymentLine."Payment Status" := PaymentLine."Payment Status"::ACSP;

//                     'ACSC':
//                         PaymentLine."Payment Status" := PaymentLine."Payment Status"::ACSC;

//                     'RJCT':
//                         PaymentLine."Payment Status" := PaymentLine."Payment Status"::RJCT;
//                 end;

//                 PaymentLine."Status Reason" := Reason;
//                 PaymentLine."ACK Received" := true;
//                 PaymentLine."ACK Date Time" := CurrentDateTime;

//                 PaymentLine.Modify();

//             until PaymentLine.Next() = 0;
//     end;
// }