pageextension 50003 OrderProcessorRoleCenter extends "Order Processor Role Center"
{
    actions
    {
        addafter(Action62)
        {
            group(Action64)
            {
                Caption = 'HSBC Bank Integration';
                Image = FiledPosted;

                action("HSBC Bank Integration List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'HSBC Bank Integration List';
                    RunObject = Page "HSBC Bank Integration Menu";
                }
            }
        }
    }
}