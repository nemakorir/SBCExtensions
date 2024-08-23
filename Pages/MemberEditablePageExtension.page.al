pageextension 50108 "Member Editable Extension" extends "Member Editable Card"
{
    layout
    {
        addafter("Customer Category")
        {
            field("Credit Limit"; Rec."Credit Limit")
            {
                Visible = false;
            }
        }
        modify("Customer Category")
        {
            ShowMandatory = true;
        }
    }
}
