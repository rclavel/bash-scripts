if [ -z $1 ]; then
  echo "Usage: checkout branch-name [-f]"
  echo "Options:"
  echo "   -f Perform a git-fetch before checkout branch-name"

  return
fi

if [ -z "$DEV_ROOT_PATH" ]; then
    echo "Error: DEV_ROOT_PATH env var is not set"

    return
fi

PREFIX="\033[1m\033[34m"
SUFFIX="\033[39m\033[0m"

function log {
  echo -e "$PREFIX+ $1$SUFFIX"
}

cd $DEV_ROOT_PATH

if [ "$2" = "-f" ]; then
  log "git fetch"
  git fetch
fi

if [ "$(git status -s)" = " M db/structure.sql" ]; then
  log "git checkout db/structure.sql"
  git checkout db/structure.sql
fi

log "git status"
git status

if [ -n "$(git status -s)" ]; then
  read -p "These files will be wiped. Continue? > (yN)" choice
  if [ "$choice" != "y" ]; then
      log "Chose no. Do nothing."
      return
  fi

  log "git add ."
  git add .

  log "git commit -nm 'wip'"
  git commit -nm 'wip'
fi

log "git checkout $1"
git checkout $1

log "git pull --rebase"
git pull --rebase

if [ "$(git log -n 1 --pretty=format:%s)" = "wip" ]
then
  log "git reset HEAD~1"
  git reset HEAD~1
fi

log "git status"
git status

log "bundle install > /tmp/bundle-install.log"
bundle install > /tmp/bundle-install.log

log "bundle exec rake db:migrate"
bundle exec rake db:migrate

log "RAILS_ENV=test bundle exec rake db:migrate"
RAILS_ENV=test bundle exec rake db:migrate
