codeunit 50103 "Sacco Workflow Response"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128]);
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        WorkflowEventHandlingExt: Codeunit "Sacco Workflow Event Handling";
    begin
        case ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandlingExt.RunWorkflowOnSendCustomerRequestForApprovalCode);
                end;

            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandlingExt.RunWorkflowOnSendCustomerRequestForApprovalCode);
                end;

            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandlingExt.RunWorkflowOnCancelCustomerRequestApprovalCode);

                end;

            WorkflowResponseHandling.OpenDocumentCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandlingExt.RunWorkflowOnCancelCustomerRequestApprovalCode);
                end;
            WorkflowResponseHandling.RejectAllApprovalRequestsCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.RejectAllApprovalRequestsCode, WorkflowEventHandlingExt.RunWorkflowOnRejectCustomerRequestApprovalCode);
                end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean);
    var
        CustomerRequest: Record "Customer Request";
    begin
        case RecRef.Number of
            database::"Customer Request":
                begin
                    RecRef.SetTable(CustomerRequest);
                    CustomerRequest.Status := CustomerRequest.Status::Applied;
                    CustomerRequest.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean);
    var
        CustomerRequest: Record "Customer Request";
    begin
        case RecRef.Number of
            database::"Customer Request":
                begin
                    RecRef.SetTable(CustomerRequest);
                    CustomerRequest.Status := CustomerRequest.Status::"Pending Approval";
                    CustomerRequest.Modify();
                    IsHandled := true;
                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean);
    var
        CustomerRequest: Record "Customer Request";
        Member: Record Customer;
        CustomerRecRef: RecordRef;
        SMSMessage: Record "SMS Messages";
        LastEntryNo: Integer;
    begin
        case RecRef.Number of
            database::"Customer Request":
                begin
                    RecRef.SetTable(CustomerRequest);
                    CustomerRequest.Status := CustomerRequest.Status::Approved;
                    CustomerRequest.Modify();
                    if Member.Get(CustomerRequest."Customer No") then begin
                        Member."Credit Limit (LCY)" := CustomerRequest."New  Value";
                        Member.Modify();
                        Handled := true;
                    end;
                    // Handled := true;
                    //Entry No
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
                    SMSMessage."SMS Message" := 'Dear ' + Member.Name + ', your request to change your credit limit to ' + Format(CustomerRequest."New  Value") + ' has been approved';
                    SMSMessage."Sent To Server" := SMSMessage."Sent To Server"::No;
                    SMSMessage.Insert();

                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling Ex", 'OnRejectDocument', '', false, false)]
    local procedure OnRejectDocument(RecRef: RecordRef; var Handled: Boolean);
    var
        CustomerRequest: Record "Customer Request";
        Member: Record Customer;
        CustomerRecRef: RecordRef;
        SMSMessage: Record "SMS Messages";
        LastEntryNo: Integer;
    begin
        case RecRef.Number of
            database::"Customer Request":
                begin
                    RecRef.SetTable(CustomerRequest);
                    CustomerRequest.Status := CustomerRequest.Status::Declined; // Mark the request as rejected
                    CustomerRequest.Modify();
                    if Member.Get(CustomerRequest."Customer No") then begin
                        // You can add any additional logic for handling the rejection here.
                        // For example, sending an SMS notifying the customer about the rejection.
                        Handled := true;
                    end;

                    // Entry No
                    LastEntryNo := 0;
                    if SMSMessage.FindLast() then
                        LastEntryNo := SMSMessage."Entry No";

                    // Send SMS
                    SMSMessage.Init();
                    SMSMessage."Entry No" := LastEntryNo + 1;
                    SMSMessage.Source := SMSMessage.Source::"Mobile Banking";
                    SMSMessage."Telephone No" := Member."Mobile Phone No";
                    SMSMessage."Date Entered" := WorkDate();
                    SMSMessage."Time Entered" := Time;
                    SMSMessage."Entered By" := UserId;
                    SMSMessage."SMS Message" := 'Dear ' + Member.Name + ', your request to change your credit limit to ' + Format(CustomerRequest."New  Value") + ' has been rejected';
                    SMSMessage."Sent To Server" := SMSMessage."Sent To Server"::No;
                    SMSMessage.Insert();
                end;
        end;
    end;


}
