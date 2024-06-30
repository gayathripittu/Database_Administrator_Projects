# Database Backup and Restore

This project provides stored procedures for performing database backups and restores in SQL Server. 

## Backup Stored Procedure

### `SP_Database_backup`

This stored procedure allows you to create full, differential, and transaction log backups of a specified database.

#### Usage

```sql
EXEC SP_Database_backup @databasename = 'YourDatabaseName', @backup_type = 'F';
EXEC SP_Database_backup @databasename = 'YourDatabaseName', @backup_type = 'D';
EXEC SP_Database_backup @databasename = 'YourDatabaseName', @backup_type = 'L';
```
-**@databasename:** The name of the database to back up. <br>
-**@backup_type:** The type of backup to perform. <br>
  - 'F': Full backup. <br>
  - 'D': Differential backup. <br>
  - 'L': Transaction log backup. <br>

#### Backup File Naming
The backup files are stored in the E:\Backup\ directory with the following naming conventions:

- **Full Backup:** YourDatabaseName_Full_YYYYMMDDHHMM.BAK
- **Differential Backup:** YourDatabaseName_Diff_YYYYMMDDHHMM.BAK
- **Transaction Log Backup:** YourDatabaseName_Log_YYYYMMDDHHMM.TRN <br> <br>


## Restore Stored Procedure

### `SP_Database_recovery`

This stored procedure allows you to restore a database from full, differential, and transaction log backups. It can also restore to a new database name if specified.
#### Usage

```sql
EXEC SP_Database_recovery @original_databasename = 'OriginalDatabaseName', @new_databasename = 'NewDatabaseName', @backup_type = 'F', @backup_file_path = 'Path\OriginalDatabaseNameYYYYMMDDHHMM.BAK';<br>
EXEC SP_Database_recovery @original_databasename = 'OriginalDatabaseName', @new_databasename = 'NewDatabaseName', @backup_type = 'D', @backup_file_path = 'Path\OriginalDatabaseName_Diff_YYYYMMDDHHMM.BAK';<br>
EXEC SP_Database_recovery @original_databasename = 'OriginalDatabaseName', @new_databasename = 'NewDatabaseName', @backup_type = 'L', @backup_file_path = 'Path\OriginalDatabaseName_Log_YYYYMMDDHHMM.TRN';

```
<br>
- **@original_databasename:** The name of the original database from which the backup was taken.
- **@new_databasename:** The name of the new database to which the backup will be restored.
- **@backup_type:** The type of backup to restore
  - 'F': Full backup.
  - 'D': Differential backup.
  - 'L': Transaction log backup.
- **@backup_file_path:** The path to the backup file.

**Permissions:** Ensure you have the necessary permissions to create and alter databases.
**File Paths:** Verify that the specified backup file paths exist and are accessible.
**Database State:** The restore procedure handles setting the database to single-user mode before restoring and reverting to multi-user mode afterward.


