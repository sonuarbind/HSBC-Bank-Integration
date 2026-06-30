// table 50003 "HSBC App Setup"
// {
//     Caption = 'HSBC App Setup';
//     DataClassification = CustomerContent;

//     fields
//     {
//         field(1; "Primary Key"; Integer)
//         {
//             Caption = 'Primary Key';
//             AutoIncrement = true;
//         }
//         field(2; "Ack1 Message ID"; Code[50])
//         {
//             Caption = 'Message ID';
//             DataClassification = CustomerContent;
//         }
//         field(3; "Ack1 Creation Date Time"; DateTime)
//         {
//             Caption = 'Creation Date Time';
//             DataClassification = CustomerContent;
//         }
//         field(4; "Ack1 Organisation BIC/BEI"; Code[20])
//         {
//             Caption = 'Organisation BIC/BEI';
//             DataClassification = CustomerContent;
//         }
//         field(5; "Ack1 Organisation ID"; Code[50])
//         {
//             Caption = 'Organisation ID';
//             DataClassification = CustomerContent;
//         }
//         field(6; "Ack2 Message ID"; Code[50])
//         {
//             Caption = 'Message ID';
//             DataClassification = CustomerContent;
//         }
//         field(7; "Ack2 Creation Date Time"; DateTime)
//         {
//             Caption = 'Creation Date Time';
//             DataClassification = CustomerContent;
//         }
//         field(8; "Ack2 Organisation BIC/BEI"; Code[20])
//         {
//             Caption = 'Organisation BIC/BEI';
//             DataClassification = CustomerContent;
//         }
//         field(9; "Ack2 Organisation ID"; Code[50])
//         {
//             Caption = 'Organisation ID';
//             DataClassification = CustomerContent;
//         }
//     }

//     keys
//     {
//         key(PK; "Primary Key")
//         {
//             Clustered = true;
//         }
//     }
// }