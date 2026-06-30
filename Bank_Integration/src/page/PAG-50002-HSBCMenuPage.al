page 50002 "HSBC Bank Integration Menu"
{
    Caption = 'HSBC Bank Integration';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group("HSBC")
            {
                Caption = 'HSBC Bank Integration';

                group(HSBC1)
                {
                    ShowCaption = false;

                    grid(HSBCGrid)
                    {
                        GridLayout = Columns;

                        group(HSBC2)
                        {
                            Caption = 'HSBC Payment Staging';

                            grid(HSBCGrid2)
                            {
                                GridLayout = Columns;

                                group(HSBC3)
                                {
                                    ShowCaption = false;

                                    field(HSBCPaymentStaging; HSBCPaymentStaging)
                                    {
                                        ShowCaption = false;
                                        Editable = false;

                                        trigger OnDrillDown()
                                        begin
                                            Page.Run(Page::"HSBC Payment Staging");
                                        end;
                                    }
                                }
                            }
                        }
                        group(HSBCHistory)
                        {
                            Caption = 'HSBC Payment Staging History';

                            grid(HSBCH1)
                            {
                                GridLayout = Columns;

                                group("HSBCH12")
                                {
                                    ShowCaption = false;

                                    field(HSBCPaymentStagingHistory; HSBCPaymentStagingHistory)
                                    {
                                        ShowCaption = false;
                                        Editable = false;

                                        trigger OnDrillDown()
                                        begin
                                            Page.Run(Page::"HSBC Payment Staging History");
                                        end;
                                    }
                                    field(HSBCPaymentLog; HSBCPaymentLog)
                                    {
                                        ShowCaption = false;
                                        Editable = false;
                                        trigger OnDrillDown()
                                        begin
                                            Page.Run(Page::"HSBC Payment Log Page");
                                        end;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    var
        HSBCPaymentStaging: Label 'HSBC Payment Staging';
        HSBCPaymentStagingHistory: Label 'HSBC Payment Staging History';
        HSBCPaymentLog: Label 'HSBC Payment Log Page';
}
