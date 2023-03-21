SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- --------------------------------------------------------------------------------------------
CREATE  function [dbo].[fdxGetFKLookupField] ( @TableName  varchar(100)  )
returns varchar(500)
as
begin

   Declare @R varchar(Max)



   set @TableName = UPPER(@TableName)
   set @R = [dbo].[fcxGetFKLookupField] ( @TableName )

   if @R = ''
   begin
          if @TableName  = 'DXACCOUNT' Set @R =  ' Select PK_dxAccount, ID as Account, Description From dxAccount WITH(NOLOCK) '
     else if @TableName  = 'DXACCOUNTCATEGORY' Set @R =  ' Select PK_dxAccountCategory, ID as AccountCategory, Description From dxAccountCategory WITH(NOLOCK) '
     else if @TableName  = 'DXACCOUNTCONFIGURATION' Set @R =  ' Select PK_dxAccountConfiguration, ID as AccountConfiguration, Description From dxAccountConfiguration WITH(NOLOCK) '
     else if @TableName  = 'DXACCOUNTEXPENSE' Set @R =  ' Select PK_dxAccountExpense, ID as AccountExpense From dxAccountExpense WITH(NOLOCK) '
     else if @TableName  = 'DXACCOUNTINGYEAR' Set @R =  ' Select PK_dxAccountingYear, ID as AccountingYear, Description From dxAccountingYear WITH(NOLOCK) '
     else if @TableName  = 'DXACCOUNTREVENUE' Set @R =  ' Select PK_dxAccountRevenue, ID as AccountRevenue From dxAccountRevenue WITH(NOLOCK) '
     else if @TableName  = 'DXACCOUNTTRANSACTION' Set @R =  ' Select PK_dxAccountTransaction, Description From dxAccountTransaction WITH(NOLOCK) '
     else if @TableName  = 'DXACCOUNTTYPE' Set @R =  ' Select PK_dxAccountType, ID as AccountType, Description From dxAccountType WITH(NOLOCK) '
     else if @TableName  = 'DXACCOUNTUSAGE' Set @R =  ' Select PK_dxAccountUsage, ID as AccountUsage, Description From dxAccountUsage WITH(NOLOCK) '
     else if @TableName  = 'DXACTION' Set @R =  ' Select PK_dxAction From dxAction WITH(NOLOCK) '
     else if @TableName  = 'DXACTIVITY' Set @R =  ' Select PK_dxActivity, ID as Activity, Description From dxActivity WITH(NOLOCK) '
     else if @TableName  = 'DXADDRESS' Set @R =  ' Select PK_dxAddress, ad.ID as No, CompanyName, at.ID as AddressType, Address1 From dxAddress ad  WITH(NOLOCK) left join dxAddressType at  WITH(NOLOCK)  on ( PK_dxAddressType = FK_dxAddressType )'
     else if @TableName  = 'DXADDRESSTYPE' Set @R =  ' Select PK_dxAddressType, ID as AddressType From dxAddressType WITH(NOLOCK) '
     else if @TableName  = 'DXAPPLICATIONEVENT' Set @R =  ' Select PK_dxApplicationEvent, ID as ApplicationEvent, Description From dxApplicationEvent WITH(NOLOCK) '
     else if @TableName  = 'DXASSEMBLY' Set @R =  ' Select PK_dxAssembly, ID as Assembly From dxAssembly WITH(NOLOCK) '
     else if @TableName  = 'DXASSEMBLYDETAIL' Set @R =  ' Select PK_dxAssemblyDetail, ID as AssemblyDetail From dxAssemblyDetail WITH(NOLOCK) '
     else if @TableName  = 'DXBANK' Set @R =  ' Select PK_dxBank, Name From dxBank WITH(NOLOCK) '
     else if @TableName  = 'DXBANKACCOUNT' Set @R =  ' Select PK_dxBankAccount, AccountNumber, ( Select ID from dxCurrency where PK_dxCurrency = FK_dxCurrency) as Currency, (Select Name from dxBank where PK_dxBank = FK_dxBank) as Bank From dxBankAccount WITH(NOLOCK) '
     else if @TableName  = 'DXBANKRECONCILIATION' Set @R =  ' Select PK_dxBankReconciliation, ID as BankReconciliation From dxBankReconciliation WITH(NOLOCK) '
     else if @TableName  = 'DXBANKRECONCILIATIONDETAIL' Set @R =  ' Select PK_dxBankReconciliationDetail, Description From dxBankReconciliationDetail WITH(NOLOCK) '
     else if @TableName  = 'DXBATCHPRINTINGCHEQUE' Set @R =  ' Select PK_dxBatchPrintingCheque From dxBatchPrintingCheque WITH(NOLOCK) '
     else if @TableName  = 'DXCASHRECEIPT' Set @R =  ' Select PK_dxCashReceipt, ID as CashReceipt, Description From dxCashReceipt WITH(NOLOCK) '
     else if @TableName  = 'DXCASHRECEIPTIMPUTATION' Set @R =  ' Select PK_dxCashReceiptImputation, ID as CashReceiptImputation, Description From dxCashReceiptImputation WITH(NOLOCK) '
     else if @TableName  = 'DXCASHRECEIPTINVOICE' Set @R =  ' Select PK_dxCashReceiptInvoice, ID as CashReceiptInvoice From dxCashReceiptInvoice WITH(NOLOCK) '
     else if @TableName  = 'DXCITY' Set @R =  ' Select PK_dxCity, ID as City, Name From dxCity WITH(NOLOCK) '
     else if @TableName  = 'DXCLIENT' Set @R =  ' Select PK_dxClient, ID as Client, Convert(varchar(200),Reference) as Reference, Name From dxClient WITH(NOLOCK) '
     else if @TableName  = 'DXCLIENTCATEGORY' Set @R =  ' Select PK_dxClientCategory, ID as ClientCategory, Description From dxClientCategory WITH(NOLOCK) '
     else if @TableName  = 'DXCLIENTPROMOTION' Set @R =  ' Select PK_dxClientPromotion, PromotionName as ClientPromotion, Description, EffectiveDate, ValidUntil From dxClientPromotion WITH(NOLOCK) '
     else if @TableName  = 'DXCLIENTNOTE' Set @R =  ' Select PK_dxClientNote From dxClientNote WITH(NOLOCK) '
     else if @TableName  = 'DXCLIENTORDER' Set @R =  ' Select PK_dxClientOrder, ID as ClientOrder, Description From dxClientOrder WITH(NOLOCK) '
     else if @TableName  = 'DXCLIENTORDERDETAIL' Set @R =  ' Select PK_dxClientOrderDetail, Description From dxClientOrderDetail WITH(NOLOCK) '
     else if @TableName  = 'DXCLIENTPRODUCT' Set @R =  ' Select PK_dxClientProduct From dxClientProduct WITH(NOLOCK) '
     else if @TableName  = 'DXCOMPONENT' Set @R =  ' Select PK_dxComponent From dxComponent WITH(NOLOCK) '
     else if @TableName  = 'DXCONSTRAINT' Set @R =  ' Select PK_dxConstraint From dxConstraint WITH(NOLOCK) '
     else if @TableName  = 'DXCONTROLPROPERTY' Set @R =  ' Select PK_dxControlProperty, ID as ControlProperty, Name From dxControlProperty WITH(NOLOCK) '
     else if @TableName  = 'DXCONVERSIONFACTOR' Set @R =  ' Select PK_dxConversionFactor From dxConversionFactor WITH(NOLOCK) '
     else if @TableName  = 'DXCOSTLEVEL' Set @R =  ' Select PK_dxCostLevel, ID as CostLevel, Description From dxCostLevel WITH(NOLOCK) '
     else if @TableName  = 'DXCOSTLEVELDETAIL' Set @R =  ' Select PK_dxCostLevelDetail From dxCostLevelDetail WITH(NOLOCK) '
     else if @TableName  = 'DXCOSTLEVELVOLUME' Set @R =  ' Select PK_dxCostLevelVolume From dxCostLevelVolume WITH(NOLOCK) '
     else if @TableName  = 'DXCOUNTRY' Set @R =  ' Select PK_dxCountry, Name  From dxCountry WITH(NOLOCK) '
     else if @TableName  = 'DXCREDITAPPROBATION' Set @R =  ' Select PK_dxCreditApprobation, ID as CreditApprobation, Description From dxCreditApprobation WITH(NOLOCK) '
     else if @TableName  = 'DXCURRENCY' Set @R =  ' Select PK_dxCurrency, ID as Currency, Description From dxCurrency WITH(NOLOCK) '
     else if @TableName  = 'DXCURRENCYDAILYRATE' Set @R =  ' Select PK_dxCurrencyDailyRate From dxCurrencyDailyRate WITH(NOLOCK) '
     else if @TableName  = 'DXCURRENCYDETAIL' Set @R =  ' Select PK_dxCurrencyDetail From dxCurrencyDetail WITH(NOLOCK) '

     if @R = ''
          if @TableName  = 'DXDATAAUDIT' Set @R =  ' Select PK_dxDataAudit From dxDataAudit WITH(NOLOCK) '
     else if @TableName  = 'DXDATAAUDITDETAIL' Set @R =  ' Select PK_dxDataAuditDetail From dxDataAuditDetail WITH(NOLOCK) '
     else if @TableName  = 'DXDATASET' Set @R =  ' Select PK_dxDataSet From dxDataSet WITH(NOLOCK) '
     else if @TableName  = 'DXDATASETFIELD' Set @R =  ' Select PK_dxDataSetField From dxDataSetField WITH(NOLOCK) '
     else if @TableName  = 'DXDECLARATION' Set @R =  ' Select PK_dxDeclaration, ID as Declaration From dxDeclaration WITH(NOLOCK) '
     else if @TableName  = 'DXDECLARATIONCONSUMPTION' Set @R =  ' Select PK_dxDeclarationConsumption From dxDeclarationConsumption WITH(NOLOCK) '
     else if @TableName  = 'DXDECLARATIONLABOR' Set @R =  ' Select PK_dxDeclarationLabor From dxDeclarationLabor WITH(NOLOCK) '
     else if @TableName  = 'DXDEPOSIT' Set @R =  ' Select PK_dxDeposit, ID as Deposit From dxDeposit WITH(NOLOCK) '
     else if @TableName  = 'DXDEPOSITDETAIL' Set @R =  ' Select PK_dxDepositDetail From dxDepositDetail WITH(NOLOCK) '
     else if @TableName  = 'DXDOCUMENTHISTORY' Set @R =  ' Select PK_dxDocumentHistory From dxDocumentHistory WITH(NOLOCK) '
     else if @TableName  = 'DXDOMAIN' Set @R =  ' Select PK_dxDomain, Name From dxDomain WITH(NOLOCK) '
     else if @TableName  = 'DXDOMAINVALUE' Set @R =  ' Select PK_dxDomainValue, DomainValue From dxDomainValue WITH(NOLOCK) '
     else if @TableName  = 'DXEMPLOYEE' Set @R =  ' Select PK_dxEmployee, FirstName, LastName From dxEmployee WITH(NOLOCK) '
     else if @TableName  = 'DXEMPLOYEECOMMISSION' Set @R =  ' Select PK_dxEmployeeCommission From dxEmployeeCommission WITH(NOLOCK) '
     else if @TableName  = 'DXEMPLOYEESALARY' Set @R =  ' Select PK_dxEmployeeSalary From dxEmployeeSalary WITH(NOLOCK) '
     else if @TableName  = 'DXENTRY' Set @R =  ' Select PK_dxEntry, ID as Entry From dxEntry WITH(NOLOCK) '
     else if @TableName  = 'DXENTRYRECURRENCETYPE' Set @R =  ' Select PK_dxEntryRecurrenceType, Name From dxEntryRecurrenceType WITH(NOLOCK) '
     else if @TableName  = 'DXFACTOR' Set @R =  ' Select PK_dxFactor From dxFactor WITH(NOLOCK) '
     else if @TableName  = 'DXFACTORTABLER' Set @R =  ' Select PK_dxFactorTableR From dxFactorTableR WITH(NOLOCK) '
     else if @TableName  = 'DXFINANCIALACCOUNT' Set @R =  ' Select PK_dxFinancialAccount From dxFinancialAccount WITH(NOLOCK) '
     else if @TableName  = 'DXFINANCIALCOLUMN' Set @R =  ' Select PK_dxFinancialColumn, ID as FinancialColumn From dxFinancialColumn WITH(NOLOCK) '
     else if @TableName  = 'DXFINANCIALCOLUMNTYPE' Set @R =  ' Select PK_dxFinancialColumnType, ID as FinancialColumnType From dxFinancialColumnType WITH(NOLOCK) '
     else if @TableName  = 'DXFINANCIALSECTION' Set @R =  ' Select PK_dxFinancialSection, ID as FinancialSection From dxFinancialSection WITH(NOLOCK) '
     else if @TableName  = 'DXFINANCIALSTATEMENT' Set @R =  ' Select PK_dxFinancialStatement, ID as FinancialStatement, Description From dxFinancialStatement WITH(NOLOCK) '
     else if @TableName  = 'DXFOB' Set @R =  ' Select PK_dxFOB, ID as FOB , FOB as Description From dxFOB WITH(NOLOCK) '
     else if @TableName  = 'DXFORM' Set @R =  ' Select PK_dxForm From dxForm WITH(NOLOCK) '
     else if @TableName  = 'DXGARBAGE' Set @R =  ' Select PK_dxGarbage From dxGarbage WITH(NOLOCK) '
     else if @TableName  = 'DXGL' Set @R =  ' Select PK_dxGL From dxGL WITH(NOLOCK) '
     else if @TableName  = 'DXINVENTORYADJUSTMENT' Set @R =  ' Select PK_dxInventoryAdjustment, ID as InventoryAdjustment, Description From dxInventoryAdjustment WITH(NOLOCK) '
     else if @TableName  = 'DXINVENTORYADJUSTMENTDETAIL' Set @R =  ' Select PK_dxInventoryAdjustmentDetail, Description From dxInventoryAdjustmentDetail WITH(NOLOCK) '
     else if @TableName  = 'DXINVENTORYADJUSTMENTTYPE' Set @R =  ' Select PK_dxInventoryAdjustmentType, ID as InventoryAdjustmentType, Description From dxInventoryAdjustmentType WITH(NOLOCK) '
     else if @TableName  = 'DXINVENTORYGROUP' Set @R =  ' Select PK_dxInventoryGroup, ID as InventoryGroup, Description From dxInventoryGroup WITH(NOLOCK) '
     else if @TableName  = 'DXINVENTORYTRANSFER' Set @R =  ' Select PK_dxInventoryTransfer, ID as InventoryTransfer From dxInventoryTransfer WITH(NOLOCK) '
     else if @TableName  = 'DXINVENTORYTRANSFERDETAIL' Set @R =  ' Select PK_dxInventoryTransferDetail From dxInventoryTransferDetail WITH(NOLOCK) '
     else if @TableName  = 'DXINVOICE' Set @R =  ' Select PK_dxInvoice, ID as Invoice, Description From dxInvoice WITH(NOLOCK) '
     else if @TableName  = 'DXINVOICEDETAIL' Set @R =  ' Select PK_dxInvoiceDetail, Description From dxInvoiceDetail WITH(NOLOCK) '
     else if @TableName  = 'DXJOURNAL' Set @R =  ' Select PK_dxJournal, ID as Journal, Description From dxJournal WITH(NOLOCK) '
     else if @TableName  = 'DXJOURNALENTRY' Set @R =  ' Select PK_dxJournalEntry, ID as JournalEntry, Description From dxJournalEntry WITH(NOLOCK) '
     else if @TableName  = 'DXJOURNALENTRYDETAIL' Set @R =  ' Select PK_dxJournalEntryDetail, Description From dxJournalEntryDetail WITH(NOLOCK) '
     else if @TableName  = 'DXKANBAN' Set @R =  ' Select PK_dxKanban, ID as Kanban From dxKanban WITH(NOLOCK) '
     else if @TableName  = 'DXLANGUAGE' Set @R =  ' Select PK_dxLanguage, ID as Language, Caption From dxLanguage WITH(NOLOCK) '
     else if @TableName  = 'DXLOCATION' Set @R =  ' Select PK_dxLocation, ID as Location, Description From dxLocation WITH(NOLOCK) '
     else if @TableName  = 'DXLOTSIZING' Set @R =  ' Select PK_dxLotSizing, ID as LotSizing, Description From dxLotSizing WITH(NOLOCK) '
     else if @TableName  = 'DXMENUPERMISSION' Set @R =  ' Select PK_dxMenuPermission From dxMenuPermission WITH(NOLOCK) '
     else if @TableName  = 'DXMESSAGE' Set @R =  ' Select PK_dxMessage From dxMessage WITH(NOLOCK) '
     else if @TableName  = 'DXMESSAGECAPTION' Set @R =  ' Select PK_dxMessageCaption, ID as MessageCaption From dxMessageCaption WITH(NOLOCK) '
     else if @TableName  = 'DXMRP' Set @R =  ' Select PK_dxMRP From dxMRP WITH(NOLOCK) '
     else if @TableName  = 'DXMRPLEVEL' Set @R =  ' Select PK_dxMRPLevel From dxMRPLevel WITH(NOLOCK) '
     else if @TableName  = 'DXNOTE' Set @R =  ' Select PK_dxNote, ID as Note From dxNote WITH(NOLOCK) '
     else if @TableName  = 'DXORDERSTATUS' Set @R =  ' Select PK_dxOrderStatus, ID as OrderStatus, Name From dxOrderStatus WITH(NOLOCK) '
     else if @TableName  = 'DXPARAMETER' Set @R =  ' Select PK_dxParameter From dxParameter WITH(NOLOCK) '
     else if @TableName  = 'DXPAYABLEINVOICE' Set @R =  ' Select PK_dxPayableInvoice, ID as PayableInvoice, Description From dxPayableInvoice WITH(NOLOCK) '
     else if @TableName  = 'DXPAYABLEINVOICEDETAIL' Set @R =  ' Select PK_dxPayableInvoiceDetail, Description From dxPayableInvoiceDetail WITH(NOLOCK) '
     else if @TableName  = 'DXPAYCODE' Set @R = ' Select pc.PK_dxPayCode, pc.ID as PayCode, pc.Description, pct.Description as PayCodeType From dxPayCode pc WITH(NOLOCK) Left Join dxPayCodeType pct WITH(NOLOCK) on (pc.FK_dxPayCodeType = pct.PK_dxPayCodeType) '
     else if @TableName  = 'DXPAYCODETYPE' Set @R = ' Select PK_dxPayCodeType, Description, IsGain, IsDeduction From dxPayCodeType WITH(NOLOCK) '
     else if @TableName  = 'DXPAYMEASUREUNIT' Set @R = ' Select PK_dxPayMeasureUnit, Symbol, Description From dxPayMeasureUnit WITH(NOLOCK) '
     else if @TableName  = 'DXPAYMENT' Set @R =  ' Select PK_dxPayment, ID as Payment, ChequeNumber, TotalAmount From dxPayment WITH(NOLOCK) '
     else if @TableName  = 'DXPAYMENTIMPUTATION' Set @R =  ' Select PK_dxPaymentImputation, ID as PaymentImputation, Description From dxPaymentImputation WITH(NOLOCK) '
     else if @TableName  = 'DXPAYMENTINVOICE' Set @R =  ' Select PK_dxPaymentInvoice, ID as PaymentInvoice From dxPaymentInvoice WITH(NOLOCK) '
     else if @TableName  = 'DXPAYMENTPLANNING' Set @R =  ' Select PK_dxPaymentPlanning, ID as PaymentPlanning From dxPaymentPlanning WITH(NOLOCK) '
     else if @TableName  = 'DXPAYMENTPLANNINGDETAIL' Set @R =  ' Select PK_dxPaymentPlanningDetail From dxPaymentPlanningDetail WITH(NOLOCK) '
     else if @TableName  = 'DXPAYMENTTYPE' Set @R =  ' Select PK_dxPaymentType, ID as PaymentType, Description From dxPaymentType WITH(NOLOCK) '
     else if @TableName  = 'DXPAYPERIOD' Set @R =  ' Select PK_dxPayPeriod, ID as PayPeriod, StartDate, EndDate, PaymentDate From dxPayPeriod WITH(NOLOCK) '
     else if @TableName  = 'DXPERIOD' Set @R =  ' Select PK_dxPeriod, ID as Period From dxPeriod WITH(NOLOCK) '
     else if @TableName  = 'DXPHASE' Set @R =  ' Select PK_dxPhase, Name From dxPhase WITH(NOLOCK) '
     else if @TableName  = 'DXPHASEDETAIL' Set @R =  ' Select PK_dxPhaseDetail, Description From dxPhaseDetail WITH(NOLOCK) '
     else if @TableName  = 'DXPRICELEVEL' Set @R =  ' Select PK_dxPriceLevel, ID as PriceLevel, Description From dxPriceLevel WITH(NOLOCK) '
     else if @TableName  = 'DXPRICELEVELDETAIL' Set @R =  ' Select PK_dxPriceLevelDetail From dxPriceLevelDetail WITH(NOLOCK) '
     else if @TableName  = 'DXPRICELEVELVOLUME' Set @R =  ' Select PK_dxPriceLevelVolume From dxPriceLevelVolume WITH(NOLOCK) '
     else if @TableName  = 'DXPRICELEVELVOLUMEDISCOUNT' Set @R =  ' Select PK_dxPriceLevelVolumeDiscount, Description From dxPriceLevelVolumeDiscount WITH(NOLOCK) '
     else if @TableName  = 'DXPROCESS' Set @R = ' Select PK_dxProcess, ProcessName, FrenchCaption from dxProcess WITH(NOLOCK) '
     else if @TableName  = 'DXPROCESSDETAILTYPE' Set @R = ' Select PK_dxProcessDetailType, Description from dxProcessDetailType WITH(NOLOCK) '
     else if @TableName  = 'DXPRODUCT' Set @R =  ' Select PK_dxProduct, ID as Product, Description, EnglishDescription, SpanishDescription From dxProduct WITH(NOLOCK) '
     else if @TableName  = 'DXPRODUCTCATEGORY' Set @R =  ' Select PK_dxProductCategory, Description From dxProductCategory WITH(NOLOCK) '
     else if @TableName  = 'DXPRODUCTIONLINE' Set @R =  ' Select PK_dxProductionLine, ID as ProductionLine, Name From dxProductionLine WITH(NOLOCK) '
     else if @TableName  = 'DXPRODUCTFORECASTPERMONTH' Set @R =  ' Select PK_dxProductForecastPerMonth From dxProductForecastPerMonth WITH(NOLOCK) '
     else if @TableName  = 'DXPRODUCTFORECASTPERWEEK' Set @R =  ' Select PK_dxProductForecastPerWeek From dxProductForecastPerWeek WITH(NOLOCK) '
     else if @TableName  = 'DXPRODUCTLOCATION' Set @R =  ' Select PK_dxProductLocation From dxProductLocation WITH(NOLOCK) '
     else if @TableName  = 'DXPRODUCTLOT' Set @R =  ' Select PK_dxProductLot From dxProductLot WITH(NOLOCK) '
     else if @TableName  = 'DXPRODUCTPRODUCTIONDATE' Set @R =  ' Select PK_dxProductProductionDate From dxProductProductionDate WITH(NOLOCK) '
     else if @TableName  = 'DXPRODUCTTRANSACTION' Set @R =  ' Select PK_dxProductTransaction, Description From dxProductTransaction WITH(NOLOCK) '
     else if @TableName  = 'DXPRODUCTWAREHOUSE' Set @R =  ' Select PK_dxProductWarehouse From dxProductWarehouse WITH(NOLOCK) '
     else if @TableName  = 'DXPROJECT' Set @R =  ' Select PK_dxProject, ID as Project, Description From dxProject WITH(NOLOCK) '
     else if @TableName  = 'DXPROJECTCATEGORY' Set @R =  ' Select PK_dxProjectCategory, ID as ProjectCategory, Description From dxProjectCategory WITH(NOLOCK) '
     else if @TableName  = 'DXPROPERTYGROUP' Set @R =  ' Select PK_dxPropertyGroup, Name as PropertyGroup From dxPropertyGroup WITH(NOLOCK) '
     else if @TableName  = 'DXPURCHASEORDER' Set @R =  ' Select PK_dxPurchaseOrder, ID as PurchaseOrder, Description From dxPurchaseOrder WITH(NOLOCK) '
     else if @TableName  = 'DXPURCHASEORDERDETAIL' Set @R =  ' Select PK_dxPurchaseOrderDetail, Description From dxPurchaseOrderDetail WITH(NOLOCK) '
     else if @TableName  = 'DXPURCHASEPLANNING' Set @R =  ' Select PK_dxPurchasePlanning, ID as PurchasePlanning From dxPurchasePlanning WITH(NOLOCK) '
     else if @TableName  = 'DXQUERY' Set @R =  ' Select PK_dxQuery, ID as Query, Description From dxQuery WITH(NOLOCK) '
     else if @TableName  = 'DXQUERYPARAM' Set @R =  ' Select PK_dxQueryParam, Name From dxQueryParam WITH(NOLOCK) '
     else if @TableName  = 'DXQUERYPERMISSION' Set @R =  ' Select PK_dxQueryPermission From dxQueryPermission WITH(NOLOCK) '

     if @R = ''
          if @TableName  = 'DXRECEPTION' Set @R =  ' Select PK_dxReception, ID as Reception, Description From dxReception WITH(NOLOCK) '
     else if @TableName  = 'DXRECEPTIONDETAIL' Set @R =  ' Select PK_dxReceptionDetail, Description From dxReceptionDetail WITH(NOLOCK) '
     else if @TableName  = 'DXRECONCILIATIONTRANSACTIONTYPE' Set @R =  ' Select PK_dxReconciliationTransactionType, ID as ReconciliationTransactionType, Description From dxReconciliationTransactionType WITH(NOLOCK) '
     else if @TableName  = 'DXREFERENTIALINTEGRITY' Set @R =  ' Select PK_dxReferentialIntegrity, ID as ReferentialIntegrity From dxReferentialIntegrity WITH(NOLOCK) '
     else if @TableName  = 'DXREPORT' Set @R =  ' Select PK_dxReport, ID as Report, Description From dxReport WITH(NOLOCK) '
     else if @TableName  = 'DXREPORTCATEGORY' Set @R =  ' Select PK_dxReportCategory, ID as ReportCategory, Description From dxReportCategory WITH(NOLOCK) '
     else if @TableName  = 'DXREPORTLOCATION' Set @R =  ' Select PK_dxReportLocation From dxReportLocation WITH(NOLOCK) '
     else if @TableName  = 'DXREPORTPERMISSION' Set @R =  ' Select PK_dxReportPermission From dxReportPermission WITH(NOLOCK) '
     else if @TableName  = 'DXRESOURCE' Set @R =  ' Select PK_dxResource, ID as Resource, Name From dxResource WITH(NOLOCK) '
     else if @TableName  = 'DXRESOURCETYPE' Set @R =  ' Select PK_dxResourceType, ID as ResourceType, Name From dxResourceType WITH(NOLOCK) '
     else if @TableName  = 'DXRESOURCERATE' Set @R =  ' Select PK_dxResourceRate From dxResourceRate WITH(NOLOCK) '
     else if @TableName  = 'DXRMA' Set @R =  ' Select PK_dxRMA, ID as RMA, Description From dxRMA WITH(NOLOCK) '
     else if @TableName  = 'DXRMADETAIL' Set @R =  ' Select PK_dxRMADetail, Description From dxRMADetail WITH(NOLOCK) '
     else if @TableName  = 'DXRMADETAILREASON' Set @R =  ' Select PK_dxRMADetailReason, ID as RMADetailReason, Description From dxRMADetailReason WITH(NOLOCK) '
     else if @TableName  = 'DXROUNDMODE' Set @R =  ' Select PK_dxRoundMode, ID as RoundMode From dxRoundMode WITH(NOLOCK) '
     else if @TableName  = 'DXROUTING' Set @R =  ' Select PK_dxRouting, ID as Routing, Name From dxRouting WITH(NOLOCK) '
     else if @TableName  = 'DXSCALEUNIT' Set @R =  ' Select PK_dxScaleUnit, Symbol, Description From dxScaleUnit WITH(NOLOCK) '
     else if @TableName  = 'DXSCHEDULEREVENT' Set @R =  ' Select PK_dxSchedulerEvent, ID as SchedulerEvent, Caption From dxSchedulerEvent WITH(NOLOCK) '
     else if @TableName  = 'DXSCRIPT' Set @R =  ' Select PK_dxScript, ID as Script, Description From dxScript WITH(NOLOCK) '
     else if @TableName  = 'DXSETUP' Set @R =  ' Select PK_dxSetup, Description From dxSetup WITH(NOLOCK) '
     else if @TableName  = 'DXSETUPOPTION' Set @R =  ' Select PK_dxSetupOption From dxSetupOption WITH(NOLOCK) '
     else if @TableName  = 'DXSHIPPING' Set @R =  ' Select PK_dxShipping, ID as Shipping, Description From dxShipping WITH(NOLOCK) '
     else if @TableName  = 'DXSHIPPINGDETAIL' Set @R =  ' Select PK_dxShippingDetail, Description From dxShippingDetail WITH(NOLOCK) '
     else if @TableName  = 'DXSHIPVIA' Set @R =  ' Select PK_dxShipVia, ID as ShipVia, ShipVia Description From dxShipVia WITH(NOLOCK) '
     else if @TableName  = 'DXSHIPPINGSERVICETYPE' Set @R =  ' Select PK_dxShippingServiceType, ID as ShippingServiceType, Description From dxShippingServiceType WITH(NOLOCK) '
     else if @TableName  = 'DXSHIPPINGZONE' Set @R =  ' Select PK_dxShippingZone, ID as ShippingZone, Description From dxShippingZone WITH(NOLOCK) '
     else if @TableName  = 'DXSPREADSHEET' Set @R =  ' Select PK_dxSpreadSheet, ID as SpreadSheet, Description From dxSpreadSheet WITH(NOLOCK) '
     else if @TableName  = 'DXSPREADSHEETCELL' Set @R =  ' Select PK_dxSpreadsheetCell From dxSpreadsheetCell WITH(NOLOCK) '
     else if @TableName  = 'DXSTANDARDCOSTHISTORY' Set @R =  ' Select PK_dxStandardCostHistory From dxStandardCostHistory WITH(NOLOCK) '
     else if @TableName  = 'DXSTATE' Set @R =  ' Select PK_dxState, Name From dxState WITH(NOLOCK) '
     else if @TableName  = 'DXSTATUS' Set @R =  ' Select PK_dxStatus, ID as Status, Description From dxStatus WITH(NOLOCK) '
     else if @TableName  = 'DXTABLE' Set @R =  ' Select PK_dxTable, Name, Caption From dxTable WITH(NOLOCK) '
     else if @TableName  = 'DXTABLEPERMISSION' Set @R =  ' Select PK_dxTablePermission From dxTablePermission WITH(NOLOCK) '
     else if @TableName  = 'DXTAX' Set @R =  ' Select PK_dxTax, ID as Tax, Description From dxTax WITH(NOLOCK) '
     else if @TableName  = 'DXTAXDETAIL' Set @R =  ' Select PK_dxTaxDetail From dxTaxDetail WITH(NOLOCK) '
     else if @TableName  = 'DXTERMS' Set @R =  ' Select PK_dxTerms, Description as Terms From dxTerms WITH(NOLOCK) '
     else if @TableName  = 'DXTERRITORY' Set @R =  ' Select PK_dxTerritory, Name as Territory From dxTerritory WITH(NOLOCK) '
     else if @TableName  = 'DXUNPOSTACCOUNTTRANSACTION' Set @R =  ' Select PK_dxUnpostAccountTransaction, Description From dxUnpostAccountTransaction WITH(NOLOCK) '
     else if @TableName  = 'DXUSER' Set @R =  ' Select PK_dxUser, FirstName, LastName From dxUser WITH(NOLOCK) '
     else if @TableName  = 'DXUSERGROUP' Set @R =  ' Select PK_dxUserGroup, ID as UserGroup, Description From dxUserGroup WITH(NOLOCK) '
     else if @TableName  = 'DXUSERGROUPMEMBER' Set @R =  ' Select PK_dxUserGroupMember From dxUserGroupMember WITH(NOLOCK) '
     else if @TableName  = 'DXUSERTIMESHEET' Set @R =  ' Select PK_dxUserTimesheet, ID as UserTimesheet From dxUserTimesheet WITH(NOLOCK) '
     else if @TableName  = 'DXUSERTIMESHEETDETAIL' Set @R =  ' Select PK_dxUserTimesheetDetail, ID as UserTimesheetDetail, Description From dxUserTimesheetDetail WITH(NOLOCK) '
     else if @TableName  = 'DXVENDOR' Set @R =  ' Select PK_dxVendor, ID as Vendor, Name From dxVendor WITH(NOLOCK) '
     else if @TableName  = 'DXVENDORCATEGORY' Set @R =  ' Select PK_dxVendorCategory, ID as VendorCategory, Description From dxVendorCategory WITH(NOLOCK) '
     else if @TableName  = 'DXVENDORNOTE' Set @R =  ' Select PK_dxVendorNote From dxVendorNote WITH(NOLOCK) '
     else if @TableName  = 'DXVENDORPRODUCT' Set @R =  ' Select PK_dxVendorProduct From dxVendorProduct WITH(NOLOCK) '
     else if @TableName  = 'DXWAREHOUSE' Set @R =  ' Select PK_dxWarehouse, Name From dxWarehouse WITH(NOLOCK) '
     else if @TableName  = 'DXWORKORDER' Set @R =  ' Select PK_dxWorkOrder, ID as WorkOrder From dxWorkOrder WITH(NOLOCK) '
     else if @TableName  = 'DXWORKORDERFINISHEDPRODUCT' Set @R =  ' Select PK_dxWorkOrderFinishedProduct From dxWorkOrderFinishedProduct WITH(NOLOCK) '
   end -- if @R = ''

   Return @R

end
GO
