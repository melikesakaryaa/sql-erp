SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- --------------------------------------------------------------------------------------------
-- Author:		Bernard Cincou
-- Create date: 2011-09-19
-- Description:	Insert Accounting Transaction linked with the inventory
-- --------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[pdxProductTransactionDeclarationPhase]
AS
BEGIN
  SET NOCOUNT ON
  Declare @FK_dxCurrency__System int
        , @FK_dxAccount__LaborAbsorbed int
        , @FK_dxAccount__OverheadFixedAbsorbed int
        , @FK_dxAccount__OverheadVariableAbsorbed int
  Select
      @FK_dxCurrency__System = FK_dxCurrency__System
     ,@FK_dxAccount__LaborAbsorbed = FK_dxAccount__LaborAbsorbed
     ,@FK_dxAccount__OverheadFixedAbsorbed = FK_dxAccount__OverheadFixedAbsorbed
     ,@FK_dxAccount__OverheadVariableAbsorbed = FK_dxAccount__OverheadVariableAbsorbed
  from dxAccountConfiguration

  Declare @KOD int -- Kind Of Document
  Set @KOD = 15

  BEGIN
      ------------------------------------------------------------------------------------
      EXECUTE [dbo].[pdxPrepareInventoryAccountingEntry] @KindOfDocument = @KOD
      ------------------------------------------------------------------------------------
      -- Pour le materiel on annule la phase précédente et on augment la phase actuel.
      -- Dans la déclaration de la phase on considère seulement le coût standard de la MOD et des FGF et FGV pour les enregistrer dans l'absorbtion
      ------------------------------------------------------------------------------------
      -- Material Standard Cost
      insert into dxAccountTransaction ( FK_dxEntry, TransactionDate, FK_dxJournal, FK_dxPeriod, FK_dxAccount , Description, DT ,CT ,FK_dxCurrency, EndOfPeriodInventory, KindOfDocument,PrimaryKeyValue )
      Select
            en.PK_dxEntry ,ei.TransactionDate, 76, pe.PK_dxPeriod
           ,wa.FK_dxAccount__Material
           ,left('MAT-STD '+wa.ID +', '+lo.ID +', '+pr.ID +', Lot:'+ei.Lot +', '+ei.description,100)
           ,dbo.fdxDT( ei.PhaseMaterialStandardCostVariance )
           ,dbo.fdxCT( ei.PhaseMaterialStandardCostVariance )
           ,@FK_dxCurrency__System,0,ei.KindOfDocument,ei.PK_dxProductTransaction
      From dxProductTransactionToUpdate pu
      left outer join dxProductTransaction ei on ( pu.FK_dxProductTransaction = ei.PK_dxProductTransaction)
      left outer join dxEntry     en on ( en.KindOfDocument = ei.KindOfDocument and en.PrimaryKeyValue = ei.PrimaryKeyValue )
      left outer join dxPeriod    pe on ( ei.TransactionDate between pe.StartDate and pe.EndDate)
      left outer join dxWarehouse wa on ( wa.PK_dxWarehouse  = ei.FK_dxWarehouse)
      left outer join dxLocation  lo on ( lo.PK_dxLocation   = ei.FK_dxLocation)
      left outer join dxProduct   pr on ( pr.PK_dxProduct    = ei.FK_dxProduct  )
      Where abs(ei.PhaseMaterialStandardCostVariance) > 0.0000001
        and ei.KindOfDocument = @KOD
      ------------------------------------------------------------------------------------
      -- Labor Standard Cost
      insert into dxAccountTransaction ( FK_dxEntry, TransactionDate, FK_dxJournal, FK_dxPeriod, FK_dxAccount , Description, DT ,CT ,FK_dxCurrency, EndOfPeriodInventory, KindOfDocument,PrimaryKeyValue )
      Select
            en.PK_dxEntry ,ei.TransactionDate, 76, pe.PK_dxPeriod
           ,wa.FK_dxAccount__Labor
           ,left('LAB-STD '+wa.ID +', '+lo.ID +', '+pr.ID +', Lot:'+ei.Lot +', '+ei.description,100)
           ,dbo.fdxDT( ei.PhaseLaborStandardCostVariance )
           ,dbo.fdxCT( ei.PhaseLaborStandardCostVariance )
           ,@FK_dxCurrency__System,0,ei.KindOfDocument,ei.PK_dxProductTransaction
      From dxProductTransactionToUpdate pu
      left outer join dxProductTransaction ei on ( pu.FK_dxProductTransaction = ei.PK_dxProductTransaction)
      left outer join dxEntry     en on ( en.KindOfDocument = ei.KindOfDocument and en.PrimaryKeyValue = ei.PrimaryKeyValue )
      left outer join dxPeriod    pe on ( ei.TransactionDate between pe.StartDate and pe.EndDate)
      left outer join dxWarehouse wa on ( wa.PK_dxWarehouse  = ei.FK_dxWarehouse)
      left outer join dxLocation  lo on ( lo.PK_dxLocation   = ei.FK_dxLocation)
      left outer join dxProduct   pr on ( pr.PK_dxProduct    = ei.FK_dxProduct  )
      Where abs(ei.PhaseLaborStandardCostVariance) > 0.0000001
        and ei.KindOfDocument = @KOD
      ------------------------------------------------------------------------------------
      -- Labor Absorbtion
      insert into dxAccountTransaction ( FK_dxEntry, TransactionDate, FK_dxJournal, FK_dxPeriod, FK_dxAccount , Description, DT ,CT ,FK_dxCurrency, EndOfPeriodInventory, KindOfDocument,PrimaryKeyValue )
      Select
            en.PK_dxEntry ,ei.TransactionDate, 76, pe.PK_dxPeriod
           ,@FK_dxAccount__LaborAbsorbed
           ,left('LAB-ABS  '+wa.ID +', '+lo.ID +', '+pr.ID +', Lot:'+ei.Lot +', '+ei.description,100)
           ,dbo.fdxCT( ei.PhaseLaborStandardCostVariance )
           ,dbo.fdxDT( ei.PhaseLaborStandardCostVariance )
           ,@FK_dxCurrency__System,0,ei.KindOfDocument,ei.PK_dxProductTransaction
      From dxProductTransactionToUpdate pu
      left outer join dxProductTransaction ei on ( pu.FK_dxProductTransaction = ei.PK_dxProductTransaction)
      left outer join dxEntry     en on ( en.KindOfDocument = ei.KindOfDocument and en.PrimaryKeyValue = ei.PrimaryKeyValue )
      left outer join dxPeriod    pe on ( ei.TransactionDate between pe.StartDate and pe.EndDate)
      left outer join dxWarehouse wa on ( wa.PK_dxWarehouse  = ei.FK_dxWarehouse)
      left outer join dxLocation  lo on ( lo.PK_dxLocation   = ei.FK_dxLocation)
      left outer join dxProduct   pr on ( pr.PK_dxProduct    = ei.FK_dxProduct  )
      left outer join dxProductCategory  pc on ( pc.PK_dxProductCategory  = pr.FK_dxProductCategory  )
      Where abs( ei.PhaseLaborStandardCostVariance ) > 0.0000001
      and ei.KindOfDocument = @KOD
      ------------------------------------------------------------------------------------
      -- Delete newly modified Transactions Reference
      delete from dxProductTransactionToUpdate where KindOfDocument = @KOD
 end
END
GO
