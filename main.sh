#!/bin/bash

# import add_post function from module
source /Users/dm/Dev/jekyll-website-assistant/module_add_post.sh


echo Hello, I will help you to manage your jekyll blog.
echo If you need some help, type help


# todo: добавить проверку существует ли конфиг, если нет, то сделать
# check if config.json file exists. If not, then create one
if [ -f config.json ]; then
    echo "Config file loaded."
else
    echo "You need to create config file first."
    # todo: создать файл
fi

# parse json with assistant configuration
# shellcheck disable=SC2002
root_website_directory=$(cat config.json | jq -r '.root_website_directory')
# shellcheck disable=SC2002
posts_path=$(cat config.json | jq -r '.posts_path')
# shellcheck disable=SC2002
blog_categories=$(cat config.json | jq -r '.categories')
images_path=$(cat config.json | jq -r '.images_path')

# check if root directory to website in config file exists
if [[ $root_website_directory == "" ]]
then
  echo "You need to fill config.json first. Press CTRL+C to exit."
  :
fi

# main logic. All commands here
while True
do
	printf '> '
	#  todo: replace user intput to read
  #  read -r user_input;
  user_input=add_post
  case $user_input in
    help)
      echo "---- help ----"
      echo - add_post to add new post.
      echo - edit in VIM last edited/created post.
      echo - edit in Pycharm last edited/created post.
      echo - remove_config to remove config.
      echo - open_blog to open blog in your default file explorer.
      echo - edit_post_template to edit current post template.
      echo - remove_post
      echo - show_all_posts [-10]
      echo - edit_config
      ;;
    add_post)

      # run add_post function from module with absolute path to _posts folder
      add_post "$root_website_directory$posts_path" "$blog_categories" "$images_path" "$root_website_directory"
      ;;
    edit_config)
      echo "edit_config"
      ;;
    *)
      echo "Unknown command"
      ;;
  esac
done





