#!/usr/bin/env bash
source $GIT_HOME_DIR/script_helpers/formatting


function tf_plan() {
    echo $TF_VAR_FILE	
    terraform init || die "Problem during Terraform Init"	
    terraform validate -var-file=$GIT_HOME_DIR/tfvars/$PROJECT.tfvars || die "Problem during Terraform Validate"
    terraform plan -var-file=$GIT_HOME_DIR/tfvars/$PROJECT.tfvars -detailed-exitcode -lock-timeout=$1 --out=terraform.tfplan
    TF_PLAN_RESULT=$?
    case $TF_PLAN_RESULT in
        0) # 0 = Succeeded with empty diff (no changes)
            info "Plan - Detected no changes, exiting"
            # Return condition to caller
            return 0
            ;;
        1) # 1 = Error
            die "Plan - Detected problems during terraform plan, exiting"
            ;;
        2) # 2 = Succeeded with non-empty diff (changes present)
            info "Terraform Plan - Detected changes required"
            # Return condition to caller
            return 1
            ;;
        *)
            die "Terraform Plan - Unknown exit code, exiting"
            ;;
    esac
}

function tf_apply() {
    terraform apply -lock-timeout=$1 --auto-approve terraform.tfplan; TF_APPLY_RESULT=$?
    if [ $TF_APPLY_RESULT -ne 0 ]; then
        die "Apply - Problem encountered during execution";
    fi
}


LOCK_TIMEOUT=300s
cd $GIT_HOME_DIR/$TF_EXECUTION_DIR || die "Cannot find execution directory $TF_EXECUTION_DIR"

# Get the current branch
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Terraform
case $CURRENT_BRANCH in
  develop)
    info "Develop Branch - Executing full terraform run"
    [[ $MODE == "infra-terraform" ]];
    tf_plan $LOCK_TIMEOUT || tf_apply $LOCK_TIMEOUT
    exit 0
    ;;
  *)
    info "Non-Master Branch - Executing terraform plan"
    [[ $MODE == "infra-terraform" ]];
    # Exit code will be either true or false; the exit clause ensures we always exit gracefully
    tf_plan $LOCK_TIMEOUT; exit 0
    ;;
esac
