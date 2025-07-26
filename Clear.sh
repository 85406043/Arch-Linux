#!/bin/bash

# Script de Limpeza Completa para Arch Linux
# Autor: ChatGPT para Felipe

echo "🔧 Iniciando limpeza geral do sistema Arch Linux..."

# Verificar se está rodando como root
if [[ $EUID -ne 0 ]]; then
  echo "⚠️ Este script deve ser executado como root (use sudo)"
  exit 1
fi

# 1. Instalar pacman-contrib se necessário
if ! command -v paccache &> /dev/null; then
  echo "📦 Instalando pacman-contrib (para usar paccache)..."
  pacman -S --noconfirm pacman-contrib
fi

# 2. Limpar cache do pacman (deixa apenas os pacotes instalados)
echo "🧹 Limpando cache do pacman..."
paccache -rk0

# 3. Remover pacotes órfãos
echo "🗑️ Removendo pacotes órfãos (não utilizados)..."
pacman -Rns $(pacman -Qdtq) 2>/dev/null || echo "✅ Nenhum órfão encontrado."

# 4. Limpar logs antigos
echo "🧾 Limpando logs antigos do systemd..."
journalctl --vacuum-time=7d

# 5. Limpar cache do usuário e do sistema
echo "🧽 Limpando cache do sistema e usuário..."
rm -rf /tmp/*
rm -rf ~/.cache/*

# 6. Limpar cache do AUR com yay, se instalado
if command -v yay &> /dev/null; then
  echo "🧼 Limpando cache do yay (AUR)..."
  yay -Scc --noconfirm
elif command -v paru &> /dev/null; then
  echo "🧼 Limpando cache do paru (AUR)..."
  paru -Scc --noconfirm
else
  echo "ℹ️ Nenhum AUR helper (yay/paru) detectado. Pulando esta etapa."
fi

echo "✅ Limpeza concluída com sucesso!"

