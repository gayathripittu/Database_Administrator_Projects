---------------- BACKUP ----------------

CREATE OR ALTER PROCEDURE SP_Database_backup(
@databasename sysname, -- The name of the database to backup
@backup_type Char(1)     -- The type of backup: 'F' for full, 'D' for differential, 'L' for log
)
As
BEGIN
	SET NOCOUNT ON

	DECLARE @sqlquery nvarchar(1000)              -- Variable to hold the dynamic SQL query
	DECLARE @formattedDateTime VARCHAR(20);       -- Variable to hold the formatted current date and time
	-- Format the current date and time as YYYYMMDDHHMMSS
	SET @formattedDateTime = REPLACE(CONVERT(VARCHAR(10), GETDATE(), 111), '/', '') +  
                             REPLACE(CONVERT(VARCHAR(5), GETDATE(), 108), ':', '');

-- Full backup
	IF @backup_type = 'F'
		SET @sqlquery = 'BACKUP DATABASE' + @databasename +
		' TO DISK = ''E:\Backup\' + @databasename + @formattedDateTime + '.BAK''' 

-- DIFFERENTIAL backup	
	IF @backup_type = 'D'  
		SET @sqlquery = 'BACKUP DATABASE ' + @databasename +  
        ' TO DISK = ''E:\Backup\' + @databasename + '_Diff_' + @formattedDateTime + '.BAK'' WITH DIFFERENTIAL'  

-- LOG backup        
    IF @backup_type = 'L'  
		SET @sqlquery = 'BACKUP LOG ' + @databasename +  
        ' TO DISK = ''E:\Backup\' + @databasename + '_Log_' + @formattedDateTime + '.TRN''' 

--  Execute the constructed SQL query
	EXECUTE sp_executesql @sqlquery

END


SP_Database_backup 'Hospital', 'F';

SP_Database_backup 'Hospital', 'D';

SP_Database_backup 'Hospital', 'L';



