#!/bin/bash

PROJECT_NAME="$1"
REPORT_DIR="reports"
OUTPUT_FILE="$REPORT_DIR/result.txt"

check_project_name() {
  if [ -z "$PROJECT_NAME" ]; then
    read -p "Введите имя проекта: " PROJECT_NAME
  fi

  if [ -z "$PROJECT_NAME" ]; then
    echo "Имя проекта не указано"
    exit 1
  fi
}

create_structure() {
  mkdir -p "$REPORT_DIR"

  for folder in src docs data; do
    mkdir -p "$PROJECT_NAME/$folder"
  done

  touch "$PROJECT_NAME/src/main.sh"
  echo "Проект $PROJECT_NAME" > "$PROJECT_NAME/README.md"
}

check_result() {
  for folder in src docs data; do
    if [ -d "$PROJECT_NAME/$folder" ]; then
      echo "Папка $folder: создана" >> "$OUTPUT_FILE"
    else
      echo "Папка $folder: отсутствует" >> "$OUTPUT_FILE"
    fi
  done
}

write_report() {
  echo "Проект: $PROJECT_NAME" > "$OUTPUT_FILE"
  echo "Дата: $(date)" >> "$OUTPUT_FILE"
  check_result
  echo "Файлы проекта:" >> "$OUTPUT_FILE"
  find "$PROJECT_NAME" -type f >> "$OUTPUT_FILE"
  echo "Всего файлов: $(find "$PROJECT_NAME" -type f | wc -l)" >> "$OUTPUT_FILE"
}

show_report() {
  cat "$OUTPUT_FILE"
}

check_project_name
create_structure
write_report
show_report
