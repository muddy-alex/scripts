function find_tasks {
  api_token=$1
  workspace_id=$2
  query=$3

  curl -k -sf -X GET "https://app.asana.com/api/1.0/workspaces/$workspace_id/tasks/search$query" \
    -H 'Accept: application/json' \
    -H "Authorization: Bearer $api_token" | jq '.data'
}

function find_task_gid_by_text {
  workspace_id=$1
  text=$2
  api_token=$3

  curl -k -sf -X GET "https://app.asana.com/api/1.0/workspaces/$workspace_id/tasks/search?text=$text" \
    -H 'Accept: application/json' \
    -H "Authorization: Bearer $api_token" | jq -r '.data[0].gid'
}

function find_tasks_for_user_and_section {
  workspace_id=$1
  user=$2
  section=$3
  api_token=$4

  curl -k -sf -X GET "https://app.asana.com/api/1.0/workspaces/$workspace_id/tasks/search?assignee.any=$user&sections.any=$section" \
    -H 'Accept: application/json' \
    -H "Authorization: Bearer $api_token" | jq '.data'
}


function find_complete_tasks_for_user_and_date {
  workspace_id=$1
  user=$2
  date=$3
  api_token=$4

  curl -k -sf -X GET "https://app.asana.com/api/1.0/workspaces/$workspace_id/tasks/search?assignee.any=$user&completed_on=$date" \
    -H 'Accept: application/json' \
    -H "Authorization: Bearer $api_token" | jq '.data'
}


function get_task_by_gid {
  task_gid=$1
  api_token=$2

  curl -k -sf -X GET "https://app.asana.com/api/1.0/tasks/$task_gid" \
    -H 'Accept: application/json' \
    -H "Authorization: Bearer $api_token" | jq '.data'
}
