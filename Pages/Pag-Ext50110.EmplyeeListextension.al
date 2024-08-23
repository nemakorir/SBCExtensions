/*pageextension 50110 "Emplyee List extension" extends "Bank Codes List"
{
    layout
    {
        // Add changes to page layout here

        addafter("Job Title")
        {
            field("Employement Title"; Rec."Employement Title")
            {
                ApplicationArea = All;
            }

            field("Department Code"; Rec."Department Code")
            {
                ApplicationArea = All;
            }
            field(Department; Rec.Department)
            {
                ApplicationArea = All;
            }
            field("Sub Department Code"; Rec."Sub Department Code")
            {
                ApplicationArea = All;
            }
            field("Branch Code"; Rec."Branch Code")
            {
                ApplicationArea = All;
            }
            field("Branch Name"; Rec."Branch Name")
            {
                ApplicationArea = All;
            }
            field("Marital Status"; Rec."Marital Status")
            {
                ApplicationArea = All;
            }
            field("Id No."; Rec."Id No.")
            {
                ApplicationArea = All;
            }
            field("NHIF NO."; Rec."NHIF NO.")
            {
                ApplicationArea = All;
            }
            field("NSSF NO."; Rec."NSSF NO.")
            {
                ApplicationArea = All;
            }
            field("KRA PIN"; Rec."KRA PIN")
            {
                ApplicationArea = All;
            }
            field(Nationality; Rec.Nationality)
            {
                ApplicationArea = All;
            }
            field("Employee Type"; Rec."Employee Type")
            {
                ApplicationArea = All;
            }
            field("Employee Status"; Rec."Employee Status")
            {
                ApplicationArea = All;
            }
            field("Manager Name"; Rec."Manager Name")
            {
                ApplicationArea = All;
            }
            field(Supervisor; Rec.Supervisor)
            {
                ApplicationArea = All;
            }
            field("Supervisor No."; Rec."Supervisor No.")
            {
                ApplicationArea = All;
            }
            field("Bank Account No."; Rec."Bank Account No.")
            {
                ApplicationArea = All;
            }

        }
        addafter("Bank Account No.")
        {
            field("Bank Code"; Rec."Bank Code")
            {

                ApplicationArea = All;
            }
        }

        modify("Job Title")
        {
            Visible = false;
        }



    }

    actions
    {
        // Add changes to page actions here



    }

    var
        myInt: Integer;
}*/
