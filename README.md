# bash-scripts

## checkout.sh

It:

- cd you into your dev directory
- reset db/structure.sql file if this file is the only one modified (Rails purposes)
- show status
- ask you to confirm: **y** to continue, **n** or anything to abort
- commit all changes with **docto-wip** as message
- checkout new branch
- pull with rebase
- reset last commit if its name is **docto-wip**
- show status
- execute bundle install (Rails purposes)
- execute db:migrate (Rails purposes)

**Install**

Create configuration and alias in **~/.bashrc**:

    export DEV_ROOT_PATH=~/dev/my-dev-directory
    export BASH_SCRIPTS_PATH=~/dev/bash-scripts
    source "${BASH_SCRIPTS_PATH}/bash-scripts.sh"

Reload bash configuration:

    source ~/.bashrc

Use it:

    # checkout to a local branch
    checkout BRANCH_NAME

    # checkout to a remote branch
    checkout BRANCH_NAME -f
