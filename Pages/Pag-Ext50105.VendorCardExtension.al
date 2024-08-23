pageextension 50105 "Vendor Card Extension" extends "Vendor Card"
{
    layout
    {

        addafter(MobilePhoneNo)
        {
            /*  field("KRA P.I.N Code"; Rec."KRA P.I.N")
              {
                  ApplicationArea = All;
              }*/
        }
        addafter("Preferred Bank Account Code")
        {
            field("Bank Code No"; Rec."Bank Code No")
            {
                ApplicationArea = All;
            }
            field("Bank code"; Rec."Bank code")
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
            field("Account No"; Rec."Account No")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        // Add changes to page actions here

    }

    var
        myInt: Integer;
}
