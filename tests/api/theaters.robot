*** Settings ***
Resource    ../../resources/base.resource


Suite Setup    Create Session API

*** Test Cases ***
Eu como admin posso cadastrar um teatro
    [Tags]    ac-94
    ${name}=    Gerando Nome Aleatório
    ${temp_email}=    Gerando Email Aleatório
    ${temp_password}=    Set Variable    admin123
    ${admin_email}    ${admin_password}=    Register Admin API    ${name}    ${temp_email}    ${temp_password}
    ${token}=    Login API    ${admin_email}    ${admin_password}
    Should Not Be Empty    ${token}
    ${theater_name}    ${capacity}    ${type}=    Gerar Dados Fake de Teatro
    ${theater_id}=    Cadastrar Teatro API    ${token}    ${theater_name}    ${capacity}    ${type}
    Should Not Be Empty    ${theater_id}

Eu como admin posso buscar um teatro por id
    [Tags]    ac-93
    ${name}=    Gerando Nome Aleatório
    ${temp_email}=    Gerando Email Aleatório
    ${temp_password}=    Set Variable    admin123
    ${admin_email}    ${admin_password}=    Register Admin API    ${name}    ${temp_email}    ${temp_password}
    ${token}=    Login API    ${admin_email}    ${admin_password}
    ${theater_name}    ${capacity}    ${type}=    Gerar Dados Fake de Teatro
    ${theater_id}=    Cadastrar Teatro API    ${token}    ${theater_name}    ${capacity}    ${type}
    ${teatro}=    Buscar Teatro Por ID API    ${token}    ${theater_id}
    Should Be Equal    ${teatro['id']}    ${theater_id}

Eu como admin posso atualizar um teatro
    [Tags]    atualizarTeatro
    ${name}=    Gerando Nome Aleatório
    ${temp_email}=    Gerando Email Aleatório
    ${temp_password}=    Set Variable    admin123
    ${admin_email}    ${admin_password}=    Register Admin API    ${name}    ${temp_email}    ${temp_password}
    ${token}=    Login API    ${admin_email}    ${admin_password}
    ${theater_name}    ${capacity}    ${type}=    Gerar Dados Fake de Teatro
    ${theater_id}=    Cadastrar Teatro API    ${token}    ${theater_name}    ${capacity}    ${type}
    ${novo_nome}=    Set Variable    Teatro Atualizado
    ${teatro_atualizado}=    Atualizar Teatro API    ${token}    ${theater_id}    ${novo_nome}    ${capacity}    ${type}
    Should Be Equal    ${teatro_atualizado['name']}    ${novo_nome}

Eu como admin posso deletar um teatro
    [Tags]    ac-97
    ${name}=    Gerando Nome Aleatório
    ${temp_email}=    Gerando Email Aleatório
    ${temp_password}=    Set Variable    admin123
    ${admin_email}    ${admin_password}=    Register Admin API    ${name}    ${temp_email}    ${temp_password}
    ${token}=    Login API    ${admin_email}    ${admin_password}
    ${theater_name}    ${capacity}    ${type}=    Gerar Dados Fake de Teatro
    ${theater_id}=    Cadastrar Teatro API    ${token}    ${theater_name}    ${capacity}    ${type}
    ${success}=    Deletar Teatro API    ${token}    ${theater_id}
    Should Be True    ${success}