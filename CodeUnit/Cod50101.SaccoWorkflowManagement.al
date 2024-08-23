/// <summary>
/// Codeunit Approvals Mgmt. Ext (ID 50101).
/// </summary>
codeunit 50101 "Sacco Workflow Management"
{
    Permissions = TableData "Approval Entry" = imd,
                  TableData "Approval Comment Line" = imd,
                  TableData "Posted Approval Entry" = imd,
                  TableData "Posted Approval Comment Line" = imd,
                  TableData "Overdue Approval Entry" = imd,
                  TableData "Notification Entry" = imd;

    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandlingExt: Codeunit "Sacco Workflow Event Handling";
        NoWorflowEnabledErr: TextConst ENU = 'No approval workflow for this record is enabled';

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance");
    var
        CustomerRequest: Record "Customer Request";


    begin
        case RecRef.Number of
            DATABASE::"Customer Request":
                begin
                    RecRef.SetTable(CustomerRequest);
                    ApprovalEntryArgument."Document No." := CustomerRequest."Request No";
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Customer Request";
                end;

        end;
    end;


    /// <summary>
    /// OnSendCustomerRequestForApproval.
    /// </summary>
    /// <param name="CustomerRequest">VAR Record "Customer Request".</param>
    [IntegrationEvent(false, false)]
    procedure OnSendCustomerRequestForApproval(var CustomerRequest: Record "Customer Request")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnRejectCustomerRequestForApproval(var CustomerRequest: Record "Customer Request")
    begin

    end;
    /// <summary>
    /// OnCancelCustomerRequestApprovalRequest.
    /// </summary>
    /// <param name="CustomerRequest">VAR Record "Customer Request".</param>
    [IntegrationEvent(false, false)]
    procedure OnCancelCustomerRequestApprovalRequest(var CustomerRequest: Record "Customer Request")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnRejectCustomerRequestApprovalRequest(var CustomerRequest: Record "Customer Request")
    begin

    end;

    /// <summary>
    /// CheckCustomerRequestApprovalWorflowEnabled.
    /// </summary>
    /// <param name="CustomerRequest">VAR Record "Customer Request".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure CheckCustomerRequestApprovalWorflowEnabled(var CustomerRequest: Record "Customer Request"): Boolean
    begin
        if not IsCustomerRequestDocApprovalWorkflowEnabled(CustomerRequest) then
            Error(NoWorflowEnabledErr);
        exit(true);
    end;



    procedure IsCustomerRequestDocApprovalWorkflowEnabled(var CustomerRequest: record "Customer Request"): Boolean
    begin
        if CustomerRequest.Status <> CustomerRequest.Status::Applied then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(CustomerRequest, WorkflowEventHandlingExt.RunWorkflowOnSendCustomerRequestForApprovalCode));
    end;

    procedure RejectRecordApprovalRequest(RecordID: RecordID)
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        if not FindOpenApprovalEntryForCurrUser(ApprovalEntry, RecordID) then
            Error(NoReqToRejectErr);

        ApprovalEntry.SetRecFilter;
        RejectApprovalRequests(ApprovalEntry);
    end;

    procedure FindOpenApprovalEntryForCurrUser(var ApprovalEntry: Record "Approval Entry"; RecordID: RecordID): Boolean
    begin
        ApprovalEntry.SetRange("Table ID", RecordID.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", RecordID);
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange("Approver ID", UserId);
        ApprovalEntry.SetRange("Related to Change", false);
        OnFindOpenApprovalEntryForCurrUserOnAfterApprovalEntrySetFilters(ApprovalEntry);

        exit(ApprovalEntry.FindFirst);
    end;

    procedure RejectApprovalRequests(var ApprovalEntry: Record "Approval Entry")
    var
        ApprovalEntryToUpdate: Record "Approval Entry";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeRejectApprovalRequests(ApprovalEntry, IsHandled);
        if IsHandled then
            exit;

        if ApprovalEntry.FindSet() then
            repeat
                ApprovalEntryToUpdate := ApprovalEntry;
                RejectSelectedApprovalRequest(ApprovalEntryToUpdate);
            until ApprovalEntry.Next() = 0;
    end;

    local procedure RejectSelectedApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        custreq: Record "Customer Request";
    begin
        CheckOpenStatus(ApprovalEntry, "Approval Action"::Reject, RejectOnlyOpenRequestsErr);

        if ApprovalEntry."Approver ID" <> UserId then
            CheckUserAsApprovalAdministrator(ApprovalEntry);

        OnRejectApprovalRequest(ApprovalEntry);
        ApprovalEntry.Get(ApprovalEntry."Entry No.");
        ApprovalEntry.Validate(Status, ApprovalEntry.Status::Rejected);
        ApprovalEntry.Modify(true);
        //update customer Request
        /*custreq.Get();
        custreq.Status := custreq.Status::Declined;
        custreq.Modify(true);*/

        OnAfterRejectSelectedApprovalRequest(ApprovalEntry);
    end;

    local procedure CheckOpenStatus(ApprovalEntry: Record "Approval Entry"; ApprovalAction: Enum "Approval Action"; ErrorMessage: Text)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCheckStatus(ApprovalEntry, ApprovalAction, IsHandled);
        if IsHandled then
            exit;

        if ApprovalEntry.Status <> ApprovalEntry.Status::Open then
            Error(ErrorMessage);
    end;

    local procedure CheckUserAsApprovalAdministrator(ApprovalEntry: Record "Approval Entry")
    var
        UserSetup: Record "User Setup";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCheckUserAsApprovalAdministrator(ApprovalEntry, IsHandled);
        if IsHandled then
            exit;

        UserSetup.Get(UserId);
        UserSetup.TestField("Approval Administrator");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckStatus(var ApprovalEntry: Record "Approval Entry"; ApprovalAction: Enum "Approval Action"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRejectSelectedApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnRejectApprovalRequestsForRecordOnBeforeApprovalEntryToUpdateModify(var ApprovalEntry: Record "Approval Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnFindOpenApprovalEntryForCurrUserOnAfterApprovalEntrySetFilters(var ApprovalEntry: Record "Approval Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeRejectApprovalRequests(var ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckUserAsApprovalAdministrator(ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean)
    begin
    end;

    var
        NoReqToRejectErr: Label 'There is no approval request to reject.';
        RejectOnlyOpenRequestsErr: Label 'You can only reject open approval entries.';
}
