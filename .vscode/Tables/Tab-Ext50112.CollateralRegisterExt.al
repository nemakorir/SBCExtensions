tableextension 50112 "Collateral Register Ext" extends "Collateral Register"
{
    fields
    {
        field(50001; "Valuer No"; Integer)
        {
            DataClassification = ToBeClassified;
            // TableRelation = Valuers.No;

        }

        modify("Valuation By")
        {
            TableRelation = Vendor."No.";
        }

    }
    /*trigger OnInsert()
    begin
        "Collateral Perfected" := true;
    end;
    trigger OnModify()
    begin
        "Collateral Perfected":=true;
    end;*/
}
