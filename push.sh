WORKSPACE_FOLDER=$1

VSCODE_FOLDER=$WORKSPACE_FOLDER/.vscode
DEV_ENV=$VSCODE_FOLDER/.devenv

if [ -f $DEV_ENV ]; then
    source $DEV_ENV
else
    DEV_MODE='normal'
fi

echo "Dev mode: $DEV_MODE"

if [[ 'tcr' = $DEV_MODE ]]; then
    git add -u
fi

sfdx force:source:status
sfdx force:source:push
rc=$?
if [[ $rc != 0 ]]; then
    if [[ 'tcr' = $DEV_MODE ]]; then
        echo "Push failed - reverting"
        git reset --hard
    fi
    exit $rc;
fi

if [[ 'tdd' = $DEV_MODE ]] || [[ 'tcr' = $DEV_MODE ]]; then
    sfdx force:apex:test:run \
        -t Test_MockServer \
        --codecoverage \
        --resultformat human \
        --outputdir "$WORKSPACE_FOLDER/.sfdx/tools/testresults/apex" \
        --loglevel error
    rc=$?

    if [[ 'tcr' = $DEV_MODE ]]; then
        if [[ $rc != 0 ]]; then
            echo "Tests failed - reverting"
            git reset --hard
            exit $rc;
        fi
        echo "Tests passed - committing"
        git commit -m '>>> TCR wip'
    fi
fi