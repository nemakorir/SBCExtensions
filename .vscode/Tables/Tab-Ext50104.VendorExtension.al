tableextension 50105 "Vendor Extension" extends Vendor
{
    fields
    {
        field(5002; "KRA P.I.N"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(73; "Bank code"; code[100])
        {
            DataClassification = ToBeClassified;

        }
        field(5000; "Branch Code"; Code[100])
        {
            DataClassification = ToBeClassified;


        }
        field(5001; "Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5003; "Account No"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5004; "Bank Code No"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Codes List".No;
            
            trigger OnValidate()
            var
                bankcode: record "Bank Codes List";
            begin
                
                if bankcode.Get("Bank Code No") then
                    "Bank code" := bankcode."Bank Code";
                "Branch Code" := bankcode."Branch Code";
                "Branch Name" := bankcode."Branch Name";

            end;
        }
    }
}
