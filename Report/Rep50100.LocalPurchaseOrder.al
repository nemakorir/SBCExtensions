/*report 50120 "Local Purchase Order"
{
    ApplicationArea = basic, suite;
    Caption = 'Local Purchase Order';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Local Purchase Order.rdl';
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(CompanyAddress; CompanyInformation.Address)
            {
            }
            column(CompanyCity; CompanyInformation.City)
            {
            }
            column(CompanyPhone; CompanyInformation."Phone No.")
            {
            }
            column(CompanyPicture; CompanyInformation.Picture)
            {
            }
            column(ComapnyEmail; CompanyInformation."E-Mail")
            {
            }
            column(CompanyHomePage; CompanyInformation."Home Page")
            {
            }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
            column(Document_Type; "Document Type") { }
            column(No_; "No.") { }
            column(Pay_to_Vendor_No_; "Pay-to Vendor No.") { }
            column(Pay_to_Name; "Pay-to Name") { }
            column(Pay_to_Name_2; "Pay-to Name 2") { }
            column(Pay_to_Address; "Pay-to Address") { }
            column(Pay_to_Address_2; "Pay-to Address 2") { }
            column(Pay_to_City; "Pay-to City") { }
            column(Pay_to_Contact; "Pay-to Contact") { }
            column(Pay_to_Contact_No_; "Pay-to Contact No.") { }
            column(Your_Reference; "Your Reference") { }
            column(Ship_to_Code; "Ship-to Code") { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Name_2; "Ship-to Name 2") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Address_2; "Ship-to Address 2") { }
            column(Ship_to_City; "Ship-to City") { }
            column(Ship_to_Contact; "Ship-to Contact") { }
            column(Order_Date; "Order Date") { }
            column(Posting_Date; "Posting Date") { }
            column(Expected_Receipt_Date; "Expected Receipt Date") { }
            column(Posting_Description; "Posting Description") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Due_Date; "Due Date") { }
            column(Payment_Discount__; "Payment Discount %") { }
            column(Pmt__Discount_Date; "Pmt. Discount Date") { }
            column(Shipment_Method_Code; "Shipment Method Code") { }
            column(Location_Code; "Location Code") { }
            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code") { }
            column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code") { }
            column(Amount; Amount) { }
            column(Amount_Including_VAT; "Amount Including VAT") { }

            dataitem("Purchase Line"; "Purchase Line")
            {
                dataitemLink = "Document No." = Field("No.");
                column(Document_No_; "Document No.") { }
                column(Type; Type) { }
                column(No; "No.") { }
                column(Description; Description) { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(Quantity; Quantity) { }
                column(Outstanding_Quantity; "Outstanding Quantity") { }
                column(Quantity_Invoiced; "Quantity Invoiced") { }
                column(Direct_Unit_Cost; "Direct Unit Cost") { }
                column(Quantity_Received; "Quantity Received") { }
                column(Unit_Cost; "Unit Cost") { }
                column(VAT__; "VAT %") { }
                column(Line_Discount__; "Line Discount %") { }
                column(Line_Discount_Amount; "Line Discount Amount") { }
                column(Line_Amount; "Line Amount") { }
                //  column(Amount; Amount) { }
                //column(Amount_Including_VAT; "Amount Including VAT") { }
                column(Unit_Price__LCY_; "Unit Price (LCY)") { }
                column(Gross_Weight; "Gross Weight") { }
                column(Net_Weight; "Net Weight") { }
                column(Unit_Volume; "Unit Volume") { }
                column(Units_per_Parcel; "Units per Parcel") { }
                column(Appl__to_Item_Entry; "Appl.-to Item Entry") { }
                column(Indirect_Cost__; "Indirect Cost %") { }
                column(Recalculate_Invoice_Disc_; "Recalculate Invoice Disc.") { }
                column(Outstanding_Amount; "Outstanding Amount") { }
                column(Outstanding_Amount__LCY_; "Outstanding Amount (LCY)") { }
                column(Qty__Rcd__Not_Invoiced; "Qty. Rcd. Not Invoiced") { }
                column(Amt__Rcd__Not_Invoiced; "Amt. Rcd. Not Invoiced") { }
                column(Receipt_No_; "Receipt No.") { }
                column(Order_No_; "Order No.") { }
                column(Profit__; "Profit %") { }
                column(Inv__Disc__Amount_to_Invoice; "Inv. Disc. Amount to Invoice") { }
                column(Vendor_Item_No_; "Vendor Item No.") { }
                column(Sales_Order_No_; "Sales Order No.") { }
                column(Total; Total) { }
                column(TotalEXCLVAT; TotalEXCLVAT) { }

                trigger OnAfterGetRecord()
                var
                    PurchaseLineRec: Record "Purchase Line";
                    TotalAmountTemp: Decimal;
                begin
                    TotalEXCLVAT := Quantity * "Direct Unit Cost";
                    Total := Quantity * "Unit Price (LCY)";
                end;
            }


            trigger OnAfterGetRecord()
            begin

                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(Picture);
                CName := CompanyInformation.Name;
                CEmail := CompanyInformation."E-Mail";
                CAddress := CompanyInformation.Address;
                //CAddress2 := CompanyInformation."Address 2";
                Cpage := CompanyInformation."Home Page";
                Cphone := CompanyInformation."Phone No.";

                ApprovalEntry.RESET;
                ApprovalEntry.SETRANGE("Document Type", ApprovalEntry."Document Type"::"Purchase Order");
                ApprovalEntry.SETRANGE("Document No.", "Purchase Header"."No.");
                ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FINDFIRST then begin
                    SenderID := ApprovalEntry."Sender ID";
                    DateTimeSend := FORMAT(ApprovalEntry."Date-Time Sent for Approval");
                    if UserSetup.GET(SenderID) then begin
                        //UserSetup.CALCFIELDS("Approver Signature");
                    end;
                end;
                ApprovalEntry.RESET;
                ApprovalEntry.SETRANGE("Document Type", ApprovalEntry."Document Type"::"Purchase Order");
                ApprovalEntry.SETRANGE("Document No.", "Purchase Header"."No.");
                ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
                ApprovalEntry.SETRANGE("Sequence No.", 1);
                if ApprovalEntry.FINDSET then begin
                    //IF ApprovalEntry."Sequence No."=1 THEN
                    // BEGIN
                    FirstApproverID := DELSTR(ApprovalEntry."Approver ID", 1, 8);
                    DateTimeFirstApprove := FORMAT(ApprovalEntry."Last Date-Time Modified");
                    if UserSetup1.GET(FirstApproverID) then begin
                        //UserSetup1.CALCFIELDS("Approver Signature");
                    end;
                end;
                ApprovalEntry.RESET;
                ApprovalEntry.SETRANGE("Document Type", ApprovalEntry."Document Type"::"Purchase Order");
                ApprovalEntry.SETRANGE("Document No.", "Purchase Header"."No.");
                ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
                ApprovalEntry.SETRANGE("Sequence No.", 2);
                if ApprovalEntry.FINDSET then begin
                    SecondApproverID := DELSTR(ApprovalEntry."Approver ID", 1, 8);
                    DateTimeSecondApprove := FORMAT(ApprovalEntry."Last Date-Time Modified");
                    if UserSetup2.GET(SecondApproverID) then begin
                        //UserSetup2.CALCFIELDS("Approver Signature");
                    end;
                end;

                ApprovalEntry.RESET;
                ApprovalEntry.SETRANGE("Document Type", ApprovalEntry."Document Type"::"Purchase Order");
                ApprovalEntry.SETRANGE("Document No.", "Purchase Header"."No.");
                ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
                ApprovalEntry.SETRANGE("Sequence No.", 3);
                if ApprovalEntry.FINDSET then
                    ApprovalEntry.RESET;
                ApprovalEntry.SETRANGE("Document Type", ApprovalEntry."Document Type"::"Purchase Order");
                ApprovalEntry.SETRANGE("Document No.", "Purchase Header"."No.");
                ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
                ApprovalEntry.SETRANGE("Sequence No.", 4);
                if ApprovalEntry.FINDSET then begin
                    FourthApproverID := DELSTR(ApprovalEntry."Approver ID", 1, 8);
                    DateTimeFourthApprove := FORMAT(ApprovalEntry."Last Date-Time Modified");
                    if UserSetup4.GET(FourthApproverID) then begin
                        //UserSetup4.CALCFIELDS("Approver Signature");
                    end;
                end;


                ApprovalEntry.RESET;
                ApprovalEntry.SETRANGE("Document Type", ApprovalEntry."Document Type"::"Purchase Order");
                ApprovalEntry.SETRANGE("Document No.", "Purchase Header"."No.");
                ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
                ApprovalEntry.SETRANGE("Sequence No.", 5);
                if ApprovalEntry.FINDSET then begin
                    FifthApproverID := DELSTR(ApprovalEntry."Approver ID", 1, 8);
                    DateTimeFifthApprove := FORMAT(ApprovalEntry."Last Date-Time Modified");
                    if UserSetup5.GET(FifthApproverID) then begin
                        //UserSetup5.CALCFIELDS("Approver Signature");
                    end;
                end;


            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        Total: Decimal;
        TotalEXCLVAT: Decimal;
        TotalAmount: Decimal;
        CompanyInformation: Record "Company Information";
        UserSetup: Record "User Setup";
        ApprovalEntry: Record "Approval Entry";
        SenderID: Code[80];
        DateTimeSend: Text;
        SenderSignature: Variant;
        FirstApproverID: Code[80];
        DateTimeFirstApprove: Text;
        FirstApproveSignature: Variant;
        SecondApproverID: Code[80];
        DateTimeSecondApprove: Text;
        SecondApproveSignature: Variant;
        ThirdApproverID: Code[80];
        DateTimeThirdApprove: Text;
        ThirdApproveSignature: Variant;
        FourthApproverID: Code[80];
        DateTimeFourthApprove: Text;
        FourthApproveSignature: Variant;
        FifthApproverID: Code[80];
        DateTimeFifthApprove: Text;
        FifthApproveSignature: Variant;
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        UserSetup4: Record "User Setup";
        UserSetup5: Record "User Setup";
        UserSetup6: Record "User Setup";
        RepCheck: Report Check;
        NoText: array[2] of Text;
        AmountInWords: Text;
        RoundedAmount: Decimal;
        GrossAmount: Decimal;
        CName: Text[80];
        CEmail: Text[80];
        CAddress: Text[80];
        CAddress2: Text[80];
        Cpage: Text[80];
        Cphone: Text;
        Name: Label 'East African School of Aviation';
        Email: Label 'info@easa.or.ke';
        BAdd: Label 'P.O BOX 31063';
        PAdd: Label '"  North Airport Road,Embakasi"';
        HPage: Label 'www.easa.ac.ke';
        Easaphone: Label '827470';
        PaymentLine: Record "Purchase Line";
}
*/