pageextension 50100 CustomerCardExtension extends "Member Card"
{
    layout
    {
        addbefore(Control56)
        {
            part(control149; "Customer Picture")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = field("No.");

            }
        }
        addafter("Credit Limit (LCY)")
        {
            field("Uncleared Cheques"; Rec."Uncleared Cheques")
            {
                ApplicationArea = All;
            }
        }
    }
}
