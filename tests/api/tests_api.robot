*** Settings ***
Documentation    Testes do API do serviço https://viacep.com.br/
Resource         ../../resources/base.resource


*** Test Cases ***

Realizar busca de CEP com valor válido
    [Tags]    sucesso
    Realizar busca de CEP    52011260    sucesso
    Validar response de sucesso geral    ${response}

Realizar busca de CEP com inexistente, mas com formato inválido
    [Tags]    inexistente
    Realizar busca de CEP    11111111    inexistente
    Validar response de CEP em formato valido, mas não existente    ${response}

Realizar busca de CEP com valor inválido
    [Tags]    falha
    Realizar busca de CEP    teste                falha
    Realizar busca de CEP    1                    falha
    Realizar busca de CEP    12                   falha
    Realizar busca de CEP    123                  falha
    Realizar busca de CEP    1234                 falha
    Realizar busca de CEP    12345                falha
    Realizar busca de CEP    123456               falha
    Realizar busca de CEP    1234567              falha
    Realizar busca de CEP    123456789            falha
    Realizar busca de CEP    52011--260           falha
    Realizar busca de CEP    52011!260            falha
    Realizar busca de CEP    !&%$%$%$             falha
    Realizar busca de CEP    !                    falha
    Realizar busca de CEP    520112600            falha
    Realizar busca de CEP    12#w1234             falha
    Realizar busca de CEP    teste#!              falha
    Realizar busca de CEP    5201126052011260     falha

Realizar busca de CEP com valor especifico
    [Tags]    sucesso    especifico
    Realizar busca de CEP    52011260    sucesso
    Validar response de sucesso para CEP especifico    ${response}    Rua da Amizade    Graças    Recife   PE    Pernambuco    Nordeste    81


