/// <summary>
/// Codeunit Send SMS (ID 50106).
/// </summary>
/*codeunit 50106 "Send SMS"
{
    trigger OnRun()
    var
        smsmessge: Record "SMS Messages";
        member: Record Customer;
        custReq: Record "Customer Request";
    begin
        smsmessge."Account No" := member."Identification Doc. No.";
        smsmessge."SMS Message" := 'Dear' + member.Name + ',' + 'your request to change your credit limit to' +''custReq."New  Value"''+'has been'+custReq.Status;
    end;


}*/
