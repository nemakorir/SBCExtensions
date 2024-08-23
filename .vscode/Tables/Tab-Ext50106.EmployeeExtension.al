/*tableextension 50106 "Employee Extension" extends Employee
{
    fields
    {

        field(30; "Employement Title"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Department"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Department Code"; Text[500])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
            trigger OnValidate()
            begin
                if Dimvalue.Get("Department Code") then
                    Department := Dimvalue.Name;
            end;
        }
        field(63; "Sub Department"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Sub Department Code"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Branch Name"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Id No."; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(67; "KRA PIN"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(68; "NSSF NO."; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "NHIF NO."; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Employee Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","PERMANENT","CONTRACT";
        }
        field(71; "Employee Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","ACTIVE","PROBATION";
        }
        field(72; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","Single","Married","Divorced","Other";
        }
        field(73; "Manager Name"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(74; "Supervisor"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Supervisor No."; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(76; "Bank Code"; Code[500])
        {
            DataClassification = ToBeClassified;
        }
        field(77; "Nationality"; Code[500])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region".Code;
        }
        field(78; "Branch Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".code WHERE("Global Dimension No." = CONST(0),
                                                          Blocked = CONST(false));
            trigger OnValidate()
            var
                DimensionValueRec: Record "Dimension Value";
            begin
                if "Branch Code" <> '' then begin
                    if DimensionValueRec.Get(DimensionValueRec.Code = "Branch Code") then
                        "Branch Name" := DimensionValueRec.Name
                    else
                        "Branch Name" := ''; // Clear the field if no matching record found
                end
                else
                    "Branch Name" := ''; // Clear the field if "Branch Code" is empty

            end;

        }

    }
    var
        Dimvalue: Record "Dimension Value";

    /// <summary>
    /// GetBranchName.
    /// </summary>
    /// <param name="branchCode">Code[100].</param>
    /// <returns>Return value of type Text[500].</returns>
    procedure GetBranchName(branchCode: Code[100]): Text[500]
    var
        DimensionValueRec: Record "Dimension Value";
    begin
        if branchCode = '' then
            exit('');

        if DimensionValueRec.Get(branchCode) then
            exit(DimensionValueRec.Name)
        else
            exit('');
    end;
}
*/