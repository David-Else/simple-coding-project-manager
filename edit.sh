#!/bin/bash

#=======================================================================================
#         FILE: edit.sh
#        USAGE: edit.sh
#  DESCRIPTION: Utility to allow selection of a project to edit with the option to
#               check/update the dependencies, run Rollup watch, and edit in VS Code.
#
#               Directory structure in PROJECT_FOLDER should have two levels:
#
#               ├── language-name
#               │   ├── project-name
#
#      WEBSITE: https://www.elsewebdevelopment.com/
# REQUIREMENTS: pnpm        https://github.com/pnpm/pnpm
#               rollup      https://www.npmjs.com/package/rollup
#               VS Code     https://code.visualstudio.com/
#       AUTHOR: David Else
#      COMPANY: Else Web Development
#      VERSION: 1.1
#     REVISION: 12-02-20
#=======================================================================================

PROJECT_FOLDER="$HOME/sites" # site that contains users projects to edit
BOLD=$(tput bold)            # bold text
NORMAL=$(tput sgr0)          # normal text

# Convert current directory names into a menu for selection
function create_menu_from_directory() {
    IFS=$'\n' read -d '' -ra files < <(ls -td -- */) # sorted names of dirs in ${files[@]}

    select f in "${files[@]}"; do
        [[ -n "$f" ]] && break # valid selection made, exit the menu
        echo ">>> Invalid Selection" >&2
    done
}

cd "$PROJECT_FOLDER" || exit

clear
echo "Which project would you like to edit in VS Code?"
echo
echo "${BOLD}$PROJECT_FOLDER${NORMAL}"
echo

create_menu_from_directory
cd "$f" || exit
create_menu_from_directory
cd "$f" || exit
echo "${BOLD}"
pwd
echo "${NORMAL}"

if [[ -f package.json ]]; then
    echo "${BOLD}'package.json' detected${NORMAL}"
    echo
    read -p "Check pnpm packages are up-to-date? (y/N) " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pnpm update --interactive
    fi
fi

if [[ -f ./node_modules/.bin/rollup ]]; then
    echo
    echo "${BOLD}Rollup detected locally${NORMAL}"
    echo
    read -p "Run Rollup in watch mode? (y/N) " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        code .
        ./node_modules/.bin/rollup -c --watch
        exit
    fi
fi

# GTK_IM_MODULE=ibus is workaround for Centos bug that stops some VS Code shortcuts working
GTK_IM_MODULE=ibus code .
