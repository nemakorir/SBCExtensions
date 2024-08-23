pageextension 50104 "Member ApplicationCard extensi" extends "Member Application Card"
{
    layout
    {
        addafter("Type of Customer")
        {
            field("Customer Category"; Rec."Customer Category")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
        }
        modify("Branch Code")
        {
            ShowMandatory = true;
        }

        modify("Identification Doc. No.")
        {
            ShowMandatory = true;
        }
        modify("Global Dimension 1 Code")
        {
            ShowMandatory = true;
        }
        modify("Global Dimension 2 Code")
        {
            ShowMandatory = true;

        }
        modify("Relationship Officer Name")
        {
            ShowMandatory = true;
        }
        modify("Posting Group")
        {
            ShowMandatory = true;
        }

        modify(Name)
        {
            ShowMandatory = true;
        }
        modify("Loan Amount")
        {
            ShowMandatory = true;
        }
        modify("Mobile Phone No")
        {
            ShowMandatory = true;
        }
        modify("E-Mail")
        {
            ShowMandatory = true;
        }
        modify(Gender)
        {
            ShowMandatory = true;


        }
        modify("Customer Sector")
        {
            ShowMandatory = true;
        }
        modify("KRA PIN")
        {
            ShowMandatory = true;
            Caption = 'KRA PIN';
        }
        modify("Source Of Customer")
        {
            ShowMandatory = true;
        }
    }
    /* trigger OnClosePage()
     begin
         Rec.TestField(Gender);
     end;*/
}
