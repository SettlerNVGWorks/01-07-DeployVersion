#!/bin/bash

# 🔧 Скрипт для освобождения порта 80 и исправления конфликта

echo "🔧 Исправляем конфликт порта 80..."

# Цвета для вывода
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Проверяем что использует порт 80
echo -e "${YELLOW}📊 Проверяем что использует порт 80...${NC}"
sudo netstat -tulpn | grep :80

# Останавливаем системный nginx если запущен
echo -e "${YELLOW}🛑 Останавливаем системный nginx...${NC}"
sudo systemctl stop nginx 2>/dev/null || echo "nginx не запущен или не установлен"
sudo systemctl disable nginx 2>/dev/null || echo "nginx не установлен"

# Останавливаем apache если запущен  
echo -e "${YELLOW}🛑 Останавливаем apache...${NC}"
sudo systemctl stop apache2 2>/dev/null || echo "apache2 не запущен"
sudo systemctl disable apache2 2>/dev/null || echo "apache2 не установлен"

# Убиваем все процессы на порту 80
echo -e "${YELLOW}⚡ Принудительно освобождаем порт 80...${NC}"
sudo fuser -k 80/tcp 2>/dev/null || echo "Порт 80 свободен"

# Ждем немного
sleep 2

# Проверяем что порт свободен
echo -e "${YELLOW}✅ Проверяем что порт 80 освобожден...${NC}"
if sudo netstat -tulpn | grep :80; then
    echo -e "${RED}❌ Порт 80 все еще занят!${NC}"
    echo -e "${YELLOW}Попробуйте перезагрузить сервер: sudo reboot${NC}"
else
    echo -e "${GREEN}✅ Порт 80 свободен!${NC}"
fi

# Останавливаем наши Docker контейнеры если они запущены
echo -e "${YELLOW}🐳 Останавливаем Docker контейнеры...${NC}"
docker-compose down 2>/dev/null || echo "Docker контейнеры не запущены"

# Запускаем заново
echo -e "${YELLOW}🚀 Запускаем проект заново...${NC}"
docker-compose up -d --build --force-recreate

echo -e "${GREEN}🎉 Готово! Проверьте статус:${NC}"
echo "docker-compose ps"