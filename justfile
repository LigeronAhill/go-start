# https://just.systems

set shell := ["sh", "-c"]
set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

# Переменные
app_name := "app"
build_dir := "bin"
main_path := "cmd/app/main.go"

# Основные задачи

# Список команд
default:
    @just --list

# Запуск приложения
run:
    go run {{main_path}}

# Сборка приложения
build:
    mkdir -p {{build_dir}}
    go build -o {{build_dir}}/{{app_name}} {{main_path}}

# Запуск тестов
test:
    go test ./...

# Запуск тестов с подробным выводом
test-v:
    go test -v ./...

# Запуск тестов с детектором гонок
test-race:
    go test -race ./...

# Запуск бенчмарков
bench:
    go test -bench=. ./...

# Бенчмарки с профилированием
bench-mem:
    go test -bench=. -benchmem ./...

# Покрытие кода тестами
coverage:
    go test -coverprofile=coverage.out ./...
    go tool cover -html=coverage.out -o coverage.html
    @echo "Coverage report generated: coverage.html"

# Быстрая проверка покрытия
cover-func:
    go test -coverprofile=coverage.out ./...
    go tool cover -func=coverage.out

# Очистка
clean:
    rm -rf {{build_dir}}
    rm -f coverage.out coverage.html

# Запуск линтера
lint:
    go vet ./...
    go fmt ./...

# Установка зависимостей для разработки
dev-deps:
    go mod tidy
    go install github.com/air-verse/air@latest
    air init

# Запуск с hot-reload (air)
watch:
    air

# Полная проверка перед коммитом
pre-commit: lint test-race

# Показать помощь
help:
    @just --list
