#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Some Linux file managers launch .sh files without a visible terminal.
# Spawn a terminal when available so users can follow installation output.
run_in_terminal() {
    local arg
    local quoted_args=()
    for arg in "$@"; do
        quoted_args+=("$(printf '%q' "$arg")")
    done

    local script_cmd
    script_cmd="$(printf '%q' "$DIR/scripts/install.sh")"
    if [ ${#quoted_args[@]} -gt 0 ]; then
        script_cmd+=" ${quoted_args[*]}"
    fi

    local launcher
    launcher="$(mktemp "${TMPDIR:-/tmp}/gh-msync-install.XXXXXX")"
    cat > "$launcher" <<EOF
#!/bin/bash
$script_cmd
read -r -p 'Press [Enter] to close...'
rm -f -- "$launcher"
EOF
    chmod +x "$launcher"

    if command -v gnome-terminal >/dev/null 2>&1; then
        gnome-terminal -- bash "$launcher"
    elif command -v konsole >/dev/null 2>&1; then
        konsole -e bash "$launcher"
    elif command -v guake >/dev/null 2>&1; then
        guake -e "bash \"$launcher\""
    elif command -v terminator >/dev/null 2>&1; then
        terminator -e "bash \"$launcher\""
    elif command -v xterm >/dev/null 2>&1; then
        xterm -e bash "$launcher"
    else
        "$DIR/scripts/install.sh" "$@"
        rm -f -- "$launcher"
    fi
}

run_in_terminal "$@"
