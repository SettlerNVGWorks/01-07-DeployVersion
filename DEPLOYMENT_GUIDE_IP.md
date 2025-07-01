# 🚀 Руководство по развертыванию на сервере с IP 185.174.136.113

## 📋 Что изменено для IP адреса

✅ Убрана SSL конфигурация (работает только с доменами)  
✅ Nginx настроен для HTTP соединений  
✅ Все URL заменены на IP адрес 185.174.136.113  
✅ Адаптирован deploy скрипт  
✅ Обновлены переменные окружения  

## 🖥️ Требования к серверу Aeza

- **ОС**: Ubuntu 20.04 или новее
- **RAM**: Минимум 2GB (рекомендуется 4GB)
- **CPU**: 2+ ядра
- **Диск**: 20GB+ свободного места
- **IP**: 185.174.136.113 (ваш статический IP)

## 📍 Пошаговая инструкция

### Шаг 1: Подготовка сервера

Подключитесь к серверу по SSH:
```bash
ssh root@185.174.136.113
```

Обновите систему и установите необходимые пакеты:
```bash
# Обновляем систему
sudo apt update && sudo apt upgrade -y

# Устанавливаем необходимые пакеты
sudo apt install -y curl wget git ufw

# Настраиваем firewall
sudo ufw allow ssh
sudo ufw allow 80
sudo ufw --force enable
```

### Шаг 2: Установка Docker

```bash
# Устанавливаем Docker
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER

# Устанавливаем Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Перезайдите в систему для применения изменений группы
exit
# Тут вы отключитесь от сервера, зайдите заново:
ssh root@185.174.136.113
```

### Шаг 3: Загрузка проекта на сервер

```bash
# Создайте папку для проекта
mkdir sport-predictions
cd sport-predictions

# Здесь нужно загрузить все файлы проекта на сервер
# Можно использовать git clone, scp, или любой другой способ
```

**Варианты загрузки файлов:**

**Вариант А: Через Git (если код в репозитории)**
```bash
git clone ваш-git-репозиторий .
```

**Вариант Б: Через SCP с локального компьютера**
```bash
# Выполните на вашем локальном компьютере:
scp -r /путь/к/вашему/проекту/* root@185.174.136.113:/root/sport-predictions/
```

**Вариант В: Через FTP/SFTP клиент (FileZilla, WinSCP)**
- Подключитесь к серверу через SFTP
- Загрузите все файлы в папку `/root/sport-predictions/`

### Шаг 4: Развертывание приложения

```bash
# Перейдите в папку проекта
cd sport-predictions

# Сделайте скрипт исполняемым (если не сделано)
chmod +x deploy-ip.sh

# Запустите развертывание
./deploy-ip.sh
```

### Шаг 5: Проверка работоспособности

После развертывания проверьте:

```bash
# Статус сервисов
docker-compose ps

# Если что-то не работает, посмотрите логи:
docker-compose logs backend
docker-compose logs frontend
docker-compose logs nginx
docker-compose logs mongodb
```

**Проверьте сайт в браузере:**
- Откройте: `http://185.174.136.113`
- API: `http://185.174.136.113/api/health`

## 🔧 Управление сервисами

### Полезные команды:

```bash
# Просмотр логов в реальном времени
docker-compose logs -f backend
docker-compose logs -f nginx

# Перезапуск сервиса
docker-compose restart backend
docker-compose restart frontend

# Полная остановка
docker-compose down

# Полный перезапуск
docker-compose down && docker-compose up -d --build

# Статус всех сервисов
docker-compose ps
```

## 🚨 Решение проблем

### Если сайт не открывается:

1. **Проверьте статус сервисов:**
```bash
docker-compose ps
```

2. **Проверьте логи:**
```bash
docker-compose logs nginx
docker-compose logs frontend
```

3. **Проверьте firewall:**
```bash
sudo ufw status
# Должен быть открыт порт 80
```

4. **Проверьте доступность с внешнего адреса:**
```bash
curl http://185.174.136.113
```

### Если API не работает:

1. **Проверьте backend:**
```bash
docker-compose logs backend
```

2. **Проверьте MongoDB:**
```bash
docker-compose exec mongodb mongosh sport_predictions --eval "db.stats()"
```

3. **Проверьте API напрямую:**
```bash
curl http://localhost:8001/api/health
```

## 📊 Мониторинг

### Проверка здоровья системы:
```bash
# Использование ресурсов
docker stats

# Место на диске
df -h

# Память
free -h

# Процессы
htop
```

### Автоматический мониторинг:
```bash
# Создайте скрипт для мониторинга
nano monitor.sh
```

```bash
#!/bin/bash
echo "=== System Status ==="
date
echo "=== Docker Services ==="
docker-compose ps
echo "=== Resource Usage ==="
docker stats --no-stream
echo "=== Disk Usage ==="
df -h
```

## 🔄 Обновление приложения

```bash
# Если используете git
git pull

# Перезапуск с новыми изменениями
docker-compose down
docker-compose up -d --build
```

## ⚠️ Важные замечания

1. **Безопасность**: Поскольку используется HTTP (не HTTPS), не вводите чувствительную информацию
2. **Производительность**: На сервере 2GB RAM может быть медленная работа при высокой нагрузке
3. **Резервное копирование**: Регулярно делайте бэкапы MongoDB
4. **Мониторинг**: Следите за логами и ресурсами сервера

## 📞 После развертывания

Ваш сайт будет доступен по адресу: **http://185.174.136.113**

**Основные URL:**
- Главная страница: http://185.174.136.113
- API статус: http://185.174.136.113/api/health
- Nginx статус: http://185.174.136.113/health

## 🎯 Следующие шаги

1. Протестируйте все функции сайта
2. Проверьте работу регистрации и авторизации
3. Убедитесь что загружаются спортивные данные
4. Настройте регулярные бэкапы MongoDB
5. Рассмотрите возможность получения домена для SSL

---

© 2025 Спортивные прогнозы - развертывание на IP 185.174.136.113