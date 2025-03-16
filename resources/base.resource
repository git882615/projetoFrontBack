*** Settings ***
Documentation    Arquivo base de dos testes Front e Back
Library   String
Library   RequestsLibrary
Library   JSONLibrary
Library   Collections
Library   DateTime
Library   Browser
Resource  pages/home_page.resource
Resource  pages/produto_page.resource
Resource  pages/pre_carrinho.resource
Resource  pages/carrinho.resource
Resource  pages/components/alerts.resource
Resource  api/viacep.resource

*** Variables ***
${BASE_URL}         https://www.kabum.com.br
${BROWSER}          chromium
${IS_HEADLESS}      ${False}
${BASE_URL_API}     https://viacep.com.br/ws/
${TIPO_SAIDA_API}   json

*** Keywords ***
Iniciar Browser
    New Browser    browser=${BROWSER}    headless=${IS_HEADLESS}   
    New Page       url=${BASE_URL}    wait_until=domcontentloaded     

Finalizar Browser
    Run Keyword If    $IS_HEADLESS == $False    Take Screenshot    fullPage=true

Convert Currency To Number
    [Arguments]    ${currency_string}
    ${number_string}    Replace String       ${currency_string}    R$    ${EMPTY}
    ${number_string}    Replace String       ${number_string}    ${SPACE}    ${EMPTY}
    ${number_string}    Replace String       ${number_string}    .    ${EMPTY}
    ${number_string}    Replace String       ${number_string}    ,    .
    ${number}           Convert To Number    ${number_string}
    
    RETURN    ${number}    