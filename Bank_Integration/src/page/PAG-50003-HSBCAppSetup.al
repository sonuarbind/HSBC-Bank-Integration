// page 50003 "HSBC App Setup"
// {
//     PageType = Card;
//     ApplicationArea = All;
//     UsageCategory = Administration;
//     SourceTable = "HSBC App Setup";
//     Caption = 'HSBC App Setup';

//     layout
//     {
//         area(Content)
//         {
//             group("ACK1 File")
//             {
//                 Caption = 'ACK1 Import File';

//                 group("Group Header")
//                 {
//                     Caption = 'Group Header';

//                     field("Message ID"; Rec."Ack1 Message ID")
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Message ID';
//                     }

//                     field("Creation Date Time"; Rec."Ack1 Creation Date Time")
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Creation Date Time';
//                     }

//                     field("Organisation BIC/BEI"; Rec."Ack1 Organisation BIC/BEI")
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Organisation BIC/BEI';
//                     }

//                     field("Organisation ID"; Rec."Ack1 Organisation ID")
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Organisation ID';
//                     }
//                 }
//             }
//             group("ACK2 File")
//             {
//                 Caption = 'ACK2 Import File';

//                 group("Group Header 2")
//                 {
//                     Caption = 'Group Header';

//                     field("Ack2 Message ID"; Rec."Ack2 Message ID")
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Message ID';
//                     }

//                     field("Ack2 Creation Date Time"; Rec."Ack2 Creation Date Time")
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Creation Date Time';
//                     }

//                     field("Ack2 Organisation BIC/BEI"; Rec."Ack2 Organisation BIC/BEI")
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Organisation BIC/BEI';
//                     }

//                     field("Ack2 Organisation ID"; Rec."Ack2 Organisation ID")
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Organisation ID';
//                     }
//                 }
//             }
//         }
//     }
//     trigger OnOpenPage()
//     var
//         UserSetup_Rec: Record "User Setup";
//     begin
//         if GuiAllowed then begin
//             UserSetup_Rec.Get(UserId);
//             if not UserSetup_Rec."HSBC Payment Access" then
//                 Error('You do not have permission to access this page.');
//         end;
//     end;
// }