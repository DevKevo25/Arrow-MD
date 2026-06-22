// config.js — User-configurable defaults
// ownerNumber is the single source of truth — never stored in settings.json

// Load .env silently — no dotenvx noise whatsoever
try {
  const fs   = require('fs');
  const path = require('path');
  const envPath = path.join(__dirname, '.env');
  if (fs.existsSync(envPath)) {
    for (const line of fs.readFileSync(envPath, 'utf8').split('\n')) {
      const trimmed = line.trim();
      if (!trimmed || trimmed.startsWith('#')) continue;
      const eqIdx = trimmed.indexOf('=');
      if (eqIdx < 1) continue;
      const key = trimmed.slice(0, eqIdx).trim();
      const val = trimmed.slice(eqIdx + 1).trim().replace(/^(['"`])([\s\S]*)\1$/, '$2');
      if (key && !(key in process.env)) process.env[key] = val;
    }
  }
} catch (_) {}

module.exports = {
  defaultPrefix: '.',
  defaultOwnerName: 'Kevo Loves',
  ownerNumber: '254xxx',
  sessionID: process.env.SESSION_ID || ''
  // Arrow-MD≈
  // get session ID from https://arrow-md-pair.onrender.com
};
