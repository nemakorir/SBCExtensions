pageextension 50102 "GenrCustomer card Extension" extends "Customer Card"
{

    layout
    {

        addafter("Balance Due (LCY)")
        {
            field("Customer Category"; Rec."Customer Category") { }
        }
    }

}
