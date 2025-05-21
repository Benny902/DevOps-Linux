#!/bin/bash

# Remote Wrapper for Local Log Analyzer

# CONFIG
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
TMP_DIR="./tmp_logs_$TIMESTAMP"
START_TIME=$(date +%s.%N)

print_help() {
    echo "Usage: $0 <remote_user@host> <remote_log_dir> --keywords KEY1 [KEY2 ...] [--recursive] [--color]"
    echo ""
    echo "Positional arguments:"
    echo "  <remote_user@host>       Remote SSH login"
    echo "  <remote_log_dir>         Remote directory containing logs"
    echo ""
    echo "Options (passed to advanced_log_report.sh):"
    echo "  --keywords KEY1 [...]    Required keywords to search for"
    echo "  --recursive              Recursively scan subdirectories"
    echo "  --color                  Enable colored output"
    echo "  --help                   Show this help message"
    exit 1
}

if [[ "$#" -lt 3 || "$1" == "--help" ]]; then
    print_help
fi

if ! printf '%s\n' "$@" | grep -q -- "--keywords"; then
    echo "Error: Missing required --keywords argument."
    print_help
fi

REMOTE_HOST="$1"
REMOTE_DIR="$2"
shift 2
PASSTHRU_ARGS=("$@")

download_logs() {
    mkdir -p "$TMP_DIR"
    echo "[*] Downloading logs and archives..."
    ssh "$REMOTE_HOST" "find \"$REMOTE_DIR\" -type f \\( -iname '*.log' -o -iname '*.zip' -o -iname '*.tar' -o -iname '*.tar.gz' \\)" > /tmp/remote_log_list.txt
    while IFS= read -r remote_file; do
        echo "[Downloading] $remote_file"
        rsync -avz --protect-args "$REMOTE_HOST:$remote_file" "$TMP_DIR/" 2>/dev/null || \
        scp -q "$REMOTE_HOST:\"$remote_file\"" "$TMP_DIR/"
    done < /tmp/remote_log_list.txt
}

extract_archives() {
    echo "[*] Extracting archives..."
    find "$TMP_DIR" -type f \( -iname "*.zip" -o -iname "*.tar" -o -iname "*.tar.gz" \) | while read -r archive; do
        case "$archive" in
            *.zip) unzip -q "$archive" -d "$TMP_DIR" ;;
            *.tar) tar -xf "$archive" -C "$TMP_DIR" ;;
            *.tar.gz) tar -xzf "$archive" -C "$TMP_DIR" ;;
        esac
    done
}

run_local_analyzer() {
    echo "[*] Running local analyzer..."
    chmod +x ./advanced_log_report.sh
    ./advanced_log_report.sh "$TMP_DIR" "${PASSTHRU_ARGS[@]}"
}

main() {
    download_logs
    extract_archives
    run_local_analyzer
}

main
