SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- --------------------------------------------------------------------------------------------
create PROCEDURE [dbo].[pdxDropPKIndexes]
AS
 Declare @table_name  varchar (100) ;
 Declare @column_name varchar (100) ;
 Declare @Index_name  varchar (100) ;
 Declare @SQL         varchar (500) ;
 Declare @exclusions  varchar (1000);
 
 
 Declare pk_cursor CURSOR FAST_FORWARD for 
   SELECT COLUMNS.TABLE_NAME, COLUMNS.COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS COLUMNS, INFORMATION_SCHEMA.TABLES TABLES
   WHERE COLUMNS.COLUMN_NAME LIKE 'PK[_]%' AND COLUMNS.TABLE_NAME=TABLES.TABLE_NAME AND
         TABLES.TABLE_TYPE='BASE TABLE' AND 
          EXISTS(SELECT 1 FROM SYS.INDEXES 
	             WHERE NAME = 'IxPK_'+COLUMNS.TABLE_NAME+'_'+COLUMNS.COLUMN_NAME);
 
 BEGIN TRANSACTION
   OPEN pk_cursor
   -- First record 
   FETCH NEXT FROM pk_cursor INTO @table_name, @column_name
   WHILE @@FETCH_STATUS = 0
   BEGIN
      select @Index_name = 'IxPK_' + @table_name + '_' + @column_name;
      select @SQL = 'DROP INDEX ' + @Index_name + ' ON ' + @table_name  ;
      EXEC(@SQL);
      -- next record
      FETCH NEXT FROM pk_cursor INTO @table_name, @column_name
   END

 CLOSE pk_cursor 
 DEALLOCATE pk_cursor
 COMMIT
GO
