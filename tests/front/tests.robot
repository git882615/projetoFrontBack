*** Settings ***
Documentation    Testes do front end do site da Kabum
Resource         ../../resources/base.resource
Test Setup       Iniciar Browser
Test Teardown    Finalizar Browser

*** Test Cases ***

Adicionar um produto ao carrinho
    Realizar busca de produto                                notebook    #informar o produto a ser buscado
    Selecionar primeiro produto 
    Preencher CEP do produto selecionado                     52011260    #informar o CEP válido para ser buscado
    Selecionar o tempo de garantia se produto permitir       12    #Valores validps:12,24,36 #Como inserir garantia não é um item de criterio de aceite, criei o controle de fluxo para não da erro se o produto não permitir garantia
    Validar que o produto esta corretamente adicionado ao carrinho
