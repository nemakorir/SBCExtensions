/// <summary>
/// TableExtension Customercardextension (ID 50104) extends Record Member Application.
/// </summary>
tableextension 50104 Customercardextension extends "Member Application"
{
    fields
    {
        field(300; "County Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(301; "Customer Category"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Category".Category;
        }
        modify(County)
        {
            TableRelation = "County Codes"."County Code";
            trigger OnAfterValidate()
            var
                countycode: Record "County Codes";
            begin
                if countycode.Get(County) then
                    "County Name" := countycode."County Name";
            end;

        }
        modify("Home County")
        {
            TableRelation = "County Codes"."County Code";
        }

    }

}