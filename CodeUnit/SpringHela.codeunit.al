codeunit 50104 "SpringHela2"
{

    trigger OnRun()
    begin
        message(format(eligibility('000000060', 'SPL')));
        message(format(categoryLimit('000000060')));
    end;

    procedure lastsmsno() Entryno: Integer
    var
        sms: Record "SMS Messages";
    begin
        sms.SetCurrentKey(sms."Entry No");
        sms.Ascending(true);
        if sms.FindLast() then
            exit(sms."Entry No");

    end;



    procedure eligibility(custno: Code[20]; LoanId: Code[20]) elig: Decimal
    var
        colla: Record "Collateral Register";

        loantype: Record "Product Types";
        repayment: Decimal;
        cat: record "Customer Category";
        emp: Record Customer;
    begin
        emp.Get(custno);

        if loantype.Get(LoanId) = false then
            Error('Product not found');

        /* loan.reset();
         loan.setrange("Customer No.", custno);
         loan.SetRange("Loan Product Type", LoanId);
         loan.SetFilter("Outstanding Balance", '>0');
         if loan.FindFirst() then
             error('You have an existing ' + loantype."Product Name" + ' . Kindly contact customer care');*/

        member.reset();
        member.SetRange("No.", custno);
        if Member.FindFirst() = false then
            ERROR('Customer Not found');
        if member."Member Status" <> Member."Member Status"::Active then
            ERROR('Sorry Your Account is not Active, kindly contact Customer Care');

        // checkarrears(custno);//check arrears
        case member."Customer Category" of
            'STAFF', 'SHAREHOLDERS', 'CHECKOFF':
                begin
                    cat.Reset();
                    cat.SetRange(cat.Category, Member."Customer Category");
                    if cat.FindFirst() then
                        if Member."Credit Limit (LCY)" = 0 then
                            elig := cat."Loan Limit";
                    if Member."Credit Limit (LCY)" <> 0 then
                        elig := Member."Credit Limit (LCY)";


                    exit(elig);
                end;

            'ORDINARY CUSTOMERS':
                begin
                    /* colla.Reset();
                     colla.SetRange("Customer No.", custno);
                     if colla.FindFirst() = false then
                         error('We could not find any collateral in your account, kindly contact Customer care');*/

                    loan.reset();
                    loan.SetRange("Customer No.", custno);
                    loan.SetFilter("Outstanding Balance", '>0');
                    if loan.FindFirst() then
                        repeat
                            repayment += loan.Repayment;
                        until loan.Next() = 0;

                    loan.reset();
                    loan.SetRange("Customer No.", custno);
                    loan.SetFilter(Loan."Loan Product Type", LoanId);
                    loan.SetFilter("Outstanding Balance", '>0');
                    case loan.Count() of
                        6, 7, 8:
                            begin
                                elig := round(0.75 * repayment, 10, '>');
                                if elig < 10000 then
                                    elig := 10000;
                            end;
                        3, 4, 5:
                            begin
                                elig := round(0.5 * repayment, 10, '>');
                                if elig < 10000 then
                                    elig := 10000;
                            end;
                        0, 1, 2:
                            begin
                                elig := round(0.25 * repayment, 10, '>');
                                if elig < 10000 then
                                    elig := 10000;
                            end;
                        else begin
                            elig := round(repayment, 10, '>');
                            if elig < 10000 then
                                elig := 10000;
                        end;
                    end;

                    if member."Credit Limit (LCY)" <> 0 then
                        elig := Member."Credit Limit (LCY)";

                    // if elig > loantype."Maximum Loan Amount" then
                    //     exit(loantype."Maximum Loan Amount")
                    // else
                    exit(elig);
                end;

        end;

        // //Error('emp ' + Member."e");
        // emp.Reset();
        // emp.SetRange("Customer Type", emp."Customer Type"::Employer);
        // emp.SetRange("No.", member."Employer code");
        // if emp.FindFirst() then begin
        //     elig := emp.Employer_Limit;

        //     if member."Credit Limit (LCY)" <> 0 then
        //         elig := Member."Credit Limit (LCY)";
        //     exit(elig);
        // end;



    end;

    /*procedure checkarrears(custno: code[20])
    var
    begin
        loan.reset();
        loan.setrange("Customer No.", member."No.");
        loan.SetFilter("Total In Arrears", '>0');
        loan.SetFilter("Outstanding Balance", '>0');
        if loan.FindFirst() then
            error('Some of your loans are in arrears. Kindly contact customer care');
    end;*/

    /* procedure postloan(Loanno: code[20])
     var
         loan: Record Loans;

     //batch: Record batche;

     begin
         if loan.Get(Loanno) = false then
             error('Loan does not exist');

         if loan.Posted then
             exit;

         post.PostMobile(Loanno);

     end;*/

    // procedure PostMobile(LoanNo: code[20])
    // var
    //     LoanMob: Record Loans;
    //     CashManagement: Codeunit "CashManagement SACCO";
    //     GenSetup: Record "General Setup";
    //     PostSuccessfull: Boolean;
    //     ProdFac: Record "Product Types";
    //     PCharges: Record "Loan Product Charge"
    // begin

    // END;
    procedure categoryLimit(custno: Code[20]) elig: Decimal
    var


        loantype: Record "Product Types";

        cat: record "Customer Category";
        emp: Record Customer;
    begin
        emp.Get(custno);
        case emp."Customer Category" of
            'STAFF':
                begin
                    cat.Reset();
                    cat.SetRange(cat.Category, emp."Customer Category");
                    if cat.FindFirst() then
                        elig := cat."Loan Limit";
                    exit(elig);
                end;
            'SHAREHOLDERS', 'CHECKOFF':
                begin
                    cat.Reset();
                    cat.SetRange(cat.Category, emp."Customer Category");
                    if cat.FindFirst() then
                        elig := cat."Loan Limit";

                    if emp."Credit Limit (LCY)" <> 0 then
                        elig := emp."Credit Limit (LCY)";

                    exit(elig);
                end;
            'ORDINARY CUSTOMERS':
                begin
                    cat.Reset();
                    cat.SetRange(cat.Category, emp."Customer Category");
                    if cat.FindFirst() then
                        if emp."Credit Amount (LCY)" <> 0 then
                            elig := emp."Credit Limit (LCY)"
                        else
                            elig := cat."Loan Limit";

                    exit(elig);
                end;

        end
    end;

    procedure generateSchedule(LoanNo: Code[20]) amt: Decimal
    var
        LoansR: Record Loans;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        RSchedule: Record "Loan Repayment Schedule";
    begin
        //Delete schedule
        RSchedule.Reset;
        RSchedule.SetRange(RSchedule."Loan No.", LoanNo);
        RSchedule.DeleteAll;

        QCounter := 0;
        QCounter := 3;

        LoansR.Reset;
        LoansR.SetRange(LoansR."Loan No.", LoanNo);
        LoansR.SetFilter("Repayment Start Date", '<>%1', 0D);
        if LoansR.Find('-') then begin

            /*LoansR.TESTFIELD("Disbursement Date");
            LoansR.TESTFIELD("Repayment Start Date");*/

            if LoansR."Disbursement Date" <> 0D then
                //LoansR.VALIDATE("Disbursement Date" , TODAY);

            LoanAmount := LoansR."Approved Amount";
            InterestRate := LoansR.Interest;
            RepayPeriod := LoansR.Installments;
            InitialInstal := LoansR.Installments;
            LBalance := LoansR."Approved Amount";
            RunDate := LoansR."Repayment Start Date";

            InstalNo := 0;

            repeat
                InstalNo := InstalNo + 1;

                //kma
                if LoansR."Interest Calculation Method" = LoansR."Interest Calculation Method"::Amortised then begin
                    LoansR.TestField(Interest);
                    LoansR.TestField(Installments);
                    TotalMRepay := Round((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                    LInterest := Round(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                    LPrincipal := TotalMRepay - LInterest;
                end;

                if LoansR."Interest Calculation Method" = LoansR."Interest Calculation Method"::"Straight Line" then begin
                    LoansR.TestField(Interest);
                    LoansR.TestField(Installments);
                    LPrincipal := LoanAmount / RepayPeriod;
                    LInterest := (InterestRate / 12 / 100) * LoanAmount;
                end;

                if (LoansR."Interest Calculation Method" in [LoansR."Interest Calculation Method"::"Reducing Balance",
                                                             LoansR."Interest Calculation Method"::Constants]) then begin
                    LoansR.TestField(Interest);
                    LoansR.TestField(Installments);
                    LPrincipal := LoanAmount / RepayPeriod;
                    LInterest := (InterestRate / 12 / 100) * LBalance;
                end;

                //Grace Period
                if GrPrinciple > 0 then begin
                    LPrincipal := 0
                end else begin
                    //IF "Instalment Period" <> InPeriod THEN
                    LBalance := LBalance - LPrincipal;
                end;

                if GrInterest > 0 then
                    LInterest := 0;

                GrPrinciple := GrPrinciple - 1;
                GrInterest := GrInterest - 1;

                Evaluate(RepayCode, Format(InstalNo));

                RSchedule.Init;
                RSchedule."Repayment Code" := RepayCode;
                RSchedule."Loan No." := LoansR."Loan No.";
                RSchedule."Loan Amount" := LoanAmount;
                RSchedule."Instalment No" := InstalNo;
                RSchedule."Repayment Date" := RunDate;
                RSchedule."Member No." := LoansR."Customer No.";
                RSchedule."Loan Category" := LoansR."Loan Product Type";
                RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                RSchedule."Monthly Interest" := LInterest;
                RSchedule."Principal Repayment" := LPrincipal;
                RSchedule.Insert;

                //Repayment Frequency
                if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::Daily then
                    RunDate := CalcDate('1D', RunDate)
                else
                    if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::Weekly then
                        RunDate := CalcDate('1W', RunDate)
                    else
                        if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::Monthly then
                            RunDate := CalcDate('1M', RunDate)
                        else
                            if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::Quarterly then
                                RunDate := CalcDate('1Q', RunDate)
                            else
                                if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::"Bi-Annual" then
                                    RunDate := CalcDate('6M', RunDate)
                                else
                                    if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::Yearly then
                                        RunDate := CalcDate('1Y', RunDate);

            until LBalance < 1

        end;

    end;

    var
        myInt: Integer;
        Member: Record Customer;
        mydate: Date;
        NotRun: Boolean;
        Rundate: date;
        DormancyMessage: text[251];
        SendSMS: Codeunit SendSMS;
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book",Dormancy;
        post: Codeunit "Credit Management";
        Loan: Record Loans;
}
