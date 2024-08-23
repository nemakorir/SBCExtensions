/// <summary>
/// TableExtension Member Editable Extension (ID 50107) extends Record Customer Request.
/// </summary>
tableextension 50107 "Customer Request Extension" extends "Customer Request"
{
    fields
    {
        field(11; "Old Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "New  Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Relationship Officer"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        modify("Customer No")
        {

            trigger OnAfterValidate()
            var
                CustomerRec: Record Customer;
                custreg: Record "Customer Request";
            begin
                if CustomerRec.get("Customer No") then
                    "Customer Name" := CustomerRec.Name;
                "Relationship Officer" := CustomerRec."Relationship Officer Name";
            end;

        }
        modify(Status)
        {
            trigger OnAfterValidate()
            var
                Member: Record Customer;
                custrequest: Record "Customer Request";
                SMSMessage: Record "SMS Messages";
                LastEntryNo: Integer;
            begin
                if Member.get("Customer No") then begin
                    if custrequest.Status = custrequest.Status::Declined then begin
                        LastEntryNo := 0;
                        if SMSMessage.FindLast() then
                            LastEntryNo := SMSMessage."Entry No";
                        //Send sms
                        SMSMessage.Init();
                        SMSMessage."Entry No" := LastEntryNo + 1;
                        SMSMessage.Source := SMSMessage.Source::"Mobile Banking";
                        SMSMessage."Telephone No" := Member."Mobile Phone No";
                        SMSMessage."Date Entered" := WorkDate();
                        SMSMessage."Time Entered" := Time;
                        SMSMessage."Entered By" := UserId;
                        SMSMessage."SMS Message" := 'Dear ' + Member.Name + ', your request to change your credit limit to ' + Format(custrequest."New  Value") + ' has been declined';
                        SMSMessage."Sent To Server" := SMSMessage."Sent To Server"::No;
                        SMSMessage.Insert();
                    end;
                end;
            end;
        }

    }
    trigger OnModify()
    var
        Member: Record Customer;
        custrequest: Record "Customer Request";
        SMSMessage: Record "SMS Messages";
        LastEntryNo: Integer;
    begin
        if Member.get("Customer No") then begin
            if custrequest.Status = custrequest.Status::Declined then begin
                LastEntryNo := 0;
                if SMSMessage.FindLast() then
                    LastEntryNo := SMSMessage."Entry No";
                //Send sms
                SMSMessage.Init();
                SMSMessage."Entry No" := LastEntryNo + 1;
                SMSMessage.Source := SMSMessage.Source::"Mobile Banking";
                SMSMessage."Telephone No" := Member."Mobile Phone No";
                SMSMessage."Date Entered" := WorkDate();
                SMSMessage."Time Entered" := Time;
                SMSMessage."Entered By" := UserId;
                SMSMessage."SMS Message" := 'Dear ' + Member.Name + ', your request to change your credit limit to ' + Format(custrequest."New  Value") + ' has been declined';
                SMSMessage."Sent To Server" := SMSMessage."Sent To Server"::No;
                SMSMessage.Insert();
            end;
        end;
    end;
}
