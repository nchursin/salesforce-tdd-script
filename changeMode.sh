WORKSPACE_FOLDER=$1
mode=$2

VSCODE_FOLDER="$WORKSPACE_FOLDER/.vscode"
DEV_ENV="$VSCODE_FOLDER/.devenv"

if [ ! -f $DEV_ENV ]; then
    touch $DEV_ENV
fi

sed -i.bak '/DEV_MODE/d' $DEV_ENV

echo "DEV_MODE=$mode" >> $DEV_ENV

echo "Dev mode is set to $mode"

rm -rf "$DEV_ENV".bak