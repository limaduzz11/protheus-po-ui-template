#include "protheus.ch"
#include "restful.ch"
#include "topconn.ch"

/*--------------------------------------------------------------------*
| Func:  TemplateRestCrud()
| Autor: Eduardo Paranhos
| Data:  10/08/2026
| Desc:  Backend REST para consumo pelo frontend PO-UI (Angular)
|        Path configurado: "/api/exemplo/dados"
| Obs.:  Template educacional com paginacao e persistencia transacionada
*---------------------------------------------------------------------*/

WSRESTFUL TemplateRestCrud DESCRIPTION "CRUD exemplo para PO-UI template" FORMAT APPLICATION_JSON

    WSDATA limit AS CHARACTER OPTIONAL

    WSMETHOD GET DESCRIPTION "Lista dados formatados para PO-UI Table" WSSYNTAX "/api/exemplo/dados"
    WSMETHOD POST DESCRIPTION "Cria registro vindo de formulario PO-UI" WSSYNTAX "/api/exemplo/dados"

END WSRESTFUL

/*--------------------------------------------------------------------*
| GET — Retorna dados para o frontend PO-UI (po-table)
*---------------------------------------------------------------------*/
WSMETHOD GET WSRECEIVE limit WSSERVICE TemplateRestCrud

    Local cAlias    := GetNextAlias()
    Local cQuery    := ""
    Local oResponse := JsonObject():New()
    Local aDados    := {}
    Local oRegistro
    Local nLimit    := 50

    ::SetContentType("application/json")

    If ValType(::limit) == "C" .And. !Empty(::limit)
        nLimit := Max(Val(::limit), 1)
    ElseIf Len(::aURLParms) >= 1
        nLimit := Max(Val(::aURLParms[1]), 1)
    EndIf

    cQuery := "SELECT ZZ1_CODIGO, ZZ1_DESC, ZZ1_PRECO "
    cQuery += "  FROM " + RetSqlName("ZZ1") + " ZZ1 "
    cQuery += " WHERE ZZ1.ZZ1_FILIAL = '" + xFilial("ZZ1") + "' "
    cQuery += "   AND ZZ1.D_E_L_E_T_ = ' ' "
    cQuery += " ORDER BY ZZ1.ZZ1_CODIGO "
    cQuery := ChangeQuery(cQuery)

    TCQuery cQuery New Alias (cAlias)

    While !(cAlias)->(Eof()) .And. Len(aDados) < nLimit
        oRegistro := JsonObject():New()
        oRegistro["codigo"]    := AllTrim((cAlias)->ZZ1_CODIGO)
        oRegistro["descricao"] := AllTrim((cAlias)->ZZ1_DESC)
        oRegistro["preco"]     := (cAlias)->ZZ1_PRECO

        AAdd(aDados, oRegistro)
        (cAlias)->(DbSkip())
    EndDo
    (cAlias)->(DbCloseArea())

    // Estrutura compativel com PO-UI
    oResponse["items"]   := aDados
    oResponse["hasNext"] := (Len(aDados) == nLimit)
    oResponse["total"]   := Len(aDados)

    ::SetResponse(oResponse:ToJson())

Return .T.

/*--------------------------------------------------------------------*
| POST — Cria novo registro a partir do formulario PO-UI
*---------------------------------------------------------------------*/
WSMETHOD POST WSSERVICE TemplateRestCrud

    Local oBody     := JsonObject():New()
    Local oResponse := JsonObject():New()
    Local cCodigo   := ""
    Local cDesc     := ""
    Local cContent  := ::GetContent()

    ::SetContentType("application/json")

    If Empty(cContent) .Or. oBody:FromJson(cContent) != Nil
        SetRestFault(400, "Payload JSON invalido")
        Return .F.
    EndIf

    If !oBody:HasProperty("descricao") .Or. Empty(oBody["descricao"])
        SetRestFault(422, "Campo 'descricao' e obrigatorio")
        Return .F.
    EndIf

    cDesc := oBody["descricao"]

    Begin Transaction
        cCodigo := GetSxeNum("ZZ1", "ZZ1_CODIGO")

        DbSelectArea("ZZ1")
        DbSetOrder(1)

        RecLock("ZZ1", .T.)
        ZZ1->ZZ1_FILIAL := xFilial("ZZ1")
        ZZ1->ZZ1_CODIGO := cCodigo
        ZZ1->ZZ1_DESC   := cDesc
        MsUnlock()

        ConfirmSX8()
    End Transaction

    oResponse["success"] := .T.
    oResponse["codigo"]  := cCodigo
    oResponse["message"] := "Registro criado com sucesso"

    ::SetResponse(oResponse:ToJson())

Return .T.
