*** Settings ***
Documentation        Ações e elementos da página de adicionar produto no carrinho
Resource   ../base.resource

*** Keywords ***
Preencher CEP do produto selecionado 
    [Arguments]    ${cep}
    Wait For Elements State    css=#blocoValores
    Verifica e aceita cookies
    Fill Text                      id=inputCalcularFrete    ${cep}
    Click                          id=botaoCalcularFrete
    Validar dados das opcoes do frente
    Click                          css=button[aria-label="Fechar"] .IconClose
    Click                          css=#blocoValores button >> text="COMPRAR"


Validar dados das opcoes do frente
    ${opcoes_frete}    Get Elements    css=#listaOpcoesFrete div span

    FOR    ${index}    ${element}    IN ENUMERATE    @{opcoes_frete}
        Log    ${index}: ${element}
        IF    ${index} == 0 or ${index} == 3 or ${index} == 6
            ${tipo_frete}    Get Text    ${element}
            Should Match Regexp    ${tipo_frete}    (Entrega Econômica|Entrega Padrão|Entrega Expressa|Expressa|Padrão|Econômica)
        ELSE IF    ${index} == 1 or ${index} == 4 or ${index} == 7
            ${preco_frete}    Get Text    ${element}        
            Should Match Regexp    ${preco_frete}    ^(R\\$\\s*(0|[1-9]\\d*),\\d{2}|Grátis)$ 
            Set Test Variable    ${preco_frete}                                                                                         
        ELSE 
            ${data}    Get Text    ${element}
            Should Match Regexp    ${data}    Chegará até: \\d{2}/\\d{2}/\\d{4}
            ${data_extraida}    Extrair data do texto    ${data}
            Validar se a data informada é válida    ${data_extraida}
        END
    END


Extrair data do texto
    [Arguments]    ${text}
    ${date_part}    Fetch From Right    ${text}    Chegará até:
    ${date_part}    Strip String        ${date_part} 
    RETURN    ${date_part}

Validar se a data informada é válida
    [Arguments]    ${data_extraida}
    ${data_hoje}    Get Current Date    result_format=%d/%m/%Y
    
    ${data_extraida_dt}    Convert Date    ${data_extraida}    date_format=%d/%m/%Y
    ${data_hoje_dt}    Convert Date    ${data_hoje}    date_format=%d/%m/%Y
    
    ${diff}    Subtract Date From Date    ${data_extraida_dt}    ${data_hoje_dt}
    Should Be True    ${diff} >= 0    A data fornecida (${data_extraida}) é anterior à data de hoje (${data_hoje})