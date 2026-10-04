#!/bin/bash

# Настройки: имя проекта из первого аргумента, папка и файл отчёта
PROJECT_NAME="$1"
REPORT_DIR="reports"
OUTPUT_FILE="$REPORT_DIR/result.txt"

# Спрашивает имя проекта, если оно не передано; при пустом имени завершает скрипт
check_project_name() {
  if [ -z "$PROJECT_NAME" ]; then
    read -p "Введите имя проекта: " PROJECT_NAME
  fi

  if [ -z "$PROJECT_NAME" ]; then
    echo "Имя проекта не указано"
    exit 1
  fi
}

# Создаёт папку отчёта, папку проекта с подпапками и файлы
create_structure() {
  mkdir -p "$REPORT_DIR"

  for folder in src docs data; do
    mkdir -p "$PROJECT_NAME/$folder"
  done

  touch "$PROJECT_NAME/src/main.sh"
  echo "Проект $PROJECT_NAME" > "$PROJECT_NAME/README.md"
}

# Проверяет, что каждая подпапка создана, и дописывает результат в отчёт
check_result() {
  for folder in src docs data; do
    if [ -d "$PROJECT_NAME/$folder" ]; then
      echo "Папка $folder: создана" >> "$OUTPUT_FILE"
    else
      echo "Папка $folder: отсутствует" >> "$OUTPUT_FILE"
    fi
  done
}

# Записывает отчёт: проект, дата, проверка папок, список и количество файлов
write_report() {
  echo "Проект: $PROJECT_NAME" > "$OUTPUT_FILE"
  echo "Дата: $(date)" >> "$OUTPUT_FILE"
  check_result
  echo "Файлы проекта:" >> "$OUTPUT_FILE"
  find "$PROJECT_NAME" -type f >> "$OUTPUT_FILE"
  echo "Всего файлов: $(find "$PROJECT_NAME" -type f | wc -l)" >> "$OUTPUT_FILE"
}

# Показывает готовый отчёт в терминале
show_report() {
  cat "$OUTPUT_FILE"
}

check_project_name
create_structure
write_report
show_report
