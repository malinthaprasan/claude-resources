---
name: apim:setup-mongodb
description: Setup a local APIM instance (wso2am-4.0.0-SNAPSHOT) to use MongoDB Atlas by configuring deployment.toml.
---

# Setup a local APIM instance with MongoDB Atlas

## Steps

### Prerequisites:
1. Make sure user's $(pwd) contains an API Manager unzipped package under name "wso2am-4.0.0-SNAPSHOT". If its not there, ask to have it first and exit. Continue otherwise.

### Setup MongoDB Atlas configuration with APIM:

1. Navigate to wso2am-4.0.0-SNAPSHOT/repository/conf/deployment.toml

2. Ask user for database name, suggesting the current folder name appended to "APIM_DB" as default (e.g., "APIM_DB_$(basename $(pwd))"). If user provides a name, use it. Otherwise, use the suggested default. Store in variable $DB_NAME

3. Gather the Atlas credentials. **Do not hardcode any secret in this file.** For each value, read it from the corresponding environment variable if set; otherwise prompt the user (treat all as sensitive — do not echo them back): `$MONGO_DB_USER`, `$MONGO_DB_PASSWORD`, `$ATLAS_PUBLIC_KEY`, `$ATLAS_PRIVATE_KEY`.

4. Replace the [apim.persistence.properties] section with:
```
[apim.persistence.properties]
connection_string = "mongodb+srv://$MONGO_DB_USER:$MONGO_DB_PASSWORD@cluster0.jnh4o.mongodb.net/$DB_NAME?retryWrites=true&amp;w=majority"
api_uri = "https://cloud.mongodb.com/api/atlas/v1.0"
group_id = "5f8fd24d9bb9f22e87d560bd"
cluster_name = "Cluster0"
public_key = "$ATLAS_PUBLIC_KEY"
private_key = "$ATLAS_PRIVATE_KEY"
thread_count = 5
retry_count = 3
```

5. Setup is complete. The APIM instance is now configured to use MongoDB Atlas cloud database.
