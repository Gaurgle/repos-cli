#!/usr/bin/env bash
# Prints mock output for screenshots. Run in your terminal, then screenshot.
# Usage: ./demo.sh [1|2|3]  (default: all three)

# Catppuccin Mocha palette (printf for bash 3.2 compat)
PEACH=$(printf '\033[38;2;250;179;135m')
GREEN=$(printf '\033[38;2;166;227;161m')
YELLOW=$(printf '\033[38;2;249;226;175m')
SAPPHIRE=$(printf '\033[38;2;116;199;236m')
LAVENDER=$(printf '\033[38;2;180;190;254m')
MAUVE=$(printf '\033[38;2;203;166;247m')
OVERLAY=$(printf '\033[38;2;127;132;156m')
SURFACE=$(printf '\033[38;2;69;71;90m')
BOLD=$(printf '\033[1m')
RESET=$(printf '\033[0m')

DIV_W=58
DIV="${SURFACE}$(printf '%*s' "$DIV_W" '' | tr ' ' '─')${RESET}"
W=$(( DIV_W - 4 ))

section_div() {
    local label="$1"
    local prefix="── ${label} "
    local remain=$(( DIV_W - ${#prefix} ))
    printf '  %s── %s%s %s%s%s\n' \
        "$SURFACE" "$MAUVE" "$label" "$SURFACE" "$(printf '%*s' "$remain" '' | tr ' ' '─')" "$RESET"
}

row() {
    local name="$1" status="$2" color="$3" bold="$4"
    local pad=$(( W - ${#name} - ${#status} ))
    (( pad < 3 )) && pad=3
    local dots=$(printf '%*s' "$pad" '' | tr ' ' '·')
    if [ "$bold" = "1" ]; then
        printf "    ${SAPPHIRE}${BOLD}%s${RESET} ${SURFACE}%s${RESET} %s%s${RESET}\n" "$name" "$dots" "$color" "$status"
    else
        printf "    ${SAPPHIRE}%s${RESET} ${SURFACE}%s${RESET} %s%s${RESET}\n" "$name" "$dots" "$color" "$status"
    fi
}

path() { echo "      ${OVERLAY}$1${RESET}"; }
commit() { echo "      ${OVERLAY}$1${RESET} $2"; }

demo1() {
    echo ""
    echo "  ${LAVENDER}${BOLD}repoz${RESET} ${OVERLAY}— latest active slot: 2025-06-12  Evening (18-00)${RESET}"
    echo "  ${DIV}"
    echo ""

    row "frontend-app" "2 behind" "$PEACH" "1"
    path "~/repos/acme/frontend-app"
    commit "a1b2c3d" "feat: add dark mode toggle"
    commit "e4f5g6h" "fix: navbar responsive breakpoint"

    row "backend-api" "synced" "$GREEN" "0"
    path "~/repos/acme/backend-api"
    echo "      ${OVERLAY}d7e8f9a refactor: extract auth middleware${RESET}"

    row "mobile-app" "1 ahead" "$PEACH" "1"
    path "~/repos/acme/mobile-app"
    commit "b2c3d4e" "feat: push notification support"

    echo ""
    section_div "also active"
    echo ""

    row "docs" "1 behind" "$PEACH" "1"
    path "~/work/docs"
    commit "c5d6e7f" "docs: update API reference"

    echo ""
    section_div "local changes"
    echo ""

    row "infra" "2 uncommitted" "$YELLOW" "1"
    path "~/repos/acme/infra"

    echo ""
    echo "  ${DIV}"
    echo "  ${PEACH}2 behind${RESET} ${SURFACE}·${RESET} ${PEACH}1 ahead${RESET} ${SURFACE}·${RESET} ${YELLOW}1 uncommitted${RESET} ${SURFACE}·${RESET} ${GREEN}1 synced${RESET}"
    echo ""
}

demo2() {
    echo ""
    echo "  ${LAVENDER}${BOLD}repoz${RESET} ${OVERLAY}— latest active slot: 2025-06-13  Work (09-18)${RESET}"
    echo "  ${DIV}"
    echo ""

    row "webapp" "synced" "$GREEN" "0"
    path "~/repos/webapp"
    echo "      ${OVERLAY}f8a9b0c feat: add user preferences page${RESET}"

    row "cli-tool" "synced" "$GREEN" "0"
    path "~/repos/cli-tool"
    echo "      ${OVERLAY}a3b4c5d fix: handle empty config file${RESET}"

    echo ""
    echo "  ${DIV}"
    echo "  ${GREEN}2 synced${RESET}"
    echo ""
}

demo3() {
    echo ""
    echo "  ${LAVENDER}${BOLD}repoz${RESET} ${OVERLAY}— since 2025-06-01${RESET}"
    echo "  ${DIV}"
    echo ""

    row "webapp" "synced" "$GREEN" "0"
    path "~/repos/webapp"
    echo "      ${OVERLAY}f8a9b0c feat: add user preferences page${RESET}"

    row "cli-tool" "3 behind" "$PEACH" "1"
    path "~/repos/cli-tool"
    commit "d1e2f3a" "feat: streaming output"
    commit "b4c5d6e" "refactor: plugin system"
    commit "a7b8c9d" "fix: windows path handling"

    row "design-system" "1 ahead" "$PEACH" "1"
    path "~/repos/design-system"
    commit "e0f1a2b" "feat: new color tokens"

    echo ""
    echo "  ${DIV}"
    echo "  ${PEACH}1 behind${RESET} ${SURFACE}·${RESET} ${PEACH}1 ahead${RESET} ${SURFACE}·${RESET} ${GREEN}1 synced${RESET}"
    echo ""
}

case "${1:-all}" in
    1) demo1 ;;
    2) demo2 ;;
    3) demo3 ;;
    all) demo1; demo2; demo3 ;;
esac
