SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- --------------------------------------------------------------------------------------------
create PROCEDURE [dbo].[pdxSetGLDepositAmount]  
  @PK_dxBankReconciliation int = -1
AS
 Declare @GLDepositAmount float;
 -- kdJournalEntry    = 1  
 -- kdCashReceipt     = 2  
 -- kdInvoice         = 3  
 -- kdPayment         = 4  
 -- kdPayableInvoice  = 5  
 -- kdReconciliation  = 6  
 Set @GLDepositAmount = ( Select Coalesce(sum(Amount),0.0) from dxBankReconciliation c, dxAccountTransaction t
                          where c.PK_dxBankReconciliation = @PK_dxBankReconciliation
                            and t.FK_dxAccount = ( select FK_dxAccount__GL from dxBankAccount where PK_dxBankAccount = c.FK_dxBankAccount )                                          
                            and t.KindOfDocument = 2
                            and t.TransactionDate between c.StartDate and c.EndDate ) ;
 BEGIN TRANSACTION
    Update dxBankReconciliation set GLDepositAmount= @GLDepositAmount where PK_dxBankReconciliation = @PK_dxBankReconciliation ;
 COMMIT
GO
