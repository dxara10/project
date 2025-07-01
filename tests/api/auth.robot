*** Settings ***
Resource    ../../resources/base.resource

Suite Setup    Create Session API

*** Test Cases ***
Cadastro E Login De Novo Usuario
    ${name}=    Gerando Nome Aleatório
    ${email}=   Gerando Email Aleatório
    ${password}=    Set Variable    user123

    Register API    ${name}    ${email}    ${password}
    ${token}=    Login API    ${email}    ${password}

    Set Suite Variable    ${email}
    Set Suite Variable    ${password}

    Log    ${token}
    Should Not Be Empty    ${token}    Token do usuário não foi retornado!

Cadastro E Login De Novo Admin
    ${name}=    Gerando Nome Aleatório
    ${admin_email}=   Gerando Email Aleatório
    ${admin_password}=    Set Variable    admin123

    Register Admin API    ${name}    ${admin_email}    ${admin_password}
    ${token}=    Login API    ${admin_email}    ${admin_password}

    Set Suite Variable    ${admin_email}
    Set Suite Variable    ${admin_password}

    Log    ${token}
    Should Not Be Empty    ${token}    Token do admin não foi retornado!

Login do Novo Usuario
    ${token}=    Login API    ${email}    ${password}
    Should Not Be Empty    ${token}    Token do usuário não foi retornado no login!

Login do Novo Admin
    ${token}=    Login API    ${admin_email}    ${admin_password}
    Should Not Be Empty    ${token}    Token do admin não foi retornado no login!






