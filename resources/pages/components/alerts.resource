*** Settings ***
Documentation        Ações e elementos dos componentes de alertas do site da Kabum que pode ser apresentado e telas diferentes
Resource   ../../base.resource

*** Keywords ***
Verifica e aceita cookies
    ${testes}    Run Keyword And Return Status    Wait For Elements State    css=button#onetrust-accept-btn-handler >> text=Entendi   state=visible    timeout=10s
    Run Keyword If    ${testes}    Click    css=button#onetrust-accept-btn-handler >> text=Entendi
    #So realiza alguma acao se a condição for verdeira, ou seja, só tenta clicar se o elemento do cookies for apresentado
    
Alert Fala Ninja
    ${testes}    Run Keyword And Return Status    Wait For Elements State    css=div[id^="ins-editable-button"] >> text=Talvez depois    state=visible    timeout=5s
    Run Keyword If    ${testes}    Click    css=div[id^="ins-editable-button"] >> text=Talvez depois
    #So realiza alguma acao se a condição for verdeira, ou seja, só tenta clicar se o elemento do alerta fala ninja for apresentado
