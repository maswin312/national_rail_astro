from cosmos.config import ProjectConfig, ProfileConfig
from cosmos.profiles import GoogleCloudServiceAccountDictProfileMapping, GoogleCloudServiceAccountFileProfileMapping


project_config = ProjectConfig(
    dbt_project_path="/usr/local/airflow/dbt",
)

google_config = GoogleCloudServiceAccountFileProfileMapping(
    conn_id="gcp_conn",
    profile_args={
        "dataset": "national_rail_data",
        "location": "asia-southeast2", # Update if you're using a different location for your dataset
        "threads": 1,
        "retries": 1,
        "priority": "interactive",
    }
)

profile_config = ProfileConfig(
    profile_name="national_rail",
    target_name="dev",
    profile_mapping=google_config
)