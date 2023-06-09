CREATE TABLE [dbo].[dxProcessDetailType]
(
[PK_dxProcessDetailType] [int] NOT NULL IDENTITY(1, 1),
[ID] [nvarchar] (50) COLLATE French_CI_AS NOT NULL,
[Description] [varchar] (255) COLLATE French_CI_AS NOT NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[dxProcessDetailType.trAuditDelete] ON [dbo].[dxProcessDetailType]
FOR DELETE
AS
 SET NOCOUNT ON
 Declare @audittype char(1)
 select @audittype = 'D'

 Declare @tablename  varchar (50)
 set @tablename = 'dxProcessDetailType'

 Declare @pkdataaudit int
 Declare @auditdate datetime
 Declare @username varchar(128)
 Declare @fk_dxuser varchar(128);
 select @username = system_user ,
	@auditdate = getdate()

 select @fk_dxuser = dbo.fdxGetContextInfo('User')

 Declare pk_cursordxProcessDetailType CURSOR LOCAL FAST_FORWARD for SELECT PK_dxProcessDetailType, ID, Description from deleted
 Declare @PK_dxProcessDetailType int, @ID varchar(50), @Description varchar(255)

 OPEN pk_cursordxProcessDetailType
 FETCH NEXT FROM pk_cursordxProcessDetailType INTO @PK_dxProcessDetailType, @ID, @Description
 WHILE @@FETCH_STATUS = 0
 BEGIN
    insert into dxDataAudit( AuditType, PrimaryKeyValue, TableName, AuditDate, UserName, FK_dxUser ) 
        select @audittype, @PK_dxProcessDetailType, @tablename, @auditdate, @username, @fk_dxuser
    select @pkdataaudit = SCOPE_IDENTITY()
/*--------------------------------------------------------------------------------------------------------------*/
    insert into dxDataAuditDetail( FK_dxDataAudit, FieldName, ValueAsString ) 
        select @pkdataaudit, 'ID', @ID
/*--------------------------------------------------------------------------------------------------------------*/
    insert into dxDataAuditDetail( FK_dxDataAudit, FieldName, ValueAsString ) 
        select @pkdataaudit, 'Description', @Description
FETCH NEXT FROM pk_cursordxProcessDetailType INTO @PK_dxProcessDetailType, @ID, @Description
 END

 CLOSE pk_cursordxProcessDetailType 
 DEALLOCATE pk_cursordxProcessDetailType
 SET NOCOUNT OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[dxProcessDetailType.trAuditInsUpd] ON [dbo].[dxProcessDetailType] 
FOR UPDATE, INSERT 
AS

 Declare @tablename  varchar (50);
 Declare @keyvalue int ;
 Declare @audittype char(1) ;
 Declare @auditdate datetime ;
 Declare @username varchar(128) ;
 Declare @pkdataaudit int;
 Declare @fk_dxuser varchar(128);

 Declare pk_cursordxProcessDetailType CURSOR LOCAL FAST_FORWARD for SELECT PK_dxProcessDetailType from inserted;
 set @tablename = 'dxProcessDetailType' ;

 if exists (select 1 from inserted)
	if exists (select 1 from deleted)
			select @audittype = 'U'
		else
			select @audittype = 'I'

 -- date and user
 select @username = system_user ,
	@auditdate = getdate(),
        @fk_dxuser = dbo.fdxGetContextInfo('User')

 OPEN pk_cursordxProcessDetailType
 FETCH NEXT FROM pk_cursordxProcessDetailType INTO @keyvalue
 WHILE @@FETCH_STATUS = 0
 BEGIN     
     insert into dxDataAudit( AuditType, AuditDate, PrimaryKeyValue, TableName, UserName, FK_dxUser ) 
      select @audittype, @auditdate, @keyvalue, @tablename, @username, @fk_dxuser
     select @pkdataaudit = SCOPE_IDENTITY()
/*--------------------------------------------------------------------------------------------------------------*/
     if Update( ID )
     begin
        insert into dxDataAuditDetail( FK_dxDataAudit, FieldName, ValueAsString ) 
        select @pkdataaudit, 'ID', ID from dxProcessDetailType where PK_dxProcessDetailType = @keyvalue
     end ;
/*--------------------------------------------------------------------------------------------------------------*/
     if Update( Description )
     begin
        insert into dxDataAuditDetail( FK_dxDataAudit, FieldName, ValueAsString ) 
        select @pkdataaudit, 'Description', Description from dxProcessDetailType where PK_dxProcessDetailType = @keyvalue
     end ;
FETCH NEXT FROM pk_cursordxProcessDetailType INTO @keyvalue
 END

 CLOSE pk_cursordxProcessDetailType 
 DEALLOCATE pk_cursordxProcessDetailType
GO
ALTER TABLE [dbo].[dxProcessDetailType] ADD CONSTRAINT [PK_dxProcessDetailType] PRIMARY KEY CLUSTERED  ([PK_dxProcessDetailType]) ON [PRIMARY]
GO
