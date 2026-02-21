<div align="center">

# Telegram Algorithmic Trading Bot

[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://python.org)
[![Telegram](https://img.shields.io/badge/Telegram_Bot_API-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://core.telegram.org/bots/api)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)

> A production-grade cryptocurrency trading automation system operated entirely through Telegram — with real-time market monitoring, automated signal generation, portfolio management, and full admin controls.

</div>

---

## Overview

This bot brings automated crypto trading directly into Telegram, the messaging platform where many trading communities already operate. Users can fund their account, receive trading signals based on technical indicators, execute trades, and manage their portfolio — all through a conversational Telegram interface.

The system is designed for production: it supports multiple cryptocurrencies, handles deposits and withdrawals with state tracking, and gives admins full visibility and control over the user base.

---

## Architecture

```
┌──────────────────────────────────────────────────────────────┐
│                   Telegram Bot Interface                     │
│  python-telegram-bot → Command handlers → Inline keyboards   │
└───────────────┬──────────────────────────┬───────────────────┘
                │                          │
┌───────────────▼──────────┐  ┌────────────▼──────────────────┐
│    Trading Engine        │  │     User Management           │
│  Market data ingestion   │  │  Registration · Balances      │
│  Technical indicators    │  │  Deposits · Withdrawals       │
│  Signal generation       │  │  Transaction history          │
│  Position sizing         │  │  Notifications                │
└───────────────┬──────────┘  └────────────┬──────────────────┘
                │                          │
┌───────────────▼──────────────────────────▼──────────────────┐
│                      Data Layer                              │
│  SQLite / PostgreSQL — Users, Positions, Transactions, Signals│
└──────────────────────────────────────────────────────────────┘
                │
┌───────────────▼──────────────────────────────────────────────┐
│                   External Integrations                      │
│  Crypto Exchange APIs (Binance / Bybit / etc.)               │
│  Market data feeds · Price alerts · WebSocket streams        │
└──────────────────────────────────────────────────────────────┘
```

---

## Key Features

### User-Facing
- `/start` — register account and receive a unique wallet address
- `/deposit` — initiate a deposit flow with address and confirmation tracking
- `/balance` — view current portfolio balance across assets
- `/signals` — receive the latest trading signals with entry, stop-loss, and take-profit levels
- `/history` — view transaction and trade history
- `/withdraw` — initiate a withdrawal with admin approval flow

### Trading Engine
- Real-time market data ingestion from exchange APIs
- Technical indicator computation (RSI, MACD, EMA crossovers, breakout detection)
- Automated signal generation with configurable parameters
- Risk management — position sizing based on account balance and risk tolerance

### Admin Controls
- `/admin users` — view all registered users and their balances
- `/admin broadcast` — send a message to all users
- `/admin approve <id>` — approve pending withdrawal requests
- `/admin ban <id>` — suspend a user account
- Real-time deposit monitoring and confirmation

---

## Tech Stack

| Component | Technology |
|---|---|
| Language | Python 3.10+ |
| Bot Framework | python-telegram-bot |
| Market Data | ccxt / Exchange REST APIs |
| Technical Analysis | ta / pandas-ta |
| Database | SQLite (dev) / PostgreSQL (prod) |
| Scheduling | APScheduler |
| Data Processing | Pandas, NumPy |

---

## Getting Started

```bash
# Clone the repo
git clone https://github.com/Ghost-tech-ng/Telegram-Trading-Bot-.git
cd Telegram-Trading-Bot-

# Install dependencies
pip install -r requirements.txt

# Configure environment
cp .env.example .env
# Add your Telegram bot token and exchange API keys
```

---

## Environment Variables

```env
TELEGRAM_BOT_TOKEN=your_telegram_bot_token
EXCHANGE_API_KEY=your_exchange_api_key
EXCHANGE_API_SECRET=your_exchange_api_secret
ADMIN_TELEGRAM_ID=your_telegram_user_id
DATABASE_URL=sqlite:///bot.db
```

```bash
# Start the bot
python main.py
```

---

## Supported Cryptocurrencies

The bot is designed to support multiple trading pairs. Configure the active pairs in `config.py`:

```python
TRADING_PAIRS = ["BTC/USDT", "ETH/USDT", "BNB/USDT"]
```

---

## Author

**Eghosa Osemwegie** — [GitHub](https://github.com/Ghost-tech-ng) · [Portfolio](http://www.eghosa.tech) · [Email](mailto:osemwegiee@gmail.com)
