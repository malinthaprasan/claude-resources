---
name: apim:setup-mssql
description: Setup a local APIM instance (wso2am-4.0.0-SNAPSHOT) to use an MSSQL database running in Docker, including JDBC driver install and deployment.toml config.
---

# Setup a local APIM instance

## Steps

### Prerequisites:
1. Make sure user's $(pwd) contains an API Manager unzipped package under name "wso2am-4.0.0-SNAPSHOT". If its not there, ask to have it first and exit. Continue otherwise.

### Gather all required information upfront:
1. Ask for a setup name, suggesting the current folder name as default ($(basename $(pwd))). If user provides a name, use it. Otherwise, use the suggested default. Lowercase it and store in variable $NAME. Make it fully UPPER CASE and remove any special chars like "-" with "_" and store in $DB_NAME

2. Ask the user to use the generic mssql container or create a new one. If generic, set $mssql_container_name to "mssql-my-generic", otherwise set it to "mssql-$NAME"

   Set $MSSQL_SA_PASSWORD from the `MSSQL_SA_PASSWORD` environment variable if set; otherwise prompt the user for the SA password (treat as sensitive — do not echo it back). **Do not hardcode any password in this file.**

3. **Ask for all required permissions in one go:**
   - Permission to create/modify files in current directory (for database script)
   - Permission to run Docker commands (pull images, create containers, execute commands)
   - Permission to modify the deployment.toml configuration file
   - Permission to download and install the MSSQL JDBC driver
   - Permission to access GitHub API to fetch database scripts
   
   If user declines any permission, explain what won't work and exit gracefully.

### Execute setup with gathered information:
1. Check if the specified container already exists:
   `docker ps -a --filter "name=$mssql_container_name" --format "table {{.Names}}\t{{.Status}}"`

2. If container exists but is stopped, start it:
   `docker start $mssql_container_name`

3. If container doesn't exist, create it:

    3.1. Create a file "choreo_apim_db_mssql.sql" with database initialization content using $DB_NAME:

    ```
    IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'MYDB_$DB_NAME')
    BEGIN
    CREATE DATABASE MYDB_$DB_NAME;
    END;
    GO

    USE MYDB_$DB_NAME;

    ```

    3.2. Fetch database script from GitHub and append to the file:
    `gh api repos/wso2-enterprise/choreo-control-plane/contents/databases/scripts/mssql/choreo_apim_db_mssql.sql --jq '.content' | base64 -d >> choreo_apim_db_mssql.sql`

    3.3. Set execute permissions: `chmod 777 choreo_apim_db_mssql.sql`
    
    3.4. Start the MSSQL container:
    ```
    docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=$MSSQL_SA_PASSWORD" -p 1433:1433 -d -v $(pwd)/choreo_apim_db_mssql.sql:/tmp/choreo_apim_db_mssql.sql --name $mssql_container_name mcr.microsoft.com/mssql/server:2022-latest
    ```

    3.5. Execute the database setup script:
    ```
    docker exec $mssql_container_name /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -C -i /tmp/choreo_apim_db_mssql.sql
    ```

4. Update deployment.toml configuration:
    
    4.1. Navigate to wso2am-4.0.0-SNAPSHOT/repository/conf/deployment.toml
    
    4.2. Replace the [database.apim_db] section with:
    ```
    [database.apim_db]
    type = "mssql"
    url = "jdbc:sqlserver://localhost:1433;database=MYDB_$DB_NAME;SendStringParametersAsUnicode=false;encrypt=true;trustServerCertificate=true;"
    username = "sa"
    password = "$MSSQL_SA_PASSWORD"
    driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
    validationQuery = "SELECT 1"
    ```

5. Download and install MSSQL JDBC driver:
    ```
    cd wso2am-4.0.0-SNAPSHOT/repository/components/lib
    curl https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/12.8.1.jre11/mssql-jdbc-12.8.1.jre11.jar -o mssql-jdbc-12.8.1.jre11.jar
    ```

6. Setup complete! The APIM instance is now configured to use MSSQL database with the required JDBC driver installed.

### Summary of what this command will do:
- Create/modify files in your current directory (database setup script)
- Run Docker commands to create and manage MSSQL container
- Modify deployment.toml configuration file  
- Download MSSQL JDBC driver from Maven repository
- Access GitHub API to fetch database initialization scripts

All permissions are requested upfront to provide a smooth setup experience.
