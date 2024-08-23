/*pageextension 50116 "Gen Journal line extension" extends "General Journal"
{
    actions
    {
        addafter("Opening Balance")
        {
            action("Payroll Journals")
            {
                Promoted = true;
                PromotedCategory = category10;
                ApplicationArea = ALL;

                trigger OnAction();
                var
                    WebApiClient: Codeunit WebApiClient;
                begin
                    // Xmlport.Run(71706575, false, false);
                    //RunXmlportImport();
                    WebApiClient.RequestPayrollJournalLines();
                end;
            }
        }
    }
    /* procedure RunXmlportImport()
     var
         FileInStream: InStream;
         FileName: Text;
         GenJnlIpmport: XmlPort GenJnlImport;
         GenJnlLine: Record "Gen. Journal Line";
     begin

         UploadIntoStream('', '', '', FileName, FileInStream);
         GenJnlIpmport.SetJournalTemplateBatch(Rec."Journal Template Name", Rec."Journal Batch Name");
         GenJnlIpmport.SetSource(FileInStream);
         GenJnlIpmport.Import();
         Message('File imported successfuly.');
     end;

}
*/