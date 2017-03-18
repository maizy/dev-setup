function log {
    PURPLE='\033[1;35m'
    NC='\033[0m'
    echo -e "${PURPLE}$1${NC}"
}

function _clone {
    base_git_path="$1"
    repo="$2"
    name="$3"
    cwd=`pwd`
    if [ -z "$name" ];then
        [[ $repo =~ .*\/(.*) ]]
        name="${BASH_REMATCH[1]}"
    fi
    repo_path="$cwd/$name"
    git_path="${base_git_path}:${repo}.git"
    if [ ! -d "$repo_path" ]; then
        log "clone '$git_path' to '$repo_path'"
        git clone "$git_path" "$repo_path"
    else
        log "$git_path' found at '$repo_path', skipping"
    fi
}

function github_clone {
    _clone 'git@github.com' "$1" "$2"
}

function bitbucket_clone {
    _clone 'git@bitbucket.org' "$1" "$2"
}
