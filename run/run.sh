#!/bin/bash

source ./pantheon/env.sh

# update the submit script
if [ -d $PANTHEON_RUN_DIR ]; then
    echo "------------------------------------------------------------"
    echo "PTN: $PANTHEON_RUN_DIR exists ... exiting"
    echo "------------------------------------------------------------"
    exit
fi

mkdir $PANTHEON_RUN_DIR

# --------------------------------------------------------------------
# BEGIN: EDIT THIS SECTION
# copy executable and support files to the result directory
#     this step will vary, depending on the application requirements

cp app.executable $PANTHEON_RUN_DIR/renamed.executable
cp run/submit.sh $PANTHEON_RUN_DIR

# END: EDIT THIS SECTION
# --------------------------------------------------------------------

# go to run dir and update the submit script
pushd $PANTHEON_RUN_DIR
sed -i "s/<pantheon_workflow_jid>/${PANTHEON_WORKFLOW_JID}/" submit.sh
sed -i "s#<pantheon_workflow_dir>#${PANTHEON_WORKFLOW_DIR}#" submit.sh
sed -i "s#<pantheon_run_dir>#${PANTHEON_RUN_DIR}#" submit.sh
sed -i "s#<compute_allocation>#${COMPUTE_ALLOCATION}#" submit.sh

# submit the job
bsub submit.sh
