CWD=$(dirname "$0")

. "$CWD/helpers/log.sh"

function get_branch_name {
    branch_name="$(git symbolic-ref HEAD 2>/dev/null)" ||
    branch_name="(unnamed branch)"     # detached HEAD
    branch_name=${branch_name##refs/heads/}
    echo "$branch_name"
}

function get_branch_exists {
  branch_name=$1

  branch_exists=$(git branch --list "$branch_name")

  echo "$branch_exists"
}

function get_branch_unchanged {
  branch_name=$1

  branch_exists=$(git branch --list "$branch_name")

  echo "$branch_exists"
}

function get_is_main {
  exit_if_not_git

  branch=$(get_branch_name)

  if [[ "$branch" == "main" ]]
  then
    echo "1"
  fi
}

function exit_if_not_git {
  if ! git rev-parse --is-inside-work-tree &> /dev/null
  then
      error "Not a git repo"
      exit 1
  fi
}

function exit_if_not_main {
  exit_if_not_git

  branch=$(get_branch_name)

  if [[ "$branch" != "main" ]]
  then
      error "Not on main branch"
      exit 1
  fi
}

exit_if_not_clean_work_tree () {
  git update-index -q --ignore-submodules --refresh
  err=0

  if ! git diff-files --quiet --ignore-submodules --
  then
    error "You have unstaged changes."
    git diff-files --name-status -r --ignore-submodules -- >&2
    err=1
  fi

  # Disallow uncommitted changes in the index
  if ! git diff-index --cached --quiet HEAD --ignore-submodules --
  then
      error "Your index contains uncommitted changes"
      git diff-index --cached --name-status -r --ignore-submodules HEAD -- >&2
      err=1
  fi

  if [ $err = 1 ]
  then
      exit 1
  fi
}


