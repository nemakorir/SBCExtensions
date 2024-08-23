/// <summary>
/// PageExtension Collateral Register card ext (ID 50113) extends Record Collateral Register Card.
/// </summary>
pageextension 50115 "Collateral Register card ext" extends "Collateral Register Card"
{
    layout
    {
        modify("Collateral Name")
        {
            ShowMandatory = true;
        }
        modify("Valuation Date")
        {
            ShowMandatory = true;
        }
        modify("Collateral Value")
        {
            ShowMandatory = true;
        }
        modify("Forced Sale Value")
        {
            ShowMandatory = true;
        }
        modify("Discounted Value")
        {
            ShowMandatory = true;
        }
        modify("Discounting %")
        {
            ShowMandatory = true;
        }
        modify("Collateral Perfected")
        {
            ShowMandatory = true;
        }
        modify("Next Valuation Date")
        {
            ShowMandatory = true;
        }
        modify("Valuation By")
        {
            ShowMandatory = true;
        }
        modify("Valuation Expiry Date")
        {
            ShowMandatory = true;
        }
        //vehicle
        modify(Make)
        {
            ShowMandatory = true;
        }
        modify(Model)
        {
            ShowMandatory = true;
        }
        modify("Number Plate")
        {
            ShowMandatory = true;
        }
        modify(Year)
        {
            ShowMandatory = true;
        }
        modify("Chasis Number")
        {
            ShowMandatory = true;
        }
        modify("Engine Number")
        {
            ShowMandatory = true;
        }
        modify(Colour)
        {
            ShowMandatory = true;
        }
        modify("Vehicle Type")
        {
            ShowMandatory = true;
        }
        modify("Fuel Type")
        {
            ShowMandatory = true;
        }
        modify("Manufacture Year")
        {
            ShowMandatory = true;
        }
        modify("Date of Registration")
        {
            ShowMandatory = true;
        }
        modify("Tracking Expiry Date")
        {
            ShowMandatory = true;
        }
    }

}
