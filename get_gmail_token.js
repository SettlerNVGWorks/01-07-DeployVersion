const { google } = require('googleapis');
const readline = require('readline');

// Ваши OAuth2 credentials
const CLIENT_ID = '1086782786573-pl9gfri1tmp0t8gdqu3007b990969fad.apps.googleusercontent.com';
const CLIENT_SECRET = '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';
const REDIRECT_URI = 'urn:ietf:wg:oauth:2.0:oob';

const oAuth2Client = new google.auth.OAuth2(CLIENT_ID, CLIENT_SECRET, REDIRECT_URI);

// Генерируем URL для авторизации
const authUrl = oAuth2Client.generateAuthUrl({
  access_type: 'offline',
  scope: ['https://mail.google.com'],
});

console.log('🔗 Откройте эту ссылку в браузере:');
console.log(authUrl);
console.log('\n📋 После авторизации скопируйте код и вставьте сюда:');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

rl.question('Введите код: ', async (code) => {
  try {
    const { tokens } = await oAuth2Client.getToken(code);
    console.log('\n✅ Успешно! Ваши токены:');
    console.log('📧 GMAIL_REFRESH_TOKEN:', tokens.refresh_token);
    console.log('🔑 ACCESS_TOKEN:', tokens.access_token);
    
    // Сохраняем в .env формате
    console.log('\n📝 Добавьте в .env файл:');
    console.log(`GMAIL_CLIENT_ID=${CLIENT_ID}`);
    console.log(`GMAIL_CLIENT_SECRET=${CLIENT_SECRET}`);
    console.log(`GMAIL_REFRESH_TOKEN=${tokens.refresh_token}`);
    
  } catch (error) {
    console.error('❌ Ошибка получения токена:', error);
  }
  rl.close();
});