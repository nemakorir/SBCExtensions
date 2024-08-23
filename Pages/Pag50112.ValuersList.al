/// <summary>
/// Page Valuers List (ID 50112).
/// </summary>
/*page 50112 "Valuers List"
{
    ApplicationArea = All;
    Caption = 'Valuers List';
    PageType = List;
    SourceTable = Valuers;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
            }
        }
    }
}
*/