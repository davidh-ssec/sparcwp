#!/usr/bin/env bash
# Usage: ./update_web_root.sh /var/www/html
# Description: Update a installed wordpress site with the sparc-theme and sparc mu-plugins (this does not include installable plugins)

if [ $# -ne 1 ] && [ $# -ne 2 ]; then
    echo "Usage: ./update_web_root.sh <root wordpress directory> [web root owner]"
    exit 1
fi
if [ $# -eq 2 ]; then
    CMD_PREFIX="sudo -u $2 "
else
    CMD_PREFIX=""
fi

ROOT_DIR="$1"
WEB_OWNER="$2"
PLUGIN_SUBDIR="wp-content/plugins/"

# bash magic to get current script directory
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
SCRIPT_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

#echo $ROOT_DIR
#echo $PLUGIN_SUBDIR
#echo $SCRIPT_DIR
#exit 1

echo "Updating 'must use' plugins..."
#rm -r $SCRIPT_DIR/wp-content/mu-plugins
#cp -r $ROOT_DIR/wp-content/mu-plugins $SCRIPT_DIR/wp-content/
${CMD_PREFIX}rsync -aqv --delete-after --exclude=.git $SCRIPT_DIR/wp-content/mu-plugins $ROOT_DIR/wp-content/

echo "Updating sparc-theme..."
${CMD_PREFIX}rsync -aqv --delete-after --exclude=.git $SCRIPT_DIR/wp-content/themes/sparc-theme $ROOT_DIR/wp-content/themes/

