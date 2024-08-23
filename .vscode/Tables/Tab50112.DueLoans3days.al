/*table 50112 "DueLoans(3days)"
{
    Caption = 'DueLoans(3days)';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan No."; Code[100])
        {
            Caption = 'Loan No.';
        }
        field(2; "Customer No."; Code[100])
        {
            Caption = 'Customer No.';
        }
        field(3; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
        }
        field(4; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
    }
    keys
    {
        key(PK; "Loan No.")
        {
            Clustered = true;
        }
    }
}
*/