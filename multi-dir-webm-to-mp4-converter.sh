#!/bin/bash

# Diretórios para monitorar
WATCH_DIRS=(
    "$HOME/Vídeos/Screencasts"
    "$HOME/Vídeos/Camera"
)
LOCK_FILE="/tmp/webm_to_mp4_converter.lock"

# Função para converter o arquivo .webm para .mp4
convert_to_mp4() {
    local input="$1"
    local output="${input%.webm}.mp4"

    echo "Iniciando conversão de $input..."
    if ffmpeg -i "$input" -c:v libx264 -preset ultrafast -crf 23 -c:a aac -b:a 128k "$output"; then
        echo "Conversão de $input concluída com sucesso!"
        rm "$input"
    else
        echo "Erro ao converter $input. Mantendo o arquivo original."
    fi
}

# Função para processar arquivos existentes em um diretório
process_existing_files() {
    local dir="$1"
    find "$dir" -name "*.webm" -print0 | while IFS= read -r -d '' file; do
        convert_to_mp4 "$file"
    done
}

# Função principal
main() {
    # Verifica se o script já está em execução
    if ! mkdir "$LOCK_FILE" 2>/dev/null; then
        echo "O conversor de .webm para .mp4 já está em execução."
        exit 1
    fi

    # Garante que o lock file será removido ao sair
    trap 'rm -rf "$LOCK_FILE"' EXIT

    # Processa arquivos existentes em todos os diretórios
    for dir in "${WATCH_DIRS[@]}"; do
        process_existing_files "$dir"
    done

    # Monitora todos os diretórios para novos arquivos .webm
    inotifywait -m -e close_write --format "%w%f" "${WATCH_DIRS[@]}" | while read -r filepath; do
        if [[ "$filepath" == *.webm ]]; then
            convert_to_mp4 "$filepath"
        fi
    done
}

# Inicia o script
main

