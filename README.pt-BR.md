# Template PO-UI para Protheus

Template de referência arquitetural demonstrando a integração de interfaces web modernas em Angular com backends ADVPL no TOTVS Protheus. Utiliza a biblioteca de componentes PO-UI, serviços REST do Protheus e padrões canônicos de ADVPL.

> **Aviso Legal**: Template conceitual e educacional. Todas as classes, modelos e estruturas de dados são genéricas e fictícias.

## Arquitetura

```text
┌─────────────────────────────────────────┐
│              Angular + PO-UI            │
│  (Interface Web — Componentes & Serv.)  │
├─────────────────────────────────────────┤
│          @totvs/protheus-lib-core       │
│  (Autenticação, Sessão, Proxy REST)     │
├─────────────────────────────────────────┤
│           Protheus AppServer            │
│  (Endpoints REST, Regras de Negócio)    │
├─────────────────────────────────────────┤
│           SQL Server / Banco de Dados   │
└─────────────────────────────────────────┘
```

## Estrutura do Projeto

```text
protheus-po-ui-template/
├── frontend/                  # Estrutura da aplicação Angular
│   ├── src/
│   │   ├── app/
│   │   │   ├── services/
│   │   │   │   └── protheus.service.ts
│   │   │   ├── app.component.ts
│   │   │   └── app.module.ts
│   │   └── environments/
├── backend/                   # Serviços ADVPL canônicos
│   ├── rest-crud.prw          # Implementação de serviço CRUD REST
│   └── business-rule.prw      # Ponto de Entrada (PE) e regra de negócio
└── docs/
```

## Conceito de Integração

O template demonstra o fluxo bidirecional de comunicação entre frontends modernos e o ERP:
1. **Camada Frontend:** Desenvolvida em Angular e PO-UI, consumindo rotas REST através dos serviços de proxy do `@totvs/protheus-lib-core`.
2. **Serviços Backend:** Rotas REST padrão em ADVPL (`WSRESTFUL`) gerenciando serialização JSON, controle transacional de tabelas (`RecLock`) e validações de regras de negócio.

## Tecnologias

`Angular` `PO-UI` `ADVPL` `TOTVS Protheus` `TypeScript` `REST APIs`

## Licença

MIT
