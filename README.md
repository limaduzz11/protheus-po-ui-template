# Protheus PO-UI Template

Reference architectural template demonstrating the integration of modern Angular web interfaces with TOTVS Protheus ADVPL backends. Uses the PO-UI component library, Protheus REST services, and canonical ADVPL patterns.

> **Disclaimer**: Educational and conceptual template. All classes, models, and data structures are generic and fictional.

## Architecture

```text
┌─────────────────────────────────────────┐
│              Angular + PO-UI            │
│  (Browser UI — Components & Services)   │
├─────────────────────────────────────────┤
│          @totvs/protheus-lib-core       │
│  (Authentication, Session, REST proxy)  │
├─────────────────────────────────────────┤
│           Protheus AppServer            │
│  (REST endpoints, Business logic)       │
├─────────────────────────────────────────┤
│           SQL Server / Database         │
└─────────────────────────────────────────┘
```

## Project Structure

```text
protheus-po-ui-template/
├── frontend/                  # Angular application structure
│   ├── src/
│   │   ├── app/
│   │   │   ├── services/
│   │   │   │   └── protheus.service.ts
│   │   │   ├── app.component.ts
│   │   │   └── app.module.ts
│   │   └── environments/
├── backend/                   # Canonical ADVPL services
│   ├── rest-crud.prw          # REST CRUD service implementation
│   └── business-rule.prw      # Point of Entry (PE) business rule sample
└── docs/
```

## Integration Concept

The template demonstrates two-way communication between modern web interfaces and the ERP:
1. **Frontend Layer:** Built with PO-UI and Angular, consuming REST endpoints through `@totvs/protheus-lib-core` proxy services.
2. **Backend Services:** Standard ADVPL REST services (`WSRESTFUL`) handling payload serialization, database transaction locking (`RecLock`), and business validation.

## Tech Stack

`Angular` `PO-UI` `ADVPL` `TOTVS Protheus` `TypeScript` `REST APIs`

## License

MIT
