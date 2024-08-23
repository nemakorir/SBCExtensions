/// <summary>
/// Codeunit Payoff Springhela (ID 50105).
/// </summary>
codeunit 50105 "Payoff Springhela balance"
{
    trigger OnRun()
    //procedure payoffloan(LoanNo: Code[20])
    begin
        GenJnl.reset;
        GenJnl.setrange("Journal Template Name", 'GENERAL');
        GenJnl.setrange("Journal Batch Name", 'CUSTREQ');
        GenJnl.DeleteAll;
        CustServiceReq.RESET;
        CustServiceReq.SetRange(Status, CustServiceReq.Status::Applied);
        CustServiceReq.SETRANGE("Request Type ", CustServiceReq."Request Type "::"Clear Loan");
        //CustServiceReq.SETRANGE("Loan No", LoanNo);
        IF CustServiceReq.FIND('-') THEN BEGIN
            repeat
                GenJnl.reset;
                GenJnl.setrange("Journal Template Name", 'GENERAL');
                GenJnl.setrange("Journal Batch Name", 'CUSTREQ');
                GenJnl.DeleteAll;
                Loans.reset;
                Loans.setrange("Loan No.", CustServiceReq."Loan No");
                if Loans.find('-') then begin
                    LOANS.CalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Penalty");

                    //principle bal
                    GenJnl.Init;
                    GenJnl."Journal Template Name" := 'GENERAL';
                    GenJnl."Journal Batch Name" := 'CUSTREQ';
                    GenJnl."Line No." := GenJnl."Line No." + 1000;
                    GenJnl."Document No." := CustServiceReq."Loan No";
                    GenJnl."Posting Date" := Today;
                    GenJnl."Account Type" := GenJnl."Account Type"::CUSTOMER;
                    GenJnl."Account No." := CustServiceReq."Customer No";
                    GenJnl.validate(GenJnl."Account No.");
                    GenJnl.Description := CustServiceReq."Request No" + ' ' + 'Loan Payoff';
                    GenJnl.Amount := loans."Outstanding Balance" * -1;
                    GenJnl.Validate(Amount);
                    GenJnl."Loan No" := CustServiceReq."Loan No";
                    GenJnl."Transaction Type" := GenJnl."Transaction Type"::"Loan Repayment";
                    GenJnl.Validate("Shortcut Dimension 1 Code", Loans."Global Dimension 1 Code");
                    GenJnl.Validate("Shortcut Dimension 2 Code", Loans."Global Dimension 2 Code");
                    if GenJnl.Amount <> 0 then
                        GenJnl.insert;

                    //Interest
                    GenJnl.Init;
                    GenJnl."Journal Template Name" := 'GENERAL';
                    GenJnl."Journal Batch Name" := 'CUSTREQ';
                    GenJnl."Line No." := GenJnl."Line No." + 1000;
                    GenJnl."Document No." := CustServiceReq."Loan No";
                    GenJnl."Posting Date" := Today;
                    GenJnl."Account Type" := GenJnl."Account Type"::CUSTOMER;
                    GenJnl."Account No." := CustServiceReq."Customer No";
                    GenJnl.validate(GenJnl."Account No.");
                    GenJnl.Description := CustServiceReq."Request No" + ' ' + 'Loan Payoff';
                    GenJnl.Amount := loans."Outstanding Interest" * -1;
                    GenJnl.Validate(Amount);
                    GenJnl."Loan No" := CustServiceReq."Loan No";
                    GenJnl."Transaction Type" := GenJnl."Transaction Type"::"Interest Paid";
                    GenJnl.Validate("Shortcut Dimension 1 Code", Loans."Global Dimension 1 Code");
                    GenJnl.Validate("Shortcut Dimension 2 Code", Loans."Global Dimension 2 Code");
                    if GenJnl.Amount <> 0 then
                        GenJnl.insert;

                    //Penalty
                    GenJnl.Init;
                    GenJnl."Journal Template Name" := 'GENERAL';
                    GenJnl."Journal Batch Name" := 'CUSTREQ';
                    GenJnl."Line No." := GenJnl."Line No." + 1000;
                    GenJnl."Document No." := CustServiceReq."Loan No";
                    GenJnl."Posting Date" := Today;
                    GenJnl."Account Type" := GenJnl."Account Type"::CUSTOMER;
                    GenJnl."Account No." := CustServiceReq."Customer No";
                    GenJnl.validate(GenJnl."Account No.");
                    GenJnl.Description := CustServiceReq."Request No" + ' ' + 'Loan Payoff';
                    GenJnl.Amount := loans."Outstanding Penalty" * -1;
                    GenJnl.Validate(Amount);
                    GenJnl."Loan No" := CustServiceReq."Loan No";
                    GenJnl."Transaction Type" := GenJnl."Transaction Type"::"Suspended Penalty";
                    GenJnl.Validate("Shortcut Dimension 1 Code", Loans."Global Dimension 1 Code");
                    GenJnl.Validate("Shortcut Dimension 2 Code", Loans."Global Dimension 2 Code");
                    if GenJnl.Amount <> 0 then
                        GenJnl.insert;


                    if cust.get(Loans."Customer No.") then begin
                        GenJnl.Init;
                        GenJnl."Journal Template Name" := 'GENERAL';
                        GenJnl."Journal Batch Name" := 'CUSTREQ';
                        GenJnl."Line No." := GenJnl."Line No." + 1000;
                        GenJnl."Document No." := CustServiceReq."Loan No";
                        GenJnl."Posting Date" := Today;
                        GenJnl."Account Type" := GenJnl."Account Type"::CUSTOMER;
                        GenJnl."Account No." := CustServiceReq."Customer No";
                        GenJnl.validate(GenJnl."Account No.");
                        GenJnl.Description := CustServiceReq."Request No" + ' ' + 'Loan Payoff';
                        GenJnl.Amount := loans."Outstanding Interest" + loans."Outstanding Penalty" + loans."Outstanding Balance";
                        GenJnl.Validate(Amount);

                        GenJnl."Transaction Type" := GenJnl."Transaction Type"::"Repayment Account";
                        GenJnl.Validate("Shortcut Dimension 1 Code", Loans."Global Dimension 1 Code");
                        GenJnl.Validate("Shortcut Dimension 2 Code", Loans."Global Dimension 2 Code");
                        if GenJnl.Amount <> 0 then
                            GenJnl.insert;

                    end;



                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'GENERAL');
                    GenJnl.SETRANGE("Journal Batch Name", 'CUSTREQ');
                    IF GenJnl.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJnl);
                    end;





                    CustServiceReq.Status := CustServiceReq.Status::Approved;
                    CustServiceReq.modify;
                end;


            until CustServiceReq.next = 0;
        end;
    end;

    Var
        CustServiceReq: Record "Customer Request";
        GenJnl: Record "Gen. Journal Line";
        Loans: Record Loans;
        cust: record Customer;
}
