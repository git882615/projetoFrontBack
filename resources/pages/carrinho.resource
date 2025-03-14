*** Settings ***
Documentation        Ações e elementos da página de carrinho de produtos
Resource   ../base.resource

*** Keywords ***
Validar que o produto esta corretamente adicionado ao carrinho  
    Wait For Elements State      css=div[class*="ProductDesktop-styles__Product-"]    visible
    ${elements}                  Get Elements    css=div[class*="ProductDesktop-styles__Product-"]
    Should Not Be Empty          ${elements}     #Valida que tem um ou mais produto selecionado
    ${preco_produto_carrinho}    Get Text    css=[id*=precoBoletoOuPix]
    ${nome_produto_carrinho}     Get Text    css=[class$="productName productLink"]   
    #Valida se o nome do produto é igual ao produto selecionado e o se preço com desconto esta igual a página home
    Should Be Equal              ${produto_preco}    ${preco_produto_carrinho}
    Should Be Equal              ${nome_produto}     ${nome_produto_carrinho}

    ${valor_produto_resumo}    Get Text    css=#valorDosProdutos b
    ${valor_frete_resumo}      Get Text    css=#frete b
    ${total_resumo}            Get Text    css=#total b[class*="text-sm"]

    ${produto_item}   Convert Currency To Number    ${preco_produto_carrinho}    
    ${produto_num}    Convert Currency To Number    ${valor_produto_resumo}
    ${frete_num}      Convert Currency To Number    ${valor_frete_resumo}
    ${total_num}      Convert Currency To Number    ${total_resumo}

    Should Be True    ${produto_num} >= ${produto_item}

    IF    $tem_garantia_extendida == $True
        ${is_checked}    Get Property     xpath=//label[normalize-space()='${anos_garantia} Meses de Garantia Estendida Kabum']/input    checked
        Should Be True                    ${is_checked}    # Valida que a garantia está marcada.  
        ${valor_servico_resumo}    Get Text    css=#servicosAdicionais b
        ${servico_num}    Convert Currency To Number    ${valor_servico_resumo}
        Should Be True    ${servico_num} > 0    

        ${sum}    Evaluate    ${produto_num} + ${servico_num} + ${frete_num}

        Should Be Equal As Numbers    ${sum}    ${total_num}
        ...    msg=A soma dos valores (${sum}) não é igual ao total (${total_num})  
        #Valida se soma dos valores da compra está correta, incluindo os servicos               
    ELSE  
        ${is_visible}    Run Keyword And Return Status    Wait For Elements State    xpath=//label[normalize-space()='${anos_garantia} Meses de Garantia Estendida Kabum']/input    visible
        Run Keyword If    not ${is_visible}    Log    "O elemento não está visível. Não tem garantia!"

        ${sum}    Evaluate    ${produto_num} + ${frete_num}
    
        Should Be Equal As Numbers    ${sum}    ${total_num}
        ...    msg=A soma dos valores (${sum}) não é igual ao total (${total_num}) 
        #Valida se soma dos valores da compra está correta, não incluindo os servicos 
    END

