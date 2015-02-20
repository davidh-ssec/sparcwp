#!/usr/bin/env bash
# Usage: ./update_repos.sh /var/www/html
# Description: Update a clone of this repository from a development or updated WordPress installation.
# Should only update desired plugins and will ignore any git submodules (such as sparc-theme)

if [ $# -ne 1 ]; then
    echo "Usage: ./update_repos.sh <root wordpress directory>"
    exit 1
fi

ROOT_DIR="$1"
PLUGIN_SUBDIR="wp-content/plugins/"

# bash magic to get current script directory
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
SCRIPT_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

#echo $ROOT_DIR
#echo $PLUGIN_SUBDIR
#echo $SCRIPT_DIR
#exit 1

# Update plugins by removing the current version and copying the version in the web root
echo "Updating plugins from the web root to the current repository..."
for plugin_dir in "${PLUGIN_SUBDIR}/active-directory-integration" \
"${PLUGIN_SUBDIR}/advanced-custom-fields" \
"${PLUGIN_SUBDIR}/posts-to-posts" \
"${PLUGIN_SUBDIR}/raw-html" \
"${PLUGIN_SUBDIR}/timber-library"; do
    INSTALLED_DIR="$ROOT_DIR/$plugin_dir"
    REPOS_DIR="$SCRIPT_DIR/$plugin_dir"
    if [ ! -d "$INSTALLED_DIR" ]; then
        echo "WARNING: Plugin directory does not exist in web root: $INSTALLED_DIR"
        continue
    fi
    if [ ! -d "$REPOS_DIR" ]; then
        echo "WARNING: Plugin directory does not exist in repository: $REPOS_DIR"
    fi

    # Remove current directory
    #rm -r $REPOS_DIR || (echo "Could not remove plugin in repository"; exit 1)
    # Copy from web install to repository
    #cp -r $INSTALLED_DIR $REPOS_DIR || (echo "Could not copy plugin to repository"; exit 1)

    rsync -aqv --delete-after --exclude=.git $INSTALLED_DIR $SCRIPT_DIR/wp-content/plugins/
done

echo "Updating 'must use' plugins..."
#rm -r $SCRIPT_DIR/wp-content/mu-plugins
#cp -r $ROOT_DIR/wp-content/mu-plugins $SCRIPT_DIR/wp-content/
rsync -aqv --delete-after --exclude=.git $ROOT_DIR/wp-content/mu-plugins $SCRIPT_DIR/wp-content/

echo "Updating sparc-theme..."
rsync -aqv --delete-after --exclude=.git $ROOT_DIR/wp-content/themes $SCRIPT_DIR/wp-content/

