#!/bin/bash

# Advanced Log Report Generator

# CONFIG
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
REPORT_TXT="report_$TIMESTAMP.txt"
REPORT_CSV="report_$TIMESTAMP.csv"
KEYWORDS=()
LOG_DIR=""
START_TIME=$(date +%s.%N)
COLOR_ON=false
RECURSIVE=false

print_help() {
    echo "Usage: $0 <log_directory> [--keywords KEY1 KEY2 ...] [--recursive] [--color] [--help]"
    echo ""
    echo "Options:"
    echo "  --keywords    List of keywords to search for (for example, ERROR WARNING CRITICAL)"
    echo "  --recursive   Recursively scan all subdirectories"
    echo "  --color       Enable colored terminal output"
    echo "  --help        Display this help message"
    exit 0
}

show_spinner() {
    local filename="$1"
    local spinstr='|/-\\'
    local delay=0.1

    for i in {1..10}; do
        printf "\r[%c] Scanning: %s" "${spinstr:i%4:1}" "$filename" >&1
        sleep $delay
    done
    printf "\r[V] Scanning: %s\n" "$filename"
}

parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --keywords)
                shift
                while [[ $# -gt 0 && ! "$1" =~ ^-- ]]; do
                    KEYWORDS+=("$1")
                    shift
                done
                ;;
            --recursive)
                RECURSIVE=true
                shift
                ;;
            --color)
                COLOR_ON=true
                shift
                ;;
            --help)
                print_help
                ;;
            -*)
                echo "Unknown flag: $1"
                exit 1
                ;;
            *)
                LOG_DIR="$1"
                shift
                ;;
        esac
    done
}

validate_input() {
    if [[ -z "$LOG_DIR" ]]; then
        echo "Error: Log directory not provided."
        exit 1
    fi
    if [[ ! -d "$LOG_DIR" ]]; then
        echo "Error: '$LOG_DIR' is not a valid directory."
        exit 1
    fi
    if [[ ${#KEYWORDS[@]} -eq 0 ]]; then
        echo "Error: No keywords specified."
        exit 1
    fi
}

print_header() {
    local filename
    filename=$(basename "$1")

    echo "Log File: $filename" | tee -a "$REPORT_TXT"
    echo "| Keyword     | Occurrences |" | tee -a "$REPORT_TXT"
    echo "|-------------|-------------|" | tee -a "$REPORT_TXT"

    echo "Log File: $filename" >> "$REPORT_CSV"
    echo "Keyword,Occurrences" >> "$REPORT_CSV"
}

print_line() {
    local keyword=$1
    local count=$2

    if $COLOR_ON; then
        printf "| \e[1;33m%-11s\e[0m | \e[1;36m%-11s\e[0m |\n" "$keyword" "$count" | tee -a "$REPORT_TXT"
    else
        printf "| %-11s | %-11s |\n" "$keyword" "$count" | tee -a "$REPORT_TXT"
    fi

    echo "$keyword,$count" >> "$REPORT_CSV"
}

generate_report() {
    echo "" > "$REPORT_TXT"
    echo "" > "$REPORT_CSV"

    if $RECURSIVE; then
        find "$LOG_DIR" -type f -name '*.log'
    else
        find "$LOG_DIR" -maxdepth 1 -type f -name '*.log'
    fi | while IFS= read -r file; do
        filename=$(basename "$file")
        show_spinner "$filename"
        print_header "$file"
        for keyword in "${KEYWORDS[@]}"; do
            count=$(grep -o "$keyword" "$file" 2>/dev/null | wc -l)
            print_line "$keyword" "$count"
        done
        echo ""
        echo "" >> "$REPORT_TXT"
        echo "" >> "$REPORT_CSV"
    done
}

print_execution_time() {
    END_TIME=$(date +%s.%N)
    DURATION=$(echo "$END_TIME - $START_TIME" | bc)
    echo "Total Execution Time: ${DURATION} seconds" | tee -a "$REPORT_TXT"
}

main() {
    parse_args "$@"
    validate_input
    generate_report
    print_execution_time
}

main "$@"