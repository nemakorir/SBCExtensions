/// <summary>
/// PageExtension CustomerRequestCardetension (ID 50103) extends Record Customer Request Card.
/// </summary>
pageextension 50103 CustomerRequestCardetension extends "Customer Request Card"
{
    Editable = true;
    PromotedActionCategories = 'New,Process,Report,Approve,Request Approval,Approvals,Navigate';
    layout
    {
        addafter("Loan No")
        {
            field("Old Value"; Rec."Old Value")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("New  Value"; Rec."New  Value")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
        addafter("Customer No")
        {
            field("Customer Name"; Rec."Customer Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Relationship Officer"; Rec."Relationship Officer")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        modify("Request No")
        {
            Editable = false;
        }
        modify("Customer No")
        {
            Editable = false;
        }
        modify("Request Type ")
        {
            Editable = false;
        }
        modify("Request Date")
        {
            Editable = false;
        }
        modify("Loan No")
        {
            Editable = false;
        }
        modify("Cheque No")
        {
            Editable = false;
        }
        modify("Payment Mode")
        {
            Editable = false;
        }
        modify("Effective Date")
        {
            Editable = false;
        }
        modify(Status)
        {
            Editable = false;
        }
        modify(Comments)
        {
            Editable = false;
        }

    }
    actions
    {
        addfirst(Processing)
        {
            group("Request Approval")
            {

                action("Send Approval Request.")
                {
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    Enabled = CanRequestApprovalForFlow and (Rec.Status = Rec.Status::Applied);
                    trigger OnAction()
                    var
                        CustomerRequest: Record "Customer Request";
                    begin
                        rec.TestField(Status, Rec.Status::Applied);

                        CustomerRequest.Reset();
                        //skillneed.SetRange("Code", Rec."No");
                        // TransLines.SetRange(Cu, Rec.Currency);

                        if ApprovalsMgmt.CheckCustomerRequestApprovalWorflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendCustomerRequestForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request.")
                {
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    Enabled = CanCancelApprovalForRecord;
                    trigger OnAction()
                    var
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        rec.TestField(Status, Rec.Status::"Pending Approval");
                        ApprovalsMgmt.OnCancelCustomerRequestApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
                action("Approval Entries")
                {
                    Image = Approvals;
                    RunPageMode = View;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category5;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                        ;
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);
                        CurrPage.Close();
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";

                    begin
                        /*if (Rec.Status = Rec.Status::Applied) then begin
                            Rec.Status := Rec.Status::Declined;
                            Rec.Modify();
                        end;*/
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
                        CurrPage.Close();
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID);
                        CurrPage.Close();

                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
                /* action(Reopen)
                 {
                     ApplicationArea = Suite;
                     Caption = 'Reopen';
                     Image = ReOpen;
                     Promoted = true;
                     PromotedCategory = Category6;
                     Visible = (Rec.Status = Rec.Status::Approved);

                     trigger OnAction();
                     begin
                         if (Rec.Status = Rec.Status::Approved) then begin
                             if not Confirm('This will reopen document. Continue?', false) then
                                 exit;
                             Rec.Status := Rec.Status::Applied;
                             Rec.Modify();
                         end;

                     end;
                 }*/
            }
        }
    }
    Local Procedure DrilldownApprovalEntries()
    Var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Document No.", Rec."Request No");
        if ApprovalEntry.FindSet() then begin
            PAGE.RunModal(PAGE::"Approval Entries", ApprovalEntry);
            CurrPage.Update(false);
        end;
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        SetControlAppearance;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        // if Rec.Posted then
        //  Error('You cannot delete the details of the payment voucher at this stage');
    end;

    trigger OnModifyRecord(): Boolean
    begin

    end;



    /* trigger OnNextRecord(Steps: Integer): Integer
     begin
     end;*/

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
    end;

    trigger OnAfterGetRecord()
    begin
    end;

    var
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        ApprovalsMgmt: Codeunit "Sacco Workflow Management";
        DocumentIsPosted: Boolean;
        DocumentIsReleased: Boolean;
        SkipConfirmationDialogOnClosing: Boolean;
        OpenPostedTrainingCost: Label 'The Training cost transaction is posted as number %1 and moved to the Posted Training cost window.\\Do you want to open the posted Training Cost?', Comment = '%1 = posted document number';
        [InDataSet]
        StatusStyleTxt: Text;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        EditPage: Boolean;
        CanRejectApprovalForFlow: Boolean;
        CanRejectApprovalForRecord: Boolean;

    /*local procedure ShowPostedConfirmationMessage(PreAssignedNo: Code[20])
    var
        InstructionMgt: Codeunit "Instruction Mgt.";
       CustomerRequest: Record "Customer Request";
    begin
        CustomerRequest.SetCurrentKey("No");
        Trainingcost.SetRange(Posted, true);
        if Trainingcost.FindFirst() then
            if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedTrainingCost, Trainingcost."No"),
                 InstructionMgt.ShowPostedConfirmationMessageCode)
            then
                PAGE.Run(PAGE::"Training Cost", Trainingcost);
    end;*/

    local procedure SetControlAppearance()
    var
        ApprovalsMgmtExt: Codeunit "Sacco Workflow Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        EditPage := false;
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        if Rec.Status = Rec.Status::Applied then
            EditPage := true;
    end;

}
