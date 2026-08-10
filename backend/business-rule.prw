#include "protheus.ch"

/*--------------------------------------------------------------------*
| Func:  TemplateBusinessRule()
| Autor: Eduardo Paranhos
| Data:  10/08/2026
| Desc:  Exemplo de regra de negocio (PE) — validacao e enriquecimento
|        Ponto de entrada MATA103 — antes de gravar pedido de venda
| Obs.:  Template educacional — regras exemplificativas
*---------------------------------------------------------------------*/

User Function TemplateBusinessRule()

    Local aArea  := GetArea()
    Local lRet   := .T.
    Local cMsg   := ""

    // ---------- Validacao de campos obrigatorios ----------
    If Empty(SC6->C6_PRODUTO)
        cMsg := "Produto nao informado no item " + SC6->C6_ITEM
        MsgAlert(cMsg, "Validacao de Pedido")
        lRet := .F.
    EndIf

    // ---------- Validacao de quantidade minima ----------
    If SC6->C6_QTDVEN < 1
        cMsg := "Quantidade minima e 1 unidade (item " + SC6->C6_ITEM + ")"
        MsgAlert(cMsg, "Validacao de Pedido")
        lRet := .F.
    EndIf

    // ---------- Enriquecimento automatico ----------
    // Exemplo: preenche condicao de pagamento padrao se nao informada
    If Empty(SC5->C5_CONDPAG)
        SC5->C5_CONDPAG := "001" // Condicao de pagamento padrao
    EndIf

    // ---------- Log de auditoria ----------
    If lRet
        ConOut("[TemplateBusinessRule] Pedido validado: " + SC5->C5_NUM)
    EndIf

    RestArea(aArea)

Return lRet
