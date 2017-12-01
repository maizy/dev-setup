#autoload

compctl -/ -W "$HOME/Dev" cdd

function cdd() {
    cd "$HOME/Dev/$1"
}
