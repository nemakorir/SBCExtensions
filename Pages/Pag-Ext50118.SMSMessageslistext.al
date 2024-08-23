pageextension 50118 "SMS Messages list ext" extends "SMS Messages"
{
    layout
    {
        addafter(Source)
        {
            field("Message Type";Rec."Message Type")
            {
                ApplicationArea=All;
            }
        }
    }
}
