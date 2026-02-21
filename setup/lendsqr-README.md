<div align="center">

# Demo Credit — Lendsqr Wallet Service

[![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=for-the-badge&logo=typescript&logoColor=white)](https://typescriptlang.org)
[![Node.js](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)](https://nodejs.org)
[![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://mysql.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)

> A production-grade fintech backend service implementing a mobile wallet for a lending platform — with account creation, wallet funding, P2P transfers, withdrawals, and blacklist screening via the Lendsqr Adjutor API.

</div>

---

## Overview

This project is a backend implementation of the **Demo Credit** product — a wallet service that underpins a mobile lending app. It models real fintech engineering requirements: strict data integrity for financial transactions, external API integration for credit decisioning, and a clean layered architecture that separates concerns across controllers, services, and data access.

---

## Architecture

```
┌───────────────────────────────────────────────────────────────┐
│                         HTTP Layer                            │
│  Express.js Router → Input validation → Controller           │
└──────────────────────────┬────────────────────────────────────┘
                           │
┌──────────────────────────▼────────────────────────────────────┐
│                      Service Layer                            │
│  Business logic · Transaction atomicity · Error handling      │
│  Lendsqr Adjutor API integration (blacklist check at signup)  │
└──────────────────────────┬────────────────────────────────────┘
                           │
┌──────────────────────────▼────────────────────────────────────┐
│                    Repository Layer                           │
│  Knex.js query builder · MySQL · Atomic DB transactions       │
└──────────────────────────┬────────────────────────────────────┘
                           │
┌──────────────────────────▼────────────────────────────────────┐
│                      Database                                 │
│  MySQL — Users, Wallets, Transactions tables                  │
└───────────────────────────────────────────────────────────────┘
```

---

## Key Features

- **Account creation with blacklist screening** — new users are checked against the Lendsqr Adjutor API; blacklisted identities are rejected at onboarding
- **Wallet funding** — deposit funds into a user's wallet with balance update and transaction record
- **P2P transfers** — transfer funds between wallets atomically; both debit and credit happen in a single DB transaction or neither does
- **Withdrawals** — move funds from wallet to external account with sufficient balance validation
- **Unit tested** — all core wallet operations covered with isolated unit tests

---

## Tech Stack

| Component | Technology |
|---|---|
| Runtime | Node.js |
| Language | TypeScript |
| Framework | Express.js |
| Query Builder | Knex.js |
| Database | MySQL |
| Testing | Jest |
| External API | Lendsqr Adjutor API |

---

## API Endpoints

| Method | Endpoint | Description |
|---|---|---|
| `POST` | `/users` | Create account (with blacklist check) |
| `POST` | `/wallets/fund` | Fund a wallet |
| `POST` | `/wallets/transfer` | Transfer between wallets |
| `POST` | `/wallets/withdraw` | Withdraw from wallet |
| `GET` | `/wallets/:userId` | Get wallet balance |

---

## Getting Started

```bash
# Clone the repo
git clone https://github.com/Ghost-tech-ng/Lendsqtr-backend-project.git
cd Lendsqtr-backend-project

# Install dependencies
npm install

# Set up environment variables
cp .env.example .env
# Edit .env with your MySQL credentials and Lendsqr API key

# Run database migrations
npx knex migrate:latest

# Start the development server
npm run dev
```

---

## Environment Variables

```env
DB_HOST=localhost
DB_PORT=3306
DB_NAME=democredit
DB_USER=your_user
DB_PASSWORD=your_password
LENDSQR_API_KEY=your_adjutor_api_key
PORT=3000
```

---

## Database Schema

```
users          wallets            transactions
─────────      ────────────────   ─────────────────────────
id             id                 id
name           user_id (FK)       wallet_id (FK)
email          balance            type (fund/transfer/withdraw)
phone                             amount
created_at                        reference
                                  created_at
```

---

## Running Tests

```bash
npm test
```

---

## Author

**Eghosa Osemwegie** — [GitHub](https://github.com/Ghost-tech-ng) · [Portfolio](http://www.eghosa.tech) · [Email](mailto:osemwegiee@gmail.com)
