tableextension 50101 "GenrCustomer Extension" extends Customer
{
    fields
    {
        modify("Branch Code")
        {
            TableRelation = "Dimension Value".code WHERE("Global Dimension No." = CONST(0),
                                                          Blocked = CONST(false));
            trigger OnAfterValidate()
            var
                dimvalue: Record "Dimension Value";
            begin
                if dimvalue.Get("Branch Code") then begin
                    "Branch Name" := dimvalue.Name;
                end;
            end;
        }
        modify("Relationship Officer")
        {
            TableRelation = Employee."No.";
            trigger OnAfterValidate()
            begin
                if emp.Get("Relationship Officer") then begin
                    "Relationship Officer Name" := emp."First Name" + emp."Last Name";
                end;
            end;
        }
    }
    var
        emp: Record Employee;
}
