UV_VENV_DIR=~/Dev/uv-venv

mkvirtualenv() {
  if [ -z "$1" ]; then
    echo "Usage: mkvirtualenv <env-name>"
    return 1
  fi
  mkdir -p "$UV_VENV_DIR"
  (cd "$UV_VENV_DIR" && uv venv "$@")
  workon "$1"
}

lsvirtualenv() {
  ls --color=never -1 "$UV_VENV_DIR"
}

workon() {
  export _UV_OLD_PATH="$PATH"
  source "$UV_VENV_DIR/$1/bin/activate"
  PATH="$PATH:$UV_VENV_DIR/$1/bin"
}


rmvirtualenv() {
  if [ -z "$1" ]; then
    echo "Usage: rmvirtualenv <env-name>"
    return 1
  fi
  rm -rf "$UV_VENV_DIR/$1"
}

_uv_venv_envs() {
  local envs
  envs=(${(f)"$(ls -1 $UV_VENV_DIR 2>/dev/null)"})
  compadd "$@" -- $envs
}

compdef _uv_venv_envs workon rmvirtualenv