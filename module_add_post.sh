#!/bin/bash

# parse json

add_post(){
  echo "What is the name of your post? [my-post-name]";
  read -r post_name;
  # replace spaces ' ' and dots to dashes ' '
  post_name_fixed=${post_name// /-}
  post_name_fixed=${post_name_fixed//. /-}
  post_name_fixed=${post_name_fixed//./-}
  post_name_fixed=${post_name_fixed//,/-}
  # lowercase first letter
  post_name_fixed="$(tr '[:upper:]' '[:lower:]' <<< ${post_name_fixed:0:1})${post_name_fixed:1}"

  # show post path
  echo "${1}${post_name_fixed}.md"

  echo "What is category? [number]"

  # show categories
  jq "to_entries|map(\"\(.key)) \(.value|tostring)\")|.[]" <<< "${2}"

  read input_category
  case $input_category in
    1) category="bash"
    ;;
    2) category="python"
    ;;
    3) category="database"
    ;;
  esac

  echo "Do you want to create the image folder? [y/n]";
  read input_create_category;
  if [[ $input_create_category -eq "y" ]]
  then
    mkdir "${4}${3}$post_name_fixed"
    echo "Image folder for post is created ${4}${3}$post_name_fixed"
  else
    echo "Directory is not created"
  fi

  # create post markdown file
  # todo: создать файл по пути
  cat "---
  layout: post
  title: '${post_name}'
  category: ${category}
  comments: True
  tags:
  ---" > "${1}${post_name_fixed}.md"
}

