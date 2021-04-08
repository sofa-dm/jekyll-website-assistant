# parse json with assistant configuration
root_website_directory=$(cat config.json | jq -r '.root_website_directory')
posts_path=$(cat config.json | jq -r '.posts_path')
blog_categoies=$(cat config.json | jq -r '.categories')

jq "to_entries|map(\"\(.key)) \(.value|tostring)\")|.[]" <<< "$blog_categoies"


