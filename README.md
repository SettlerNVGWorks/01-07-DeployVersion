# 🏆 PrognozSports1.ru - Спортивные Прогнозы

Полноценный веб-сайт для спортивных прогнозов с Docker развертыванием.

## 🚀 Быстрый старт на сервере Aeza

### 1. Подготовка сервера Ubuntu
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git nginx ufw
sudo ufw allow ssh && sudo ufw allow 80 && sudo ufw allow 443
sudo ufw --force enable
```

### 2. Установка Docker
```bash
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# Перезайдите в систему после этой команды
```

### 3. Настройка домена PrognozSports1.ru
В панели управления доменом создайте:
- **A-запись**: @ → IP адрес сервера
- **A-запись**: www → IP адрес сервера  
- **TTL**: 300 секунд

### 4. Развертывание проекта
```bash
# Загрузите проект на сервер
git clone <ваш-репозиторий> sport-predictions
cd sport-predictions

# Сделайте скрипты исполняемыми
chmod +x *.sh

# Запустите развертывание
./deploy.sh
```

### 5. Настройка SSL сертификатов
```bash
# После того как DNS заработает (до 24 часов)
./ssl-setup.sh
```

### 6. Проверка работоспособности
```bash
./test-integrations.sh
```

## 📱 Функционал

- ✅ **Спортивные прогнозы** - Бейсбол и Хоккей
- ✅ **Регистрация через Email** - с подтверждением SendGrid
- ✅ **Авторизация через Telegram** - @ByWin52Bot
- ✅ **Реальные данные** - из официальных спортивных API
- ✅ **Адаптивный дизайн** - работает на всех устройствах
- ✅ **Production-ready** - Docker, SSL, Nginx

## 🔧 Технологии

- **Frontend**: React, Tailwind CSS
- **Backend**: Node.js, Express
- **Database**: MongoDB
- **Infrastructure**: Docker, Nginx, Let's Encrypt
- **APIs**: MLB, NHL, SendGrid, Telegram

## 📋 Структура проекта

```
sport-predictions/
├── backend/              # Node.js API сервер
│   ├── routes/          # API маршруты
│   ├── services/        # Сервисы (email, telegram)
│   ├── .env.production  # Production настройки
│   └── server.js        # Главный файл сервера
├── frontend/            # React приложение
│   ├── src/            # Исходный код
│   ├── public/         # Статические файлы
│   └── .env.production # Frontend настройки
├── nginx/              # Конфигурация веб-сервера
├── docker-compose.yml  # Docker конфигурация
├── deploy.sh          # Скрипт развертывания
├── ssl-setup.sh       # Настройка SSL
└── test-integrations.sh # Проверка интеграций
```

## 🔒 Безопасность

- HTTPS с автообновлением SSL
- Rate limiting для API
- CORS защита
- JWT авторизация
- Валидация данных

## 📊 Мониторинг

```bash
# Просмотр логов
docker-compose logs -f backend
docker-compose logs -f nginx

# Статус сервисов  
docker-compose ps

# Проверка здоровья
curl https://prognozSports1.ru/api/health
```

## 🔄 Обновление

```bash
git pull
docker-compose up -d --build
```

## 📞 Поддержка

После развертывания сайт будет доступен:
- **Основной**: https://prognozSports1.ru
- **С WWW**: https://www.prognozSports1.ru

Полная документация в файлах:
- `DEPLOYMENT_GUIDE.md` - детальное руководство
- `DEPLOYMENT_CHECKLIST.md` - чек-лист развертывания

---

© 2025 PrognozSports1.ru - Спортивные прогнозы №1
