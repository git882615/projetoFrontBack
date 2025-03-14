*** Settings ***
Documentation        Ações e requisições da API viacep
Resource   ../base.resource

*** Variables ***
${RETRY}             3 
${RETRY_INTERVAL}    1s 

*** Keywords ***
Realizar busca de CEP 
    [Arguments]    ${cep}    ${tipo_expectativa}  
       
    IF    $tipo_expectativa == 'sucesso'
        ${expected_status}    Set Variable    200
    ELSE IF    $tipo_expectativa == 'falha'
        ${expected_status}    Set Variable    400
    ELSE   
        ${expected_status}    Set Variable    200  
    END  

    Set Test Variable    ${cep}
    ${response}    Wait Until Keyword Succeeds    
    ...    ${RETRY}    
    ...    ${RETRY_INTERVAL}   
    ...    Realizar request
    ...    ${cep} 
    ...    ${expected_status}
   
    #Utilizando o keyword Wait Until Keyword Succeeds para evitar que o teste falhe por intermitencia de ambiente. 

Realizar request    
    [Arguments]    ${cep}    ${expected_status} 
    ${response}    GET
    ...    url=${BASE_URL_API}${cep}/${TIPO_SAIDA_API}/
    ...    expected_status=${expected_status} 

    Set Test Variable    ${response}   

    RETURN    ${response} 
 


Validar response de sucesso geral
    [Arguments]    ${response}

    ${cep_response}    Convert Json To String    ${response.json()}[cep]
    ${cep_response}    Replace String       ${cep_response}    -    ${EMPTY} 
    ${cep_response}    Replace String       ${cep_response}    "    ${EMPTY} 
    Convert To String    ${cep}
    Should Be Equal    ${cep_response}    ${cep}
    
    ${logradouro}    Set Variable    ${response.json()}[logradouro]
    Should Not Be Empty    ${logradouro}
    Dictionary Should Contain Key    ${response.json()}    complemento
    Dictionary Should Contain Key    ${response.json()}    unidade
    ${bairro}    Set Variable    ${response.json()}[bairro]
    Should Not Be Empty    ${bairro}
    ${localidade}    Set Variable    ${response.json()}[localidade]
    Should Not Be Empty    ${localidade}
    ${uf}    Set Variable    ${response.json()}[uf]
    Length Should Be       ${uf}    2
    Should Contain Any    ${uf}    AC    AL    AM    AP    BA    CE    DF    ES    GO    MA    MG    MS    MT    PA    PB    PE    PI    PR    RJ    RN    RO    RR    RS    SC    SE    SP    TO    
    ${estado}    Set Variable    ${response.json()}[estado] 
    Should Contain Any    ${estado}    Acre    Alagoas    Amapá    Amazonas    Bahia    Ceará    Distrito Federal    Espírito Santo    Goiás    Maranhão    Minas Gerais    Mato Grosso do Sul    Mato Grosso    Pará    Paraíba    Paraná    Pernambuco    Piauí    Rio de Janeiro    Rio Grande do Norte    Rio Grande do Sul    Rondônia    Roraima    Santa Catarina    São Paulo    Sergipe    Tocantins    
    ${regiao}    Set Variable    ${response.json()}[regiao]
    Should Contain Any    ${regiao}    Nordeste    Norte    Sudeste    Centro-Oeste    Sul    
    ${ibge}    Set Variable    ${response.json()}[ibge]
    Should Not Be Empty    ${ibge}
    Dictionary Should Contain Key    ${response.json()}    gia
    ${ddd}    Set Variable    ${response.json()}[ddd]
    Should Not Be Empty    ${ddd}
    Length Should Be       ${uf}    2
    ${siafi}    Set Variable    ${response.json()}[siafi]
    Should Not Be Empty    ${siafi}

    #Separando a validação geral e especifica porque em uma temos uma ideia de quais valores são possíveis e os formatos dos dados, na outro eu sei exatamente os dados que deve
    # ser retornados por isso a diferença.

Validar response de sucesso para CEP especifico
    [Arguments]    ${response}    ${logradouro_arg}    ${bairro_arg}    ${localidade_arg}    ${uf_arg}    ${estado_arg}    ${regiao_arg}    ${ddd_arg}

    ${cep_response}    Convert Json To String    ${response.json()}[cep]
    ${cep_response}    Replace String       ${cep_response}    -    ${EMPTY} 
    ${cep_response}    Replace String       ${cep_response}    "    ${EMPTY} 
    Convert To String    ${cep}
    Should Be Equal    ${cep_response}    ${cep}

    ${logradouro}    Set Variable    ${response.json()}[logradouro]
    Should Be Equal    ${logradouro}    ${logradouro_arg}
    Dictionary Should Contain Key    ${response.json()}    complemento
    Dictionary Should Contain Key    ${response.json()}    unidade
    ${bairro}    Set Variable    ${response.json()}[bairro]
    Should Be Equal    ${bairro}    ${bairro_arg}
    ${localidade}    Set Variable    ${response.json()}[localidade]
    Should Be Equal    ${localidade}    ${localidade_arg}
    ${uf}    Set Variable    ${response.json()}[uf]
    Should Be Equal    ${uf}    ${uf_arg}
    ${estado}    Set Variable    ${response.json()}[estado] 
    Should Be Equal    ${estado}    ${estado_arg}
    ${regiao}    Set Variable    ${response.json()}[regiao]
    Should Be Equal    ${regiao}    ${regiao_arg}
    ${ibge}    Set Variable    ${response.json()}[ibge]
    Should Not Be Empty    ${ibge}
    Dictionary Should Contain Key    ${response.json()}    gia
    ${ddd}    Set Variable    ${response.json()}[ddd]
    Should Be Equal    ${ddd}    ${ddd_arg}
    ${siafi}    Set Variable    ${response.json()}[siafi]
    Should Not Be Empty    ${siafi}


Validar response de CEP em formato valido, mas não existente
    [Arguments]    ${response}
    Dictionary Should Contain Item    ${response.json()}    erro    true