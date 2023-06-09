SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- --------------------------------------------------------------------------------------------
create view [dbo].[dxAccountReceivableAging] as

Select i.FK_dxCurrency,  d.ID as Currency, l.PK_dxClient,  l.ID,  l.Name,   i.PK_dxInvoice, 
       i.TransactionDate as InvoiceDate,   ( select max(ADate) from dxParameter) as AgingDate,
       DATEDIFF ( Day, i.TransactionDate , ( select max(ADate) from dxParameter)  ) as NumberOfDays,
       i.TotalAmount as InvoiceAmount,   

      ( select sum(cr.PaidAmount)  from dxCashReceiptInvoice cr where i.PK_dxInvoice = cr.FK_dxInvoice 
        and cr.posted = 1 and cr.TransactionDate <=( select max(ADate) from dxParameter) ) as TotalPaidAmount,

        case when DATEDIFF ( Day, i.TransactionDate , ( select max(ADate) from dxParameter)  ) <= 30  then 
          i.TotalAmount -( select Coalesce(sum(cr.PaidAmount),0.0)  from dxCashReceiptInvoice cr  where i.PK_dxInvoice = cr.FK_dxInvoice 
           and cr.posted = 1 and cr.TransactionDate <= ( select max(ADate) from dxParameter)  ) else 0.0 end as N30 ,

        case when DATEDIFF ( Day, i.TransactionDate , ( select max(ADate) from dxParameter)  ) between  31 and 60 then
          i.TotalAmount -( select Coalesce(sum(cr.PaidAmount),0.0)  from dxCashReceiptInvoice cr  where i.PK_dxInvoice = cr.FK_dxInvoice 
          and cr.posted = 1 and cr.TransactionDate <= ( select max(ADate) from dxParameter)  ) else 0.0 end as N60 ,

        case when DATEDIFF ( Day, i.TransactionDate , ( select max(ADate) from dxParameter)  ) between  61 and 90 then
          i.TotalAmount -( select Coalesce(sum(cr.PaidAmount),0.0)  from dxCashReceiptInvoice cr  where i.PK_dxInvoice = cr.FK_dxInvoice 
          and cr.posted = 1 and cr.TransactionDate <= ( select max(ADate) from dxParameter)  ) else 0.0 end as N90 ,

        case when DATEDIFF ( Day, i.TransactionDate , ( select max(ADate) from dxParameter)  ) between  91 and 120 then
          i.TotalAmount -( select Coalesce(sum(cr.PaidAmount),0.0)  from dxCashReceiptInvoice cr  where i.PK_dxInvoice = cr.FK_dxInvoice 
          and cr.posted = 1 and cr.TransactionDate <= ( select max(ADate) from dxParameter)  ) else 0.0 end as N120 ,

        case when DATEDIFF ( Day, i.TransactionDate , ( select max(ADate) from dxParameter)  ) > 120  then 
          i.TotalAmount -( select Coalesce(sum(cr.PaidAmount),0.0)  from dxCashReceiptInvoice cr  where i.PK_dxInvoice = cr.FK_dxInvoice 
          and cr.posted = 1 and cr.TransactionDate <= ( select max(ADate) from dxParameter)  ) else 0.0 end as N120P ,

       i.TotalAmount -( select Coalesce(sum(cr.PaidAmount),0.0)  from dxCashReceiptInvoice cr 
                                                   where i.PK_dxInvoice = cr.FK_dxInvoice 
                                                     and cr.posted = 1 and cr.TransactionDate <= ( select max(ADate) from dxParameter)  ) as BalanceAmount
from dxInvoice i 
     inner join dxClient l on (l.PK_dxClient = i.FK_dxClient )
     inner join dxCurrency d on (d.PK_dxCurrency = i.FK_dxCurrency )

where i.TransactionDate <= ( select max(ADate) from dxParameter ) 
and   i.posted = 1
and  (i.TotalAmount -( select Coalesce(sum(cr.PaidAmount),0.0)  from dxCashReceiptInvoice cr 
                                                   where i.PK_dxInvoice = cr.FK_dxInvoice 
                                                   and cr.posted = 1  and cr.TransactionDate <= ( select max(ADate) from dxParameter)  )) <> 0.0
GO
