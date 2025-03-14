*** Settings ***
Documentation        Ações e elementos da página de inicial do Kabum
Resource   ../base.resource

*** Keywords ***
Realizar busca de produto
    [Arguments]    ${produto}
    Wait For Elements State    id=input-busca    visible     15 
    Alert Fala Ninja    #Um validacao para caso o alerta seja apresentado, clica para ignorar
    Fill Text    id=input-busca    ${produto}
    Press Keys   id=input-busca    Enter
    Verifica e aceita cookies    
    Wait For Elements State    id=listingOrdenation   visible     30 


Selecionar primeiro produto 
    Verifica e aceita cookies
    Wait For Elements State      xpath=(//button[@data-state='closed'])[2]   visible     10 
    ${elemento_produto}          Get Elements    css=button[data-testid="tooltip"]
    ${elemento_produto_preco}    Get Elements    css=div[class*="items-center"] span[class$="priceCard"]
    ${elemento_produto_nome}     Get Elements    css=[class$="nameCard"]

    ${produto_preco}             Get Text        ${elemento_produto_preco}[0]
    ${nome_produto}              Get Text        ${elemento_produto_nome}[0]
    #Carrega numa variavel o primeiro elemento dos elementos retornados na busca

    Set Test Variable    ${produto_preco} 
    Set Test Variable    ${nome_produto}

    Click          ${elemento_produto}[0]
    #Clica no primeiro elemento elemento dos elementos retornados na busca do produto

