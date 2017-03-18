function log {
    PURPLE='\033[1;35m'
    NC='\033[0m'
    echo -e "${PURPLE}$1${NC}"
}

function github_clone {
    repo="$1"
    name="$2"
    cwd=`pwd`
    if [ -z "$name" ];then
        [[ $repo =~ .*\/(.*) ]]
        name="${BASH_REMATCH[1]}"
    fi
    repo_path="$cwd/$name"
    git_path="git@github.com:$repo"
    if [ ! -d "$repo_path" ]; then
        log "clone '$git_path' to '$repo_path'"
        git clone 'git@github.com:'"$repo" "$repo_path"
    else
        log "$git_path' found at '$repo_path', skipping"
    fi
}
