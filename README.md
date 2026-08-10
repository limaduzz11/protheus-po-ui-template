# Protheus PO-UI Template

Reference template for building modern Angular interfaces integrated with TOTVS Protheus ADVPL backends. Uses PO-UI component library, Protheus REST services, and standard ADVPL patterns.

> **Disclaimer**: Educational template. Uses fictional table names, mock data, and generic company references.

## Architecture

```
┌─────────────────────────────────────────┐
│              Angular + PO-UI             │
│  (Browser UI — Components & Services)    │
├─────────────────────────────────────────┤
│          @totvs/protheus-lib-core         │
│  (Authentication, Session, REST proxy)   │
├─────────────────────────────────────────┤
│           Protheus AppServer              │
│  (REST endpoints, Business logic)        │
├─────────────────────────────────────────┤
│           SQL Server / Database           │
└─────────────────────────────────────────┘
```

## Project Structure

```
protheus-po-ui-template/
├── frontend/                  # Angular application
│   ├── package.json
│   ├── angular.json
│   ├── tsconfig.json
│   └── src/
│       ├── index.html
│       ├── main.ts
│       ├── app/
│       │   ├── app.module.ts
│       │   ├── app.component.ts
│       │   ├── app.component.html
│       │   └── services/
│       │       └── protheus.service.ts
│       └── environments/
│           └── environment.ts
├── backend/                   # ADVPL sources
│   ├── rest-crud.prw          # REST CRUD example
│   └── business-rule.prw      # PE/Business rule example
└── .gitignore
```

## Tech Stack

`Angular` `PO-UI` `ADVPL` `TOTVS Protheus` `TypeScript` `REST APIs`

## Quick Start

### Frontend

```bash
cd frontend
npm install
ng serve
```

Access `http://localhost:4200` — requires Protheus AppServer running.

### Backend

1. Copy `backend/*.prw` to your Protheus environment
2. Compile via TDS or directly in Protheus
3. Configure REST endpoints in Protheus WSOBJ

## License

MIT
