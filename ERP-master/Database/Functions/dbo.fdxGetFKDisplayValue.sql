SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- --------------------------------------------------------------------------------------------
CREATE  function [dbo].[fdxGetFKDisplayValue] ( @FK int , @TableName  varchar(100)  )
returns varchar(500)
as
begin
   Declare @SQL varchar(1000)
   Declare @R varchar(500)

   set @R = [dbo].[fcxGetFKDisplayValue] ( @FK , @TableName )

   if @R = ''
   begin

     set @TableName = UPPER(@TableName)

          if @TableName  = 'DXACCOUNT'              Set @R = ( Select ID+', ' +Coalesce(Description,'') From dxAccount  WITH (NOLOCK) Where PK_dxAccount = @FK  )
     else if @TableName  = 'DXACCOUNTCATEGORY'      Set @R = ( Select Coalesce(Description,'') From dxAccountCategory  WITH (NOLOCK) Where PK_dxAccountCategory = @FK  )
     else if @TableName  = 'DXACCOUNTCONFIGURATION' Set @R = ( Select ID+'    ' +Coalesce(Description,'') From dxAccountConfiguration  WITH (NOLOCK) Where PK_dxAccountConfiguration = @FK  )
     else if @TableName  = 'DXACCOUNTEXPENSE'       Set @R = ( Select ID From dxAccountExpense  WITH (NOLOCK) Where PK_dxAccountExpense = @FK  )
     else if @TableName  = 'DXACCOUNTINGYEAR'       Set @R = ( Select ID+', ' +Coalesce(Description,'') From dxAccountingYear  WITH (NOLOCK) Where PK_dxAccountingYear = @FK  )
     else if @TableName  = 'DXACCOUNTREVENUE'       Set @R = ( Select ID From dxAccountRevenue  WITH (NOLOCK) Where PK_dxAccountRevenue = @FK  )
     else if @TableName  = 'DXACCOUNTTRANSACTION'   Set @R = ( Select Coalesce(Description,'') From dxAccountTransaction  WITH (NOLOCK) Where PK_dxAccountTransaction = @FK  )
     else if @TableName  = 'DXACCOUNTTYPE'          Set @R = ( Select Coalesce(Description,'') From dxAccountType  WITH (NOLOCK) Where PK_dxAccountType = @FK  )
     else if @TableName  = 'DXACCOUNTUSAGE'         Set @R = ( Select Coalesce(Description,'') From dxAccountUsage  WITH (NOLOCK) Where PK_dxAccountUsage = @FK  )
     else if @TableName  = 'DXACTION'               Set @R = ( Select  Convert(varchar(50), @FK)  From dxAction  WITH (NOLOCK) Where PK_dxAction = @FK  )
     else if @TableName  = 'DXACTIVITY'             Set @R = ( Select ID+', ' +Coalesce(Description,'') From dxActivity  WITH (NOLOCK) Where PK_dxActivity = @FK  )
     else if @TableName  = 'DXADDRESS'              Set @R = ( Select ID+', ' +Coalesce(CompanyName,'')+', '+ Coalesce(Address1,'')  From dxAddress  WITH (NOLOCK) Where PK_dxAddress = @FK  )
     else if @TableName  = 'DXADDRESSTYPE'          Set @R = ( Select ID From dxAddressType  WITH (NOLOCK) Where PK_dxAddressType = @FK  )
     else if @TableName  = 'DXAPPLICATIONEVENT'     Set @R = ( Select ID+'    ' +Coalesce(Description,'') From dxApplicationEvent  WITH (NOLOCK) Where PK_dxApplicationEvent = @FK  )
     else if @TableName  = 'DXASSEMBLY'             Set @R = ( Select ID+'    ' From dxAssembly  WITH (NOLOCK) Where PK_dxAssembly = @FK  )
     else if @TableName  = 'DXASSEMBLYDETAIL'       Set @R = ( Select Convert(varchar(50), @FK)  From dxAssemblyDetail  WITH (NOLOCK) Where PK_dxAssemblyDetail = @FK  )
     else if @TableName  = 'DXBANK'                 Set @R = ( Select Coalesce(Name,'') From dxBank  WITH (NOLOCK) Where PK_dxBank = @FK  )
     else if @TableName  = 'DXBANKACCOUNT'          Set @R = ( Select Coalesce(AccountNumber,'') From dxBankAccount  WITH (NOLOCK) Where PK_dxBankAccount = @FK  )
     else if @TableName  = 'DXBANKRECONCILIATION'   Set @R =  ( Select ID+'    ' From dxBankReconciliation  WITH (NOLOCK) Where PK_dxBankReconciliation = @FK  )
     else if @TableName  = 'DXBANKRECONCILIATIONDETAIL' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxBankReconciliationDetail  WITH (NOLOCK) Where PK_dxBankReconciliationDetail = @FK  )
     else if @TableName  = 'DXCASHRECEIPT'          Set @R = ( Select ID From dxCashReceipt  WITH (NOLOCK) Where PK_dxCashReceipt = @FK  )
     else if @TableName  = 'DXCASHRECEIPTIMPUTATION'Set @R = ( Select ID+'    ' +Coalesce(Description,'') From dxCashReceiptImputation  WITH (NOLOCK) Where PK_dxCashReceiptImputation = @FK  )
     else if @TableName  = 'DXCASHRECEIPTINVOICE'   Set @R = ( Select ID+'    ' From dxCashReceiptInvoice  WITH (NOLOCK) Where PK_dxCashReceiptInvoice = @FK  )
     else if @TableName  = 'DXCITY'                 Set @R = ( Select Coalesce(Name,'') From dxCity  WITH (NOLOCK) Where PK_dxCity = @FK  )
     else if @TableName  = 'DXCLIENT'               Set @R = ( Select ID+', ' +Coalesce(Name,'') From dxClient  WITH (NOLOCK) Where PK_dxClient = @FK  )
     else if @TableName  = 'DXCLIENTCATEGORY'       Set @R = ( Select Coalesce(Description,'') From dxClientCategory  WITH (NOLOCK) Where PK_dxClientCategory = @FK  )
     else if @TableName  = 'DXCLIENTPROMOTION'      Set @R = ( Select Coalesce(PromotionName,'') From dxClientPromotion  WITH (NOLOCK) Where PK_dxClientPromotion = @FK  )
     else if @TableName  = 'DXCLIENTNOTE'           Set @R = ( Select Convert(varchar(50), @FK)  From dxClientNote  WITH (NOLOCK) Where PK_dxClientNote = @FK  )
     else if @TableName  = 'DXCLIENTORDER'          Set @R = ( Select ID From dxClientOrder  WITH (NOLOCK) Where PK_dxClientOrder = @FK  )
     else if @TableName  = 'DXCLIENTORDERDETAIL'    Set @R = ( Select Convert(varchar(50), @FK)  From dxClientOrderDetail  WITH (NOLOCK) Where PK_dxClientOrderDetail = @FK  )
     else if @TableName  = 'DXCLIENTPRODUCT'        Set @R = ( Select Convert(varchar(50), @FK)  From dxClientProduct  WITH (NOLOCK) Where PK_dxClientProduct = @FK  )
     else if @TableName  = 'DXCOMPONENT'            Set @R = ( Select Convert(varchar(50), @FK)  From dxComponent  WITH (NOLOCK) Where PK_dxComponent = @FK  )
     else if @TableName  = 'DXCONSTRAINT'           Set @R = ( Select Convert(varchar(50), @FK)  From dxConstraint  WITH (NOLOCK) Where PK_dxConstraint = @FK  )
     else if @TableName  = 'DXCONTROLPROPERTY'      Set @R = ( Select ID+'    ' +Coalesce(Name,'') From dxControlProperty  WITH (NOLOCK) Where PK_dxControlProperty = @FK  )
     else if @TableName  = 'DXCONVERSIONFACTOR'     Set @R = ( Select Convert(varchar(50), @FK)  From dxConversionFactor  WITH (NOLOCK) Where PK_dxConversionFactor = @FK  )
     else if @TableName  = 'DXCOSTLEVEL'            Set @R = ( Select ID+', ' +Coalesce(Description,'') From dxCostLevel  WITH (NOLOCK) Where PK_dxCostLevel = @FK  )
     else if @TableName  = 'DXCOSTLEVELDETAIL'      Set @R = ( Select Convert(varchar(50), @FK)  From dxCostLevelDetail  WITH (NOLOCK) Where PK_dxCostLevelDetail = @FK  )
     else if @TableName  = 'DXCOSTLEVELVOLUME'      Set @R = ( Select Convert(varchar(50), @FK)  From dxCostLevelVolume  WITH (NOLOCK) Where PK_dxCostLevelVolume = @FK  )
     else if @TableName  = 'DXCOUNTRY'              Set @R = ( Select Coalesce(Name,'') From dxCountry  WITH (NOLOCK) Where PK_dxCountry = @FK  )
     else if @TableName  = 'DXCREDITAPPROBATION'    Set @R = ( Select ID +', '+Coalesce(Description,'') From dxCreditApprobation  WITH (NOLOCK) Where PK_dxCreditApprobation = @FK  )
     else if @TableName  = 'DXCURRENCY'             Set @R = ( Select ID From dxCurrency  WITH (NOLOCK) Where PK_dxCurrency = @FK  )
     else if @TableName  = 'DXCURRENCYDAILYRATE'    Set @R = ( Select  Convert(varchar(50), @FK)  From dxCurrencyDailyRate  WITH (NOLOCK) Where PK_dxCurrencyDailyRate = @FK  )
     else if @TableName  = 'DXCURRENCYDETAIL' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxCurrencyDetail  WITH (NOLOCK) Where PK_dxCurrencyDetail = @FK  )

     if @R = ''
          if @TableName  = 'DXDATAAUDIT' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxDataAudit  WITH (NOLOCK) Where PK_dxDataAudit = @FK  )
     else if @TableName  = 'DXDATAAUDITDETAIL' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxDataAuditDetail  WITH (NOLOCK) Where PK_dxDataAuditDetail = @FK  )
     else if @TableName  = 'DXDATASET' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxDataSet  WITH (NOLOCK) Where PK_dxDataSet = @FK  )
     else if @TableName  = 'DXDATASETFIELD' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxDataSetField  WITH (NOLOCK) Where PK_dxDataSetField = @FK  )
     else if @TableName  = 'DXDECLARATION' Set @R =  ( Select ID+'    ' From dxDeclaration  WITH (NOLOCK) Where PK_dxDeclaration = @FK  )
     else if @TableName  = 'DXDECLARATIONCONSUMPTION' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxDeclarationConsumption  WITH (NOLOCK) Where PK_dxDeclarationConsumption = @FK  )
     else if @TableName  = 'DXDECLARATIONLABOR' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxDeclarationLabor  WITH (NOLOCK) Where PK_dxDeclarationLabor = @FK  )
     else if @TableName  = 'DXDEPOSIT' Set @R =  ( Select Convert(varchar(50), @FK)+', '+Coalesce(Reference,'')  From dxDeposit  WITH (NOLOCK) Where PK_dxDeposit = @FK  )
     else if @TableName  = 'DXDEPOSITDETAIL' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxDepositDetail  WITH (NOLOCK) Where PK_dxDepositDetail = @FK  )
     else if @TableName  = 'DXDOCUMENTHISTORY' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxDocumentHistory  WITH (NOLOCK) Where PK_dxDocumentHistory = @FK  )
     else if @TableName  = 'DXDOMAIN' Set @R =  ( Select  Name  From dxDomain  WITH (NOLOCK) Where PK_dxDomain = @FK  )
     else if @TableName  = 'DXDOMAINVALUE' Set @R =  ( Select  DomainValue  From dxDomainValue  WITH (NOLOCK) Where PK_dxDomainValue = @FK  )
     else if @TableName  = 'DXEMPLOYEE' Set @R =  ( Select FirstName+' ' +LastName From dxEmployee  WITH (NOLOCK) Where PK_dxEmployee = @FK  )
     else if @TableName  = 'DXEMPLOYEECOMMISSION' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxEmployeeCommission  WITH (NOLOCK) Where PK_dxEmployeeCommission = @FK  )
     else if @TableName  = 'DXEMPLOYEESALARY' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxEmployeeSalary  WITH (NOLOCK) Where PK_dxEmployeeSalary = @FK  )
     else if @TableName  = 'DXENTRY' Set @R =  ( Select ID+'    ' From dxEntry  WITH (NOLOCK) Where PK_dxEntry = @FK  )
     else if @TableName  = 'DXENTRYRECURRENCETYPE' Set @R =  ( Select Coalesce(Name,'') From dxEntryRecurrenceType  WITH (NOLOCK) Where PK_dxEntryRecurrenceType = @FK  )
     else if @TableName  = 'DXFACTOR' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxFactor  WITH (NOLOCK) Where PK_dxFactor = @FK  )
     else if @TableName  = 'DXFINANCIALACCOUNT' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxFinancialAccount  WITH (NOLOCK) Where PK_dxFinancialAccount = @FK  )
     else if @TableName  = 'DXFINANCIALCOLUMN' Set @R =  ( Select ID+'    ' From dxFinancialColumn  WITH (NOLOCK) Where PK_dxFinancialColumn = @FK  )
     else if @TableName  = 'DXFINANCIALCOLUMNTYPE' Set @R =  ( Select ID+'    ' From dxFinancialColumnType  WITH (NOLOCK) Where PK_dxFinancialColumnType = @FK  )
     else if @TableName  = 'DXFINANCIALSECTION' Set @R =  ( Select ID+'    ' From dxFinancialSection  WITH (NOLOCK) Where PK_dxFinancialSection = @FK  )
     else if @TableName  = 'DXFINANCIALSTATEMENT' Set @R =  ( Select ID+'    ' +Coalesce(Description,'') From dxFinancialStatement  WITH (NOLOCK) Where PK_dxFinancialStatement = @FK  )
     else if @TableName  = 'DXFOB' Set @R =  ( Select ID+'    ' From dxFOB  WITH (NOLOCK) Where PK_dxFOB = @FK  )
     else if @TableName  = 'DXFORM' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxForm  WITH (NOLOCK) Where PK_dxForm = @FK  )
     else if @TableName  = 'DXGARBAGE' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxGarbage  WITH (NOLOCK) Where PK_dxGarbage = @FK  )
     else if @TableName  = 'DXGL' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxGL  WITH (NOLOCK) Where PK_dxGL = @FK  )
     else if @TableName  = 'DXINVENTORYADJUSTMENT' Set @R =  ( Select ID From dxInventoryAdjustment  WITH (NOLOCK) Where PK_dxInventoryAdjustment = @FK  )
     else if @TableName  = 'DXINVENTORYADJUSTMENTDETAIL' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxInventoryAdjustmentDetail  WITH (NOLOCK) Where PK_dxInventoryAdjustmentDetail = @FK  )
     else if @TableName  = 'DXINVENTORYADJUSTMENTTYPE' Set @R =  ( Select ID From dxInventoryAdjustmentType  WITH (NOLOCK) Where PK_dxInventoryAdjustmentType = @FK  )
     else if @TableName  = 'DXINVENTORYGROUP' Set @R =  ( Select ID From dxInventoryGroup  WITH (NOLOCK) Where PK_dxInventoryGroup = @FK  )
     else if @TableName  = 'DXINVENTORYTRANSFER' Set @R =  ( Select ID+'    ' From dxInventoryTransfer  WITH (NOLOCK) Where PK_dxInventoryTransfer = @FK  )
     else if @TableName  = 'DXINVENTORYTRANSFERDETAIL' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxInventoryTransferDetail  WITH (NOLOCK) Where PK_dxInventoryTransferDetail = @FK  )
     else if @TableName  = 'DXINVOICE' Set @R =  ( Select ID From dxInvoice  WITH (NOLOCK) Where PK_dxInvoice = @FK  )
     else if @TableName  = 'DXINVOICEDETAIL' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxInvoiceDetail  WITH (NOLOCK) Where PK_dxInvoiceDetail = @FK  )
     else if @TableName  = 'DXJOURNAL' Set @R =  ( Select Coalesce(Description,'') From dxJournal  WITH (NOLOCK) Where PK_dxJournal = @FK  )
     else if @TableName  = 'DXJOURNALENTRY' Set @R =  ( Select ID From dxJournalEntry  WITH (NOLOCK) Where PK_dxJournalEntry = @FK  )
     else if @TableName  = 'DXJOURNALENTRYDETAIL' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxJournalEntryDetail  WITH (NOLOCK) Where PK_dxJournalEntryDetail = @FK  )
     else if @TableName  = 'DXKANBAN' Set @R =  ( Select ID+'    ' From dxKanban  WITH (NOLOCK) Where PK_dxKanban = @FK  )
     else if @TableName  = 'DXLANGUAGE' Set @R =  ( Select RTrim(Coalesce(Caption,'')) From dxLanguage  WITH (NOLOCK) Where PK_dxLanguage = @FK  )
     else if @TableName  = 'DXLOCATION' Set @R =  ( Select ID From dxLocation  WITH (NOLOCK) Where PK_dxLocation = @FK  )
     else if @TableName  = 'DXLOTSIZING' Set @R =  ( Select ID+'    ' +Coalesce(Description,'') From dxLotSizing  WITH (NOLOCK) Where PK_dxLotSizing = @FK  )
     else if @TableName  = 'DXMENUPERMISSION' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxMenuPermission  WITH (NOLOCK) Where PK_dxMenuPermission = @FK  )
     else if @TableName  = 'DXMESSAGE' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxMessage  WITH (NOLOCK) Where PK_dxMessage = @FK  )
     else if @TableName  = 'DXMESSAGECAPTION' Set @R =  ( Select ID+'    ' From dxMessageCaption  WITH (NOLOCK) Where PK_dxMessageCaption = @FK  )
     else if @TableName  = 'DXMRP' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxMRP  WITH (NOLOCK) Where PK_dxMRP = @FK  )
     else if @TableName  = 'DXNOTE' Set @R =  ( Select ID+'    ' From dxNote  WITH (NOLOCK) Where PK_dxNote = @FK  )
     else if @TableName  = 'DXORDERSTATUS' Set @R =  ( Select Coalesce(Name,'') From dxOrderStatus  WITH (NOLOCK) Where PK_dxOrderStatus = @FK  )

     if @R = ''
          if @TableName  = 'DXPARAMETER' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxParameter  WITH (NOLOCK) Where PK_dxParameter = @FK  )
     else if @TableName  = 'DXPAYABLEINVOICE' Set @R =  ( Select ID+'    ' +Coalesce(Description,'') From dxPayableInvoice  WITH (NOLOCK) Where PK_dxPayableInvoice = @FK  )
     else if @TableName  = 'DXPAYABLEINVOICEDETAIL' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxPayableInvoiceDetail  WITH (NOLOCK) Where PK_dxPayableInvoiceDetail = @FK  )
     else if @TableName  = 'DXPAYMENT' Set @R =  ( Select  Convert(varchar(10),ID)+'    (' +Coalesce(Convert(varchar(20),ChequeNumber),'')+')' From dxPayment  WITH (NOLOCK) Where PK_dxPayment = @FK  )
     else if @TableName  = 'DXPAYCODE' Set @R =  ( Select ID+'    ' +Coalesce(Description, '') From dxPayCode  WITH (NOLOCK) Where PK_dxPayCode = @FK  )
     else if @TableName  = 'DXPAYCODETYPE' Set @R =  ( Select ID+'    ' +Coalesce(Description, '') From dxPayCodeType  WITH (NOLOCK) Where PK_dxPayCodeType = @FK  )
     else if @TableName  = 'DXPAYMEASUREUNIT' Set @R =  ( Select Coalesce(Symbol,'') From dxPayMeasureUnit  WITH (NOLOCK) Where PK_dxPayMeasureUnit = @FK  )
     else if @TableName  = 'DXPAYMENTIMPUTATION' Set @R =  ( Select ID+'    ' +Coalesce(Description,'') From dxPaymentImputation  WITH (NOLOCK) Where PK_dxPaymentImputation = @FK  )
     else if @TableName  = 'DXPAYMENTINVOICE' Set @R =  ( Select ID+'    ' From dxPaymentInvoice  WITH (NOLOCK) Where PK_dxPaymentInvoice = @FK  )
     else if @TableName  = 'DXPAYMENTPLANNING' Set @R =  ( Select ID+'    ' From dxPaymentPlanning  WITH (NOLOCK) Where PK_dxPaymentPlanning = @FK  )
     else if @TableName  = 'DXPAYMENTPLANNINGDETAIL' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxPaymentPlanningDetail  WITH (NOLOCK) Where PK_dxPaymentPlanningDetail = @FK  )
     else if @TableName  = 'DXPAYMENTTYPE' Set @R =  ( Select ID+'    ' +Coalesce(Description,'') From dxPaymentType  WITH (NOLOCK) Where PK_dxPaymentType = @FK  )
     else if @TableName  = 'DXPAYPERIOD' Set @R =  ( Select Convert(varchar(10),ID) From dxPayPeriod  WITH (NOLOCK) Where PK_dxPayPeriod = @FK  )
     else if @TableName  = 'DXPERIOD' Set @R =  ( Select Convert(varchar(10),ID) From dxPeriod  WITH (NOLOCK) Where PK_dxPeriod = @FK  )
     else if @TableName  = 'DXPHASE' Set @R =   ( Select Coalesce(Name,'') From dxPhase  WITH (NOLOCK) Where PK_dxPhase = @FK  )
     else if @TableName  = 'DXPHASEDETAIL' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxPhaseDetail  WITH (NOLOCK) Where PK_dxPhaseDetail = @FK  )
     else if @TableName  = 'DXPRICELEVEL' Set @R =  ( Select ID+'    ' +Coalesce(Description,'') From dxPriceLevel  WITH (NOLOCK) Where PK_dxPriceLevel = @FK  )
     else if @TableName  = 'DXPRICELEVELDETAIL' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxPriceLevelDetail  WITH (NOLOCK) Where PK_dxPriceLevelDetail = @FK  )
     else if @TableName  = 'DXPRICELEVELVOLUME' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxPriceLevelVolume  WITH (NOLOCK) Where PK_dxPriceLevelVolume = @FK  )
     else if @TableName  = 'DXPRICELEVELVOLUMEDISCOUNT' Set @R =  ( Select Coalesce(Description,'') From dxPriceLevelVolumeDiscount  WITH (NOLOCK) Where PK_dxPriceLevelVolumeDiscount = @FK  )
     else if @TableName  = 'DXPROCESS' Set @R = ( Select Coalesce(FrenchCaption, ProcessName) From dxProcess WITH(NOLOCK) Where PK_dxProcess = @FK )
     else if @TableName  = 'DXPROCESSDETAILTYPE' Set @R = ( Select Coalesce(Description, '') From dxProcessDetailType WITH(NOLOCK) Where PK_dxProcessDetailType = @FK )
     else if @TableName  = 'DXPRODUCT' Set @R =  ( Select ID+', ' +Coalesce(Description,'') From dxProduct  WITH (NOLOCK) Where PK_dxProduct = @FK  )
     else if @TableName  = 'DXPRODUCTCATEGORY' Set @R =  ( Select Coalesce(Description,'') From dxProductCategory  WITH (NOLOCK) Where PK_dxProductCategory = @FK  )
     else if @TableName  = 'DXPRODUCTIONLINE' Set @R =  ( Select Coalesce(Name,'') From dxProductionLine WITH (NOLOCK) Where PK_dxProductionLine = @FK  )
     else if @TableName  = 'DXPRODUCTLOCATION' Set @R =  ( Select Convert(varchar(50), @FK)  From dxProductLocation  WITH (NOLOCK) Where PK_dxProductLocation = @FK  )
     else if @TableName  = 'DXPRODUCTLOT' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxProductLot  WITH (NOLOCK) Where PK_dxProductLot = @FK  )
     else if @TableName  = 'DXPRODUCTPRODUCTIONDATE' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxProductProductionDate  WITH (NOLOCK) Where PK_dxProductProductionDate = @FK  )
     else if @TableName  = 'DXPRODUCTTRANSACTION' Set @R =  ( Select Coalesce(Description,'') From dxProductTransaction  WITH (NOLOCK) Where PK_dxProductTransaction = @FK  )
     else if @TableName  = 'DXPRODUCTWAREHOUSE' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxProductWarehouse  WITH (NOLOCK) Where PK_dxProductWarehouse = @FK  )
     else if @TableName  = 'DXPROJECT' Set @R =  ( Select ID+', ' +Coalesce(Description,'') From dxProject  WITH (NOLOCK) Where PK_dxProject = @FK  )
     else if @TableName  = 'DXPROJECTCATEGORY' Set @R =  ( Select ID+'    ' +Coalesce(Description,'') From dxProjectCategory  WITH (NOLOCK) Where PK_dxProjectCategory = @FK  )
     else if @TableName  = 'DXPROPERTY' Set @R =  ( Select Name From dxProperty  WITH (NOLOCK) Where PK_dxProperty = @FK  )
     else if @TableName  = 'DXPROPERTYGROUP' Set @R =  ( Select Name From dxPropertyGroup  WITH (NOLOCK) Where PK_dxPropertyGroup = @FK  )
     else if @TableName  = 'DXPURCHASEORDER' Set @R =  ( Select ID From dxPurchaseOrder  WITH (NOLOCK) Where PK_dxPurchaseOrder = @FK  )
     else if @TableName  = 'DXPURCHASEORDERDETAIL' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxPurchaseOrderDetail  WITH (NOLOCK) Where PK_dxPurchaseOrderDetail = @FK  )
     else if @TableName  = 'DXPURCHASEPLANNING' Set @R =  ( Select ID From dxPurchasePlanning  WITH (NOLOCK) Where PK_dxPurchasePlanning = @FK  )
     else if @TableName  = 'DXQUERY' Set @R =  ( Select ID+', ' +Coalesce(Description,'') From dxQuery  WITH (NOLOCK) Where PK_dxQuery = @FK  )
     else if @TableName  = 'DXQUERYPARAM' Set @R =  ( Select Coalesce(Name,'') From dxQueryParam  WITH (NOLOCK) Where PK_dxQueryParam = @FK  )
     else if @TableName  = 'DXQUERYPERMISSION' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxQueryPermission  WITH (NOLOCK) Where PK_dxQueryPermission = @FK  )
     else if @TableName  = 'DXRECEPTION' Set @R =  ( Select ID From dxReception  WITH (NOLOCK) Where PK_dxReception = @FK  )
     else if @TableName  = 'DXRECEPTIONDETAIL' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxReceptionDetail  WITH (NOLOCK) Where PK_dxReceptionDetail = @FK  )
     else if @TableName  = 'DXRECONCILIATIONTRANSACTIONTYPE' Set @R =  ( Select ID+'    ' +Coalesce(Description,'') From dxReconciliationTransactionType  WITH (NOLOCK) Where PK_dxReconciliationTransactionType = @FK  )
     else if @TableName  = 'DXREFERENTIALINTEGRITY' Set @R =  ( Select ID+'    ' From dxReferentialIntegrity  WITH (NOLOCK) Where PK_dxReferentialIntegrity = @FK  )
     else if @TableName  = 'DXREPORT' Set @R =  ( Select Coalesce(Description,'') From dxReport  WITH (NOLOCK) Where PK_dxReport = @FK  )
     else if @TableName  = 'DXREPORTCATEGORY' Set @R =  ( Select ID+', ' +Coalesce(Description,'') From dxReportCategory  WITH (NOLOCK) Where PK_dxReportCategory = @FK  )
     else if @TableName  = 'DXREPORTLOCATION' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxReportLocation  WITH (NOLOCK) Where PK_dxReportLocation = @FK  )
     else if @TableName  = 'DXREPORTPERMISSION' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxReportPermission  WITH (NOLOCK) Where PK_dxReportPermission = @FK  )
     else if @TableName  = 'DXRESOURCE' Set @R =  ( Select Coalesce(Name,'') From dxResource  WITH (NOLOCK) Where PK_dxResource = @FK  )
     else if @TableName  = 'DXRESOURCETYPE' Set @R =  ( Select Coalesce(Name,'') From dxResourceType  WITH (NOLOCK) Where PK_dxResourceType = @FK  )
     else if @TableName  = 'DXRESOURCERATE' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxResourceRate  WITH (NOLOCK) Where PK_dxResourceRate = @FK  )
     else if @TableName  = 'DXRMA' Set @R =  ( Select ID From dxRMA  WITH (NOLOCK) Where PK_dxRMA = @FK  )
     else if @TableName  = 'DXRMADETAIL' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxRMADetail  WITH (NOLOCK) Where PK_dxRMADetail = @FK  )
     else if @TableName  = 'DXRMADETAILREASON' Set @R =  ( Select ID+'    ' +Coalesce(Description,'') From dxRMADetailReason  WITH (NOLOCK) Where PK_dxRMADetailReason = @FK  )
     else if @TableName  = 'DXROUNDMODE' Set @R =  ( Select ID From dxRoundMode  WITH (NOLOCK) Where PK_dxRoundMode = @FK  )
     else if @TableName  = 'DXROUTING' Set @R =  ( Select ID+'    ' +Coalesce(Name,'') From dxRouting  WITH (NOLOCK) Where PK_dxRouting = @FK  )
     else if @TableName  = 'DXSCALEUNIT' Set @R =  ( Select Coalesce(Symbol,'') From dxScaleUnit  WITH (NOLOCK) Where PK_dxScaleUnit = @FK  )
     else if @TableName  = 'DXSCHEDULEREVENT' Set @R =  ( Select ID+'    ' +Coalesce(Caption,'') From dxSchedulerEvent  WITH (NOLOCK) Where PK_dxSchedulerEvent = @FK  )
     else if @TableName  = 'DXSCRIPT' Set @R =  ( Select ID+'    ' +Coalesce(Description,'') From dxScript  WITH (NOLOCK) Where PK_dxScript = @FK  )
     else if @TableName  = 'DXSETUP' Set @R =  ( Select Coalesce(Description,'') From dxSetup  WITH (NOLOCK) Where PK_dxSetup = @FK  )
     else if @TableName  = 'DXSETUPOPTION' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxSetupOption  WITH (NOLOCK) Where PK_dxSetupOption = @FK  )
     else if @TableName  = 'DXTERRITORY' Set @R =  ( Select Name From dxTerritory  WITH (NOLOCK) Where PK_dxTerritory = @FK  )
     else if @TableName  = 'DXSHIPPING' Set @R =  ( Select ID From dxShipping  WITH (NOLOCK) Where PK_dxShipping = @FK  )
     else if @TableName  = 'DXSHIPPINGDETAIL' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxShippingDetail  WITH (NOLOCK) Where PK_dxShippingDetail = @FK  )
     else if @TableName  = 'DXSHIPVIA' Set @R =  ( Select ID From dxShipVia  WITH (NOLOCK) Where PK_dxShipVia = @FK  )
     else if @TableName  = 'DXSHIPPINGZONE' Set @R =  ( Select Coalesce(Description,ID) From dxShippingZone  WITH (NOLOCK) Where PK_dxShippingZone = @FK  )
     else if @TableName  = 'DXSHIPPINGSERVICETYPE' Set @R =  ( Select Coalesce(Description,ID) From dxShippingServiceType  WITH (NOLOCK) Where PK_dxShippingServiceType = @FK  )
     else if @TableName  = 'DXSPREADSHEET' Set @R =  ( Select ID+'    ' +Coalesce(Description,'') From dxSpreadSheet  WITH (NOLOCK) Where PK_dxSpreadSheet = @FK  )
     else if @TableName  = 'DXSPREADSHEETCELL' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxSpreadsheetCell  WITH (NOLOCK) Where PK_dxSpreadsheetCell = @FK  )
     else if @TableName  = 'DXSTANDARDCOSTHISTORY' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxStandardCostHistory  WITH (NOLOCK) Where PK_dxStandardCostHistory = @FK  )
     else if @TableName  = 'DXSTATE' Set @R =  ( Select Coalesce(Name,'') From dxState  WITH (NOLOCK) Where PK_dxState = @FK  )
     else if @TableName  = 'DXSTATUS' Set @R =  ( Select Coalesce(Description,'') From dxStatus  WITH (NOLOCK) Where PK_dxStatus = @FK  )
     else if @TableName  = 'DXTABLE' Set @R =  ( Select Coalesce(Name,'') From dxTable  WITH (NOLOCK) Where PK_dxTable = @FK  )
     else if @TableName  = 'DXTABLEPERMISSION' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxTablePermission  WITH (NOLOCK) Where PK_dxTablePermission = @FK  )
     else if @TableName  = 'DXTAX' Set @R =  ( Select ID From dxTax  WITH (NOLOCK) Where PK_dxTax = @FK  )
     else if @TableName  = 'DXTAXDETAIL' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxTaxDetail  WITH (NOLOCK) Where PK_dxTaxDetail = @FK  )
     else if @TableName  = 'DXTERMS' Set @R =  ( Select ID From dxTerms  WITH (NOLOCK) Where PK_dxTerms = @FK  )
     else if @TableName  = 'DXUNPOSTACCOUNTTRANSACTION' Set @R =  ( Select Coalesce(Description,'') From dxUnpostAccountTransaction  WITH (NOLOCK) Where PK_dxUnpostAccountTransaction = @FK  )
     else if @TableName  = 'DXUSER' Set @R =  ( Select Coalesce(FirstName,'')+' ' +Coalesce(LastName,'') From dxUser  WITH (NOLOCK) Where PK_dxUser = @FK  )
     else if @TableName  = 'DXUSERGROUP' Set @R =  ( Select Coalesce(Description,'') From dxUserGroup  WITH (NOLOCK) Where PK_dxUserGroup = @FK  )
     else if @TableName  = 'DXUSERGROUPMEMBER' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxUserGroupMember  WITH (NOLOCK) Where PK_dxUserGroupMember = @FK  )
     else if @TableName  = 'DXUSERTIMESHEET' Set @R =  ( Select ID+'    ' From dxUserTimesheet  WITH (NOLOCK) Where PK_dxUserTimesheet = @FK  )
     else if @TableName  = 'DXUSERTIMESHEETDETAIL' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxUserTimesheetDetail  WITH (NOLOCK) Where PK_dxUserTimesheetDetail = @FK  )
     else if @TableName  = 'DXVENDOR' Set @R =  ( Select ID+', ' +Coalesce(Name,'') From dxVendor  WITH (NOLOCK) Where PK_dxVendor = @FK  )
     else if @TableName  = 'DXVENDORCATEGORY' Set @R =  ( Select ID+'    ' +Coalesce(Description,'') From dxVendorCategory  WITH (NOLOCK) Where PK_dxVendorCategory = @FK  )
     else if @TableName  = 'DXVENDORNOTE' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxVendorNote  WITH (NOLOCK) Where PK_dxVendorNote = @FK  )
     else if @TableName  = 'DXVENDORPRODUCT' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxVendorProduct  WITH (NOLOCK) Where PK_dxVendorProduct = @FK  )
     else if @TableName  = 'DXWAREHOUSE' Set @R =  ( Select Coalesce(Name,'') From dxWarehouse  WITH (NOLOCK) Where PK_dxWarehouse = @FK  )
     else if @TableName  = 'DXWORKORDER' Set @R =  ( Select Convert(varchar(50),ID) +' ('+ Coalesce(Lot,'')+')' From dxWorkOrder  WITH (NOLOCK) Where PK_dxWorkOrder = @FK  )
     else if @TableName  = 'DXWORKORDERFINISHEDPRODUCT' Set @R =  ( Select  Convert(varchar(50), @FK)  From dxWorkOrderFinishedProduct  WITH (NOLOCK) Where PK_dxWorkOrderFinishedProduct = @FK  )
     else if @R = '' set @R = Convert(Varchar(50), @FK)
   end

   Return @R

end
GO
