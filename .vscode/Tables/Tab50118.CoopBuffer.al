/*table 50118 "Coop Buffer"
{
    Caption = 'Coop Buffer';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; No; Text[200])
        {
            Caption = 'No';
        }
        field(2; AccNo; Text[200])
        {
            Caption = 'AccNo';
        }
        field(3; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(4; BookedBalance; Decimal)
        {
            Caption = 'BookedBalance';
        }
        field(5; ClearedBalance; Decimal)
        {
            Caption = 'ClearedBalance';
        }
        field(6; Currency; Text[200])
        {
            Caption = 'Currency';
        }
        field(7; CustMemoLine1; Text[200])
        {
            Caption = 'CustMemoLine1';
        }
        field(8; EventType; Text[200])
        {
            Caption = 'EventType';
        }
        field(9; ExchangeRate; Decimal)
        {
            Caption = 'ExchangeRate';
        }
        field(10; Narration; Text[200])
        {
            Caption = 'Narration';
        }
        field(11; Narration2; Text[200])
        {
            Caption = 'Narration2';
        }
        field(12; Narration3; Text[200])
        {
            Caption = 'Narration3';
        }
        field(13; PaymentRef; Text[200])
        {
            Caption = 'PaymentRef';
        }
        field(14; TransactionDate; DateTime)
        {
            Caption = 'TransactionDate';
        }
        field(15; TransactionId; Text[200])
        {
            Caption = 'TransactionId';
        }
        field(16; "ID No."; Text[200])
        {
            Caption = 'ID No.';
        }
        field(17; "Cheque No."; Text[200])
        {
            Caption = 'Cheque No.';
        }
        field(18; "Customer No"; Text[200])
        {
            Caption = 'Customer No';
        }
        field(19; "Customer Name"; Text[200])
        {
            Caption = 'Customer Name';
        }
        field(20; Reconciled; Boolean)
        {
            Caption = 'Reconciled';
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
}
*/