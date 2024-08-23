/*pageextension 50114 "Purchase Order extension" extends "Purchase Order"
{
    actions
    {
        addafter(Print)
        {
            action("Print Purchase Order")
            {
                Caption = 'LPO';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetFilter("No.", Rec."No.");
                    REPORT.RUN(50120, TRUE, TRUE, Rec);
                    Rec.Reset;
                end;
            }
        }
    }
}*/
