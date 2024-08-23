/// <summary>
/// PageExtension Customer Request Extension (ID 50101) extends Record Customer Request List.
/// </summary>
pageextension 50101 "Customer Request Extension" extends "Customer Request List"
{

    layout
    {
        addafter("Loan No")
        {
            field("Old Value"; Rec."Old Value")
            {
                ApplicationArea = All;
            }
            field("New  Value"; Rec."New  Value")
            {
                ApplicationArea = All;
            }
        }
        addafter("Customer No")
        {
            field("Customer Name"; Rec."Customer Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Relationship Officer"; Rec."Relationship Officer")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
}
