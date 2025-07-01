# 🎯 ФИНАЛЬНАЯ ИНСТРУКЦИЯ ДЛЯ РАЗВЕРТЫВАНИЯ

## 📥 Что вы получили

Полностью готовый к production проект для развертывания на сервере Aeza:

```
prognoz-sports/
├── 🐳 Docker конфигурация (docker-compose.yml)
├── 🔧 Backend настройки (Node.js + MongoDB)
├── 🌐 Frontend настройки (React + Nginx)
├── 🔒 SSL настройки (Let's Encrypt)
├── 📜 Автоматические скрипты развертывания
└── 📖 Полная документация
```

## 🚀 Как развернуть на Aeza

### ШАГ 1: Подготовка сервера
```bash
# Обновление системы
sudo apt update && sudo apt upgrade -y

# Установка необходимого ПО
sudo apt install -y curl wget git nginx ufw

# Настройка firewall
sudo ufw allow ssh && sudo ufw allow 80 && sudo ufw allow 443
sudo ufw --force enable
```

### ШАГ 2: Установка Docker
```bash
# Установка Docker
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER

# Установка Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# ⚠️ ВАЖНО: Перезайдите в систему после этого!
exit
# Войдите заново по SSH
```

### ШАГ 3: Настройка домена
В панели управления доменом **PrognozSports1.ru**:

1. **A-запись**: @ → **IP адрес вашего сервера Aeza**
2. **A-запись**: www → **IP адрес вашего сервера Aeza**
3. **TTL**: 300 секунд

### ШАГ 4: Развертывание
```bash
# Загрузка проекта на сервер
git clone <URL_ВАШЕГО_РЕПОЗИТОРИЯ> sport-predictions
cd sport-predictions

# Запуск развертывания одной командой
chmod +x *.sh
./deploy.sh
```

### ШАГ 5: Настройка SSL
```bash
# ⚠️ Дождитесь работы DNS (до 24 часов)
# Проверьте: ping prognozSports1.ru

# Настройка SSL сертификатов
./ssl-setup.sh
```

### ШАГ 6: Проверка
```bash
# Проверка всех интеграций
./test-integrations.sh

# Ваш сайт готов: https://prognozSports1.ru
```

## ✅ Что получите в результате

- 🌐 **Сайт доступен по HTTPS**: https://prognozSports1.ru
- 📧 **Email регистрация**: noreply@prognozSports1.ru  
- 🤖 **Telegram авторизация**: @ByWin52Bot
- ⚾ **Реальные спортивные данные**: MLB, NHL API
- 🔒 **SSL сертификат**: автообновление
- 📊 **Мониторинг**: логи и статистика

## 🔧 Полезные команды после развертывания

```bash
# Просмотр логов
docker-compose logs -f backend
docker-compose logs -f nginx

# Статус сервисов
docker-compose ps

# Перезапуск сервиса
docker-compose restart backend

# Обновление проекта
git pull && docker-compose up -d --build

# Остановка всего
docker-compose down
```

## 📞 В случае проблем

1. **Проверьте DNS**: `nslookup prognozSports1.ru`
2. **Проверьте логи**: `docker-compose logs backend`
3. **Проверьте health**: `curl https://prognozSports1.ru/api/health`

## 📋 Документация

- `DEPLOYMENT_GUIDE.md` - детальное руководство
- `DEPLOYMENT_CHECKLIST.md` - чек-лист развертывания
- `README.md` - обзор проекта

---

🎉 **Готово! Ваш сайт спортивных прогнозов запущен в интернете!**