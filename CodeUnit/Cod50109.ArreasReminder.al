/*codeunit 50109 "Arreas Reminder"
{
    trigger OnRun()
    var
        LoanRec: Record "Loans";
        smsmessages: Record "SMS Messages";
        CustomerRec: Record Customer;
        member: Record Customer;
        LastEntryNo: Integer;
    begin
        LoanRec.reset;
        if LoanRec.Findset() then
            repeat
                LastEntryNo := 0;
                if smsmessages.FindLast() then
                    LastEntryNo := smsmessages."Entry No";
                if LoanRec."Total in Arrears" > 0.00 then begin
                    if CustomerRec.Get(LoanRec."Customer No.") then begin
                        smsmessages.Init();
                        smsmessages."Entry No" := LastEntryNo + 1;
                        smsmessages.Source := smsmessages.Source::"Mobile Banking";
                        smsmessages."Account No" := LoanRec."Customer No.";
                        smsmessages."Telephone No" := member."Mobile Phone No";
                        smsmessages."Date Entered" := WorkDate();
                        smsmessages."Time Entered" := Time;
                        smsmessages."Entered By" := UserId;
                        smsmessages."SMS Message" := 'Dear ' + LoanRec."Member Name" + ', you have Loan Arrears of sh. ' + Format(LoanRec."Total in Arrears") + '.' + 'You can pay via the MPESA Paybill 976950, account number[your ID Number] .For more information call us on 0798667667 or Email:info@springboardcapital.co.ke.';
                        smsmessages."Sent To Server" := smsmessages."Sent To Server"::No;
                        smsmessages.Insert();
                    end;

                end;
            until LoanRec.Next = 0;
    end;
}
*/