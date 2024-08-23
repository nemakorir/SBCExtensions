/// <summary>
/// Codeunit Loan Due Reminder (ID 50108).
/// </summary>
codeunit 50108 "Loan Due Reminder"
{
    trigger OnRun()
    //procedure GetDueLoans()
    var
        LoanRec: Record "Loans";
        DueDate7: Date;
        DueDate3: date;
        DueDateToday: date;
        DueDate3wks: Date;
        DueDate2wks: date;
        DueDate1wk: date;
        DueLoanRec: Record "DueLoans(3days)";
        DueLoanRec2DAYS: Record "DueLoans(2 days)";
        smsmessages: Record "SMS Messages";
        CustomerRec: Record Customer;
        member: Record Customer;
        LastEntryNo: Integer;
        DaysUntilDue7: Integer;
        DaysUntilDue3: Integer;
        DaysUntilDueToday: Integer;
        WeeksUntilDue3: Integer;
        WeeksUntilDue2: Integer;
        WeeksUntilDue1: Integer;
        LoanIDsSentToday: List of [Code[20]];
        ExistingMessage: Record "SMS Messages";
    begin

        //Daily loans Due Reminders for Normal loans
        LoanIDsSentToday.Remove(LoanRec."Loan No.");
        //LOANS DUE IN 7 
        DaysUntilDue7 := 7;//this should be from a setup
        DueDate7 := TODAY + DaysUntilDue7;
        //DaysUntilDue7 := DueDate7 - TODAY;
        LoanRec.SetRange("Next Repayment Date", DueDate7);

        if LoanRec.Findset() then begin
            repeat
                if LoanRec."Loan Product Type" <> 'SPL' then begin
                    //ExistingMessage.Reset();
                    ExistingMessage.SetRange("Account No", LoanRec."Customer No.");
                    ExistingMessage.SetRange("Date Entered", WorkDate());
                    if not ExistingMessage.FindSet() then begin
                        //Entry No
                        LastEntryNo := 0;
                        if smsmessages.FindLast() then
                            LastEntryNo := smsmessages."Entry No";
                        //Send sms

                        if CustomerRec.get(LoanRec."Customer No.") then begin
                            if LoanRec."Outstanding Balance" <> 0 then begin
                                member := CustomerRec;
                                smsmessages.Init();
                                smsmessages."Entry No" := LastEntryNo + 1;
                                smsmessages.Source := smsmessages.Source::"Mobile Banking";
                                smsmessages."Account No" := LoanRec."Customer No.";
                                smsmessages."Telephone No" := member."Mobile Phone No";
                                smsmessages."Date Entered" := WorkDate();
                                smsmessages."Time Entered" := Time;
                                smsmessages."Entered By" := UserId;
                                smsmessages."SMS Message" := 'Dear ' + LoanRec."Member Name" + ', your ' + LoanRec."Loan Product Type Name" + ' loan of KES. ' + Format(LoanRec.Repayment) + ' is due in. ' + Format(DaysUntilDue7) + ' ' + ' days. You can pay via the MPESA Paybill 976950, account number[your ID Number] .For more information call us on 0798667667 or Email:info@springboardcapital.co.ke.If Paid,Kindly Ignore';
                                smsmessages."Sent To Server" := smsmessages."Sent To Server"::No;
                                smsmessages.Insert();
                            end;
                        end;
                    end;
                end;
            until LoanRec.Next = 0;
        end;
        //LOANS DUE IN  3 DAYS
        DueDate3 := TODAY + 3;
        DaysUntilDue3 := DueDate3 - Today;
        LoanRec.SetRange("Next Repayment Date", DueDate3);
        if LoanRec.FindSet() then begin
            repeat
                if LoanRec."Loan Product Type" <> 'SPL' then begin
                    ExistingMessage.SetRange("Account No", LoanRec."Customer No.");
                    ExistingMessage.SetRange("Date Entered", WorkDate());
                    if not ExistingMessage.FindSet() then begin
                        //Entry No
                        LastEntryNo := 0;
                        if smsmessages.FindLast() then
                            LastEntryNo := smsmessages."Entry No";
                        //Send sms
                        if CustomerRec.get(LoanRec."Customer No.") then begin
                            if LoanRec."Outstanding Balance" <> 0 then begin
                                member := CustomerRec;
                                smsmessages.Init();
                                smsmessages."Entry No" := LastEntryNo + 1;
                                smsmessages.Source := smsmessages.Source::"Mobile Banking";
                                smsmessages."Account No" := LoanRec."Customer No.";
                                smsmessages."Telephone No" := member."Mobile Phone No";
                                smsmessages."Date Entered" := WorkDate();
                                smsmessages."Time Entered" := Time;
                                smsmessages."Entered By" := UserId;
                                smsmessages."SMS Message" := 'Dear ' + LoanRec."Member Name" + ', your ' + LoanRec."Loan Product Type Name" + ' loan of KES. ' + Format(LoanRec.Repayment) + ' is due in. ' + Format(DaysUntilDue3) + ' ' + ' days. You can pay via the MPESA Paybill 976950, account number[your ID Number] .For more information call us on 0798667667 or Email:info@springboardcapital.co.ke.If Paid,Kindly Ignore';
                                smsmessages."Sent To Server" := smsmessages."Sent To Server"::No;
                                smsmessages.Insert();
                            end;
                        end;
                    end;
                end;
            until LoanRec.Next = 0;

        end;
        //Loans Due Today
        DueDateToday := TODAY;
        DaysUntilDueToday := DueDateToday - Today;
        LoanRec.SetRange("Next Repayment Date", DueDateToday);
        if LoanRec.FindSet() then begin
            repeat
                if LoanRec."Loan Product Type" <> 'SPL' then begin
                    ExistingMessage.SetRange("Account No", LoanRec."Customer No.");
                    ExistingMessage.SetRange("Date Entered", WorkDate());
                    if not ExistingMessage.FindSet() then begin
                        //Entry No
                        LastEntryNo := 0;
                        if smsmessages.FindLast() then
                            LastEntryNo := smsmessages."Entry No";
                        //Send sms
                        if CustomerRec.get(LoanRec."Customer No.") then begin
                            if LoanRec."Outstanding Balance" <> 0 then begin
                                member := CustomerRec;
                                smsmessages.Init();
                                smsmessages."Entry No" := LastEntryNo + 1;
                                smsmessages.Source := smsmessages.Source::"Mobile Banking";
                                smsmessages."Account No" := LoanRec."Customer No.";
                                smsmessages."Telephone No" := member."Mobile Phone No";
                                smsmessages."Date Entered" := WorkDate();
                                smsmessages."Time Entered" := Time;
                                smsmessages."Entered By" := UserId;
                                smsmessages."SMS Message" := 'Dear ' + LoanRec."Member Name" + ', your ' + LoanRec."Loan Product Type Name" + ' loan of KES. ' + Format(LoanRec.Repayment) + ' is due Today. You can pay via the MPESA Paybill 976950, account number[your ID Number] .For more information call us on 0798667667 of Email:info@springboardcapital.co.ke.If Paid,Kindly Ignore';
                                smsmessages."Sent To Server" := smsmessages."Sent To Server"::No;
                                smsmessages.Insert();
                            end;
                        end;
                    end;
                end;

            until LoanRec.Next = 0;

        end;
        //weekly  Loans Due Reminders for Springhela loans
        // Loans Due in 3 Wweeks
        /* DueDate3wks := TODAY + 21;
         WeeksUntilDue3 := DueDate3wks - Today;
         LoanRec.SetRange("Next Repayment Date", DueDate3wks);
         if LoanRec.FindSet() then begin
             repeat
                 //Entry No
                 LastEntryNo := 0;
                 if smsmessages.FindLast() then
                     LastEntryNo := smsmessages."Entry No";
                 //Send sms
                 if CustomerRec.get(LoanRec."Customer No.") then begin
                     member := CustomerRec;
                     smsmessages.Init();
                     smsmessages."Entry No" := LastEntryNo + 1;
                     smsmessages.Source := smsmessages.Source::"Mobile Banking";
                     smsmessages."Account No" := LoanRec."Customer No.";
                     smsmessages."Telephone No" := member."Mobile Phone No";
                     smsmessages."Date Entered" := WorkDate();
                     smsmessages."Time Entered" := Time;
                     smsmessages."Entered By" := UserId;
                     smsmessages."SMS Message" := 'Dear ' + LoanRec."Member Name" + ', your ' + LoanRec."Loan Product Type Name" + ' loan of KES. ' + Format(LoanRec.Repayment) + ' is due in. ' + Format(DaysUntilDue3) + ' ' + ' days. You can pay via the MPESA Paybill 976950, account number[ID Number] .For more information call us on 0798667667 or Email:info@springboardcapital.co.ke.';
                     smsmessages."Sent To Server" := smsmessages."Sent To Server"::No;
                     smsmessages.Insert();
                 end;
             until LoanRec.Next = 0;

         end;
         //Loans Due in 2 weeks
         DueDate2wks := TODAY + 14;
         WeeksUntilDue2 := DueDate2wks - Today;
         LoanRec.SetRange("Next Repayment Date", DueDate2wks);
         if LoanRec.FindSet() then begin
             repeat
                 //Entry No
                 LastEntryNo := 0;
                 if smsmessages.FindLast() then
                     LastEntryNo := smsmessages."Entry No";
                 //Send sms
                 if CustomerRec.get(LoanRec."Customer No.") then begin
                     member := CustomerRec;
                     smsmessages.Init();
                     smsmessages."Entry No" := LastEntryNo + 1;
                     smsmessages.Source := smsmessages.Source::"Mobile Banking";
                     smsmessages."Account No" := LoanRec."Customer No.";
                     smsmessages."Telephone No" := member."Mobile Phone No";
                     smsmessages."Date Entered" := WorkDate();
                     smsmessages."Time Entered" := Time;
                     smsmessages."Entered By" := UserId;
                     smsmessages."SMS Message" := 'Dear ' + LoanRec."Member Name" + ', your ' + LoanRec."Loan Product Type Name" + ' loan of KES. ' + Format(LoanRec.Repayment) + ' is due in. ' + Format(DaysUntilDue3) + ' ' + ' days. You can pay via the MPESA Paybill 976950, account number[ID Number] .For more information call us on 0798667667 /Email:info@springboardcapital.co.ke.';
                     smsmessages."Sent To Server" := smsmessages."Sent To Server"::No;
                     smsmessages.Insert();
                 end;
             until LoanRec.Next = 0;

         end;*/
        //Loans Due in 1 week for Springhela loans
        DueDate1wk := TODAY + 7;
        WeeksUntilDue1 := DueDate1wk - Today;
        LoanRec.SetRange("Next Repayment Date", DueDate1wk);
        if LoanRec.FindSet() then begin
            repeat
                if LoanRec."Loan Product Type" = 'SPL' then begin
                    ExistingMessage.SetRange("Account No", LoanRec."Customer No.");
                    ExistingMessage.SetRange("Date Entered", WorkDate());
                    if not ExistingMessage.FindSet() then begin
                        //Entry No
                        LastEntryNo := 0;
                        if smsmessages.FindLast() then
                            LastEntryNo := smsmessages."Entry No";
                        //Send sms
                        if CustomerRec.get(LoanRec."Customer No.") then begin
                            if LoanRec."Outstanding Balance" <> 0 then begin
                                member := CustomerRec;
                                smsmessages.Init();
                                smsmessages."Entry No" := LastEntryNo + 1;
                                smsmessages.Source := smsmessages.Source::"Mobile Banking";
                                smsmessages."Account No" := LoanRec."Customer No.";
                                smsmessages."Telephone No" := member."Mobile Phone No";
                                smsmessages."Date Entered" := WorkDate();
                                smsmessages."Time Entered" := Time;
                                smsmessages."Entered By" := UserId;
                                smsmessages."SMS Message" := 'Dear ' + LoanRec."Member Name" + ', your ' + LoanRec."Loan Product Type Name" + ' loan of KES. ' + Format(LoanRec.Repayment) + ' is due in 7 days. You can pay via the MPESA Paybill 976950, account number[your ID Number] .For more information call us on 0798667667 or Email:info@springboardcapital.co.ke.If Paid,Kindly Ignore';
                                smsmessages."Sent To Server" := smsmessages."Sent To Server"::No;
                                smsmessages.Insert();
                            end;
                        end;
                    end;
                end;
            until LoanRec.Next = 0;

        end;
        //Springhela loans due today
        DueDateToday := TODAY;
        DaysUntilDueToday := DueDateToday - Today;
        LoanRec.SetRange("Next Repayment Date", DueDateToday);
        if LoanRec.FindSet() then begin
            repeat
                if LoanRec."Loan Product Type" = 'SPL' then begin
                    ExistingMessage.SetRange("Account No", LoanRec."Customer No.");
                    ExistingMessage.SetRange("Date Entered", WorkDate());
                    if not ExistingMessage.FindSet() then begin
                        //Entry No
                        LastEntryNo := 0;
                        if smsmessages.FindLast() then
                            LastEntryNo := smsmessages."Entry No";
                        //Send sms
                        if CustomerRec.get(LoanRec."Customer No.") then begin
                            if LoanRec."Outstanding Balance" <> 0 then begin
                                member := CustomerRec;
                                smsmessages.Init();
                                smsmessages."Entry No" := LastEntryNo + 1;
                                smsmessages.Source := smsmessages.Source::"Mobile Banking";
                                smsmessages."Account No" := LoanRec."Customer No.";
                                smsmessages."Telephone No" := member."Mobile Phone No";
                                smsmessages."Date Entered" := WorkDate();
                                smsmessages."Time Entered" := Time;
                                smsmessages."Entered By" := UserId;
                                smsmessages."SMS Message" := 'Dear ' + LoanRec."Member Name" + ', your ' + LoanRec."Loan Product Type Name" + ' loan of KES. ' + Format(LoanRec.Repayment) + ' is due Today. You can pay via the MPESA Paybill 976950, account number[your ID Number] .For more information call us on 0798667667 of Email:info@springboardcapital.co.ke.If Paid,Kindly Ignore';
                                smsmessages."Sent To Server" := smsmessages."Sent To Server"::No;
                                smsmessages.Insert();
                            end;
                        end;
                    end;
                end;
            until LoanRec.Next = 0;
        end;

    end;
}
