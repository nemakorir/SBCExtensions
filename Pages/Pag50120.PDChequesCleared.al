page 50120 "PD Cheques Cleared"
{
    ApplicationArea = All;
    Caption = 'PD Cheques Cleared';
    PageType = List;
    SourceTable = "PD Cheques";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approval Status field.';
                }
                field("Bank Cheque"; Rec."Bank Cheque")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Cheque field.';
                }
                field("Banked By"; Rec."Banked By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Banked By field.';
                }
                field("Banking Date"; Rec."Banking Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Banking Date field.';
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque No. field.';
                }
                field("Cheque Status"; Rec."Cheque Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque Status field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Date Received"; Rec."Date Received")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Received field.';
                }
                field("Drawer Name"; Rec."Drawer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Drawer Name field.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Due Date field.';
                }
                field(Hold; Rec.Hold)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Hold field.';
                }
                field("Issuer Bank"; Rec."Issuer Bank")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Issuer Bank field.';
                }
                field("Issuer Bank Branch Code"; Rec."Issuer Bank Branch Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Issuer Bank Branch Code field.';
                }
                field("Issuer Bank Branch Name"; Rec."Issuer Bank Branch Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Issuer Bank Branch Name field.';
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No field.';
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan No. field.';
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maturity Date field.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Reason for Holding"; Rec."Reason for Holding")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reason for Holding field.';
                }
                field("Receiving Bank No."; Rec."Receiving Bank No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receiving Bank No. field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
            }
        }
    }
}
