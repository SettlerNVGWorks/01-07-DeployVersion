# 🚀 Инструкции по запуску приложения локально

## 📋 Требования

- Node.js (версия 16 или выше)
- MongoDB (последняя версия)
- Yarn (рекомендуется) или NPM

## 🗄️ Установка MongoDB

### Windows:
1. Скачайте MongoDB Community Server с официального сайта: https://www.mongodb.com/try/download/community
2. Запустите установщик и следуйте инструкциям
3. Убедитесь что MongoDB запущен как сервис (обычно запускается автоматически)

### macOS:
```bash
# Установка через Homebrew
brew tap mongodb/brew
brew install mongodb-community
brew services start mongodb/brew/mongodb-community
```

### Linux (Ubuntu/Debian):
```bash
# Импорт GPG ключа
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -

# Добавление репозитория
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

# Установка MongoDB
sudo apt-get update
sudo apt-get install -y mongodb-org

# Запуск MongoDB
sudo systemctl start mongod
sudo systemctl enable mongod
```

## 🔍 Проверка установки MongoDB

Откройте терминал и выполните:
```bash
mongosh
```
Если MongoDB установлен правильно, вы увидите приглашение MongoDB shell.

## 🚀 Запуск приложения

### 1. Установка зависимостей Backend:
```bash
cd /app/backend
yarn install
# или npm install
```

### 2. Установка зависимостей Frontend:
```bash
cd /app/frontend
yarn install
# или npm install
```

### 3. Запуск Backend:
```bash
cd /app/backend
yarn start
# или npm start
```

Вы должны увидеть:
```
🚀 =================================
🚀 Server running on http://localhost:8001
📍 Environment: development
🔧 Frontend URL: http://localhost:3000
🗄️  Database: mongodb://localhost:27017/sport_predictions
📅 Матчи обновляются каждый день в 12:00 МСК
🚀 =================================
```

### 4. Запуск Frontend:
Откройте новый терминал:
```bash
cd /app/frontend
yarn start
# или npm start
```

Frontend запустится на http://localhost:3000

## 🔧 Проверка работоспособности

### Тест Backend API:
Откройте в браузере или используйте curl:

```bash
# Проверка здоровья сервера
curl http://localhost:8001/api/health

# Проверка статистики
curl http://localhost:8001/api/stats

# Проверка матчей
curl http://localhost:8001/api/matches/today
```

### Тест Frontend:
1. Откройте http://localhost:3000 в браузере
2. Проверьте что страница загружается без ошибок в консоли
3. Проверьте что секция "Матчи на сегодня" загружается

## 🐛 Решение проблем

### Если MongoDB не запускается:
```bash
# Проверка статуса
sudo systemctl status mongod

# Перезапуск
sudo systemctl restart mongod

# Проверка логов
sudo journalctl -u mongod
```

### Если Backend не подключается к MongoDB:
1. Убедитесь что MongoDB запущен: `mongosh`
2. Проверьте что порт 27017 не занят другим процессом
3. Проверьте логи backend сервера

### Если Frontend не может подключиться к Backend:
1. Убедитесь что Backend запущен на порту 8001
2. Проверьте что в браузере нет CORS ошибок
3. Откройте DevTools и проверьте Network вкладку

## 📱 Настройка для внешнего доступа (ngrok)

Если нужно предоставить доступ извне:

1. Установите ngrok: https://ngrok.com/
2. Запустите для backend:
```bash
ngrok http 8001
```
3. Обновите REACT_APP_BACKEND_URL в frontend/.env на ngrok URL
4. Перезапустите frontend

## 🔑 API Ключи

Все необходимые API ключи уже настроены в .env файле:
- ✅ The Odds API
- ✅ Football Data API  
- ✅ PandaScore API
- ✅ BallDontLie API
- ✅ API-Football
- ✅ SendGrid Email
- ✅ Telegram Bot

## 📊 Полезные команды

```bash
# Проверка процессов на портах
lsof -i :3000  # Frontend
lsof -i :8001  # Backend
lsof -i :27017 # MongoDB

# Остановка процессов
kill -9 <PID>

# Очистка портов
sudo fuser -k 3000/tcp
sudo fuser -k 8001/tcp
```

## 🎯 Что должно работать после установки

- ✅ Главная страница загружается
- ✅ Статистика отображается
- ✅ Матчи на сегодня загружаются (бейсбол и хоккей)
- ✅ Реальные данные с API
- ✅ Логотипы команд
- ✅ Авторизация и регистрация
- ✅ Отправка email
- ✅ Telegram интеграция

## 🆘 Поддержка

Если возникают проблемы:
1. Проверьте логи в консоли backend и frontend
2. Убедитесь что все сервисы запущены
3. Проверьте что порты свободны
4. Проверьте подключение к интернету (для API ключей)