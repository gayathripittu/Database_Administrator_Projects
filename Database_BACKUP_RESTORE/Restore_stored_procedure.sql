------ Restore


CREATE Or ALTER PROCEDURE SP_Database_recovery(
    @original_databasename sysname, 
    @new_databasename sysname, 
    @backup_type CHAR(1),
    @backup_file_path VARCHAR(255)
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sqlquery NVARCHAR(1000);
    DECLARE @dbExists BIT;

    -- Check if the new database exists
    SET @dbExists = CASE WHEN DB_ID(@new_databasename) IS NULL THEN 0 ELSE 1 END;

    IF @dbExists = 1
    BEGIN
        -- Ensure single user mode to avoid conflicts during restore
        SET @sqlquery = 'ALTER DATABASE ' + @new_databasename + ' SET SINGLE_USER WITH ROLLBACK IMMEDIATE';
        EXEC sp_executesql @sqlquery;
    END
    ELSE
    BEGIN
        -- Create the new database if it doesn't exist
        SET @sqlquery = 'CREATE DATABASE ' + @new_databasename;
        EXEC sp_executesql @sqlquery;
    END

    -- Verify that the backup file exists
    

    IF @backup_type = 'F'
    BEGIN
        -- Restore full backup
        SET @sqlquery = 'RESTORE DATABASE ' + @new_databasename + 
                        ' FROM DISK = ''' + @backup_file_path + '''' + 
                        ' WITH MOVE ''' + @original_databasename + '_Data'' TO ''C:\Path\To\NewData.mdf'',' + 
                        ' MOVE ''' + @original_databasename + '_Log'' TO ''C:\Path\To\NewLog.ldf'',' + 
                        ' NORECOVERY';
    END

    IF @backup_type = 'D'
    BEGIN
        -- Restore differential backup
        SET @sqlquery = 'RESTORE DATABASE ' + @new_databasename + 
                        ' FROM DISK = ''' + @backup_file_path + '''' + 
                        ' WITH NORECOVERY';
    END

    IF @backup_type = 'L'
    BEGIN
        -- Restore transaction log backup
        SET @sqlquery = 'RESTORE LOG ' + @new_databasename + 
                        ' FROM DISK = ''' + @backup_file_path + '''' + 
                        ' WITH NORECOVERY';
    END

    -- Execute the restore command
    EXEC sp_executesql @sqlquery;

    -- If this is the final restore step, set the database to multi-user mode and finish the recovery
    IF @backup_type = 'F' OR @backup_type = 'L'
    BEGIN
        -- Finalize the recovery process
        SET @sqlquery = 'RESTORE DATABASE ' + @new_databasename + ' WITH RECOVERY';
        EXEC sp_executesql @sqlquery;

        -- Set database back to multi-user mode
        SET @sqlquery = 'ALTER DATABASE ' + @new_databasename + ' SET MULTI_USER';
        EXEC sp_executesql @sqlquery;
    END
END



------------------ Execution 
Drop database Hospital_DB_New;
--- Full Restore

EXEC SP_Database_recovery 'Hospital', 'Hospital_DB_New', 'F', 'E:\Backup\Hospital202406301609.BAK';


-- Differential Restore
EXEC SP_Database_recovery 'Hospital', 'Hospital_DB_New', 'D', 'E:\Backup\Hospital_Diff_202406301609.BAK';


-- Log Restore
EXEC SP_Database_recovery 'Hospital', 'Hospital_DB_New', 'L', 'E:\Backup\Hospital_Log_202406301609.TRN';


