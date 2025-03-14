*** Settings ***
Documentation        Ações e elementos da página de pré carrinho de produto
Resource   ../base.resource

*** Keywords ***
Selecionar o tempo de garantia se produto permitir 
    [Arguments]    ${anos_garantia}

    ${element}    Set Variable        xpath=//span[normalize-space()='${anos_garantia} Meses de garantia']/../../../input
    
    ${tem_garantia_extendida}    Run Keyword And Return Status    Wait For Elements State    xpath=//span[normalize-space()='12 Meses de garantia']    state=visible    timeout=20s
    Run Keyword If    not ${tem_garantia_extendida}    Log    "O elemento não está visível. Não tem garantia!"
    Set Test Variable    ${tem_garantia_extendida}

    IF    $tem_garantia_extendida == $True
        Click                             ${element}
        ${is_checked}    Get Property     ${element}    checked
        Should Be True                    ${is_checked}    # Valida que está marcado.
        ${valor_garantia}    Get Text     xpath=//span[normalize-space()='Garantia Estendida:']/following-sibling::strong  
        Set Test Variable    ${valor_garantia}
        Click                             xpath=//span[.='Adicionar serviços']  
    ELSE
        Click    css=span[class*="flex items"] >> text=IR PARA O CARRINHO
        Log      Não tem garantia nesse tipo de produto
        Log To Console    Não tem garantia nesse tipo de produto
            # Como inserir garantia não é um item de criterio de aceite, criei o controle de fluxo para não da erro se o produto não permitir garantia
    END

    Set Test Variable    ${anos_garantia}





