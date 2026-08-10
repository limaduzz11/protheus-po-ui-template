#include "protheus.ch"

/*--------------------------------------------------------------------*
| Func:  TemplateRestCrud()
| Autor: Eduardo Paranhos
| Data:  10/08/2026
| Desc:  Exemplo de REST CRUD para tabela generica — backend do template
|        Configurar WSOBJ com path "/api/exemplo/dados"
| Obs.:  Template educacional — dados e tabelas ficticios
*---------------------------------------------------------------------*/

WSRESTFUL TemplateRestCrud Description "CRUD exemplo para PO-UI template"

    WsMethod GET Description "Lista dados"
    WsMethod POST Description "Cria registro"

ENDWSRESTFUL

/*--------------------------------------------------------------------*
| GET — Retorna dados para o frontend PO-UI
*---------------------------------------------------------------------*/
WSMETHOD GET WsReceive QUERY WsService TemplateRestCrud

    Local oResponse := JsonObject():New()
    Local aDados := {}
    Local oRegistro
    Local nLimit := 50
    Local nCount := 0

    // Query parameter opcional para limit
    If WsGetUrlParam("limit") != Nil
        nLimit := Val(WsGetUrlParam("limit"))
    EndIf

    // Busca dados da tabela generica ZZ1
    DbSelectArea("ZZ1")
    DbSetOrder(1)
    DbGoTop()

    While !Eof() .And. nCount < nLimit
        oRegistro := JsonObject():New()
        oRegistro:SetProperty("codigo", AllTrim(ZZ1->ZZ1_CODIGO))
        oRegistro:SetProperty("descricao", AllTrim(ZZ1->ZZ1_DESC))

        AAdd(aDados, oRegistro)
        nCount++
        DbSkip()
    EndDo

    oResponse:SetProperty("data", aDados)
    oResponse:SetProperty("total", nCount)
    oResponse:SetProperty("success", .T.)

    WsSetResponse(200, "application/json", oResponse:ToJson())

Return .T.

/*--------------------------------------------------------------------*
| POST — Cria novo registro
*---------------------------------------------------------------------*/
WSMETHOD POST WsReceive JSON WsService TemplateRestCrud

    Local oBody := JsonObject():New()
    Local oResponse := JsonObject():New()
    Local cCodigo := ""

    oBody:FromJson(WsGetPostContent())

    If oBody:GetProperty("descricao") == Nil
        WsSetResponse(422, "application/json", '{"success":false,"erro":"descricao obrigatoria"}')
        Return .T.
    EndIf

    cCodigo := "REG" + StrZero(Randomize(1, 99999), 5)

    DbSelectArea("ZZ1")
    RecLock("ZZ1", .T.)
    ZZ1->ZZ1_FILIAL := xFilial("ZZ1")
    ZZ1->ZZ1_CODIGO := cCodigo
    ZZ1->ZZ1_DESC   := oBody:GetProperty("descricao"):GetString()
    MsUnLock()

    oResponse:SetProperty("success", .T.)
    oResponse:SetProperty("codigo", cCodigo)
    WsSetResponse(201, "application/json", oResponse:ToJson())

Return .T.
