tableextension 50102 "Member Editable extension" extends "Member Editable"
{
    fields
    {
        field(50100; "Credit Limit"; Decimal)
        {
            Caption = 'Credit Limit';
            DataClassification = ToBeClassified;

        }
    }
    /*trigger OnModify()
    var
        cust: record Customer;
        memberEditable: record "Member Editable";
    begin
        if (memberEditable.Status = memberEditable.status::Approved) then begin
            if cust.get(memberEditable."No.") then begin
                cust."Credit Limit (LCY)" := memberEditable."Credit Limit";
                cust.Modify();
            end;
        end;
    end;*/
}
