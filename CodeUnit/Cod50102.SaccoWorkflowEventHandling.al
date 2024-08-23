/// <summary>
/// Codeunit Workflow Event Handling Ext (ID 50102).
/// </summary>
codeunit 50102 "Sacco Workflow Event Handling"
{
    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        SendCustomerRequestForApprovalEventDescTxt: TextConst ENU = 'Approval for an CustomerRequest is requested';
        CancelApprovalForCustomerRequestEventDescTxt: TextConst ENU = 'Approval for an CustomerRequest is cancelled';
        RejectApprovalForCustomerRequestEventDescTxt: TextConst ENU = 'Approval for an CustomerRequest is rejectted';



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventsToLibrary();
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendCustomerRequestForApprovalCode(), Database::"Customer Request", SendCustomerRequestForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelCustomerRequestApprovalCode(), Database::"Customer Request", CancelApprovalForCustomerRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectCustomerRequestApprovalCode(), Database::"Customer Request", RejectApprovalForCustomerRequestEventDescTxt, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128]);
    begin
        case EventFunctionName of
            RunWorkflowOnCancelCustomerRequestApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelCustomerRequestApprovalCode, RunWorkflowOnSendCustomerRequestForApprovalCode);
                
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendCustomerRequestForApprovalCode);

                end;

            WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode:
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnRejectCustomerRequestForApprovalCode);

                end;

            WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode:
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendCustomerRequestForApprovalCode);


                end;
        end;
    end;


    procedure RunWorkflowOnSendCustomerRequestForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendCustomerRequestForApproval'));
    end;


    procedure RunWorkflowOnRejectCustomerRequestForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectCustomerRequestForApproval'));
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sacco Workflow Management", 'OnSendCustomerRequestForApproval', '', true, true)]
    local procedure RunWorkflowOnSendCustomerRequestForApproval(var CustomerRequest: Record "Customer Request");
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendCustomerRequestForApprovalCode(), CustomerRequest);
    end;
    /// <summary>
    /// RunWorkflowOnCancelCustomerRequestApprovalCode.
    /// </summary>
    /// <returns>Return value of type Code[128].</returns>
    procedure RunWorkflowOnCancelCustomerRequestApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelCustomerRequestApprovalRequest'));
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sacco Workflow Management", 'OnCancelCustomerRequestApprovalRequest', '', true, true)]
    local procedure RunWorkflowOnCancelCustomerRequestApprovalRequest(var CustomerRequest: Record "Customer Request");
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelCustomerRequestApprovalCode(), CustomerRequest);
    end;

    procedure RunWorkflowOnRejectCustomerRequestApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectCustomerRequestApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sacco Workflow Management", 'OnRejectCustomerRequestApprovalRequest', '', true, true)]
    local procedure RunWorkflowOnRejectCustomerRequestApprovalRequest(var CustomerRequest: Record "Customer Request");
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnRejectCustomerRequestApprovalCode(), CustomerRequest);
    end;
}
