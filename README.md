# Projeto de Automação de Testes - ViaCEP API e Kabum

Este projeto contém testes automatizados para a API ViaCEP e para o site www.kabum.com.br, utilizando Robot Framework com as bibliotecas Browser e Requests.

## Pré-requisitos

- Python 3.13 ou superior (python --version)
- Git 2.46 ou superior (git --version)
- Node.js 20.17 ou superior (node --version)

- **Site para baixar o Python**: https://www.python.org/downloads/
- **Site para baixar o Git**: https://git-scm.com/downloads
- **Site para baixar o Node**: https://nodejs.org/pt/download

## Instalação

1. Clone o repositório:
```
git clone https://github.com/git882615/projetoFrontBack
```
2. Abra a pasta do projeto
```
Windows > cd projetoFrontBack
```
3. Instale as dependências:
```
python -m pip install --upgrade pip
```
```
pip install -r requirements.txt
```
4. Instale as dependências do Browser:
```
rfbrowser init
```

## Estrutura do Projeto
```
projetofrontback
│
├── .gitignore
├── README.md
├── requirements.txt
│
├── resources
│   ├── pages
│   │   ├── home_page.resource
│   │   ├── produto_page.resource
│   │   ├── pre_carrinho_page.resource
│   │   ├── carrinho_page.resource
│   │   └── componentes
│   │       └── alerts.resource
│   │
│   ├── api
│   │   └── viacep.resource
│   │
│   └── fixtures
│
├── logs
│   ├── log.html
│   ├── output.xml
│   ├── report.html
│   └── results
│       ├── log.html
│       ├── output.xml
│       ├── report.html
│       └── pabot_results
│
└── tests
    ├── api
    │   └── tests_api.robot
    │
    └── front
        └── tests.robot
```


## Executando os Testes

### Testes da API ViaCEP

Para executar os testes da API ViaCEP:
```
robot -d ./logs tests\\api\\tests_api.robot
```

### Testes Web da Kabum

Para executar os testes web da Kabum:
```
robot -d ./logs tests\\front\\tests.robot
```
- Esta default browser chorme e modo headless off

- Para executar em modo headless
robot -d ./logs -v IS_HEADLESS:True tests\\front\\tests.robot
- Para rodar outro navegador
robot -d ./logs -v BROWSER:firefox tests\\front\\tests.robot

### Executando todos os testes

Para executar todos os testes de uma vez:
```
robot -d ./logs tests
```
robot -> para executar os testes do robot.
-d -> diretório de logs outDir. Cada vez que um teste é executado, ele gera um novo arquivo de log.
./logs -> diretório para armazenar todos os arquivos de logs.
-v -> variável que será substituida
-i -> Seletor de tags. Filtra todos os testes pelas suas tags.
IS_HEADLESS -> variável a ser definida na linha de comando para rodar em headless. Está como default como False para não em headless
BROWSER -> variável a ser definida na linha de comando para rodar em Browser utilziar. Está como default chromium 

### Executando testes em paralelo
```
pabot --processes 2 --testlevelsplit -v IS_HEADLESS:True --outputdir ./logs/results tests
```
- No exemplo acima serão executados 2 testes em paralelo dos testes totais (API e Web) e será o resultado na pasta Results. Os artefatos do Pabot são gerados, além do artefatos do Robot. Também está sendo passando a variavel IS_HEADLESS:True para roda o teste web em modo headless, mas não é obrigatório.

## Sobre o Projeto

Este projeto utiliza:

- **Robot Framework**: Um framework de automação de testes genérico que já vem com várias bibliotecas nativas.
- **Biblioteca Requests**: Para testes de API REST.
- **Biblioteca Browser**: Para testes de interface web.
- **Biblioteca JSONLibrary**: Para manipulação de response nos teste de API REST.
- **Biblioteca DateTime**: Para interações e validações de data.
- **Biblioteca Collections**: Para interagir com listas e dicionarios.
- **Biblioteca String**: Para manipular e validar variaveis String nos testes.
- **Biblioteca Pabot**: Para executar testes em paralelo.

Os testes cobrem:
- Validações da API ViaCEP, incluindo consultas de CEPs válidos e inválidos.
- Fluxos de navegação e interação no site da Kabum, como adicionar um produto no carriho.

## ✍️ Autores <a name = "autores"></a>
### [@Eliakim Cordeiro](https://www.linkedin.com/in/eliakim-cordeiro-343464112/) 

## 📌 Links do Robot Framework

*  [Robot Framework](https://robotframework.org/)
*  [Robot Framework documentation](https://robotframework.org/robotframework/)
