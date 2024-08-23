
/*xmlport 50100 GenJnlImport
{
    Caption = 'GenJnlImport';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(GenJnlLine; "Gen. Journal Line")
            {
                fieldelement(JournalTemplate; GenJnlLine."Journal Template Name") { }
                fieldelement(JournalBatch; GenJnlLine."Journal Batch Name") { }
                fieldelement(LineNo; GenJnlLine."Line No.") { }
                fieldelement(PostingDate; GenJnlLine."Posting Date") { }
                fieldelement(DocNo; GenJnlLine."Document No.") { }
                fieldelement(AccountType; GenJnlLine."Account Type") { }
                fieldelement(AccountNo; GenJnlLine."Account No.") { FieldValidate = Yes; }
                fieldelement(Description; GenJnlLine.Description) { }
                fieldelement(Amount; GenJnlLine.Amount) { }
                fieldelement(AmountLCY; GenJnlLine."Amount (LCY)") { }
                fieldelement(BalAcctype; GenJnlLine."Bal. Account Type") { }
                fieldelement(BalAccNo; GenJnlLine."Bal. Account No.") { }


            }

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

    procedure SetJournalTemplateBatch(Template: Code[100]; Batch: code[100])
    begin
        JournalTemplate := Template;
        JournalBatch := Batch;
    end;

    var
        JournalTemplate: Code[100];
        JournalBatch: code[100];
        GenJnlLine2: Record "Gen. Journal Line";



}
*/