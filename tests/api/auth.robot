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
    Should Not Be Empty    ${token}    Token do usuário foi retornado!

Cadastro E Login De Novo Admin
    ${name}=    Gerando Nome Aleatório
    ${temp_email}=   Gerando Email Aleatório
    ${temp_password}=    Set Variable    admin123

    ${admin_email}    ${admin_password}=    Register Admin API    ${name}    ${temp_email}    ${temp_password}
    ${token}=    Login API    ${admin_email}    ${admin_password}

    Set Suite Variable    ${admin_email}
    Set Suite Variable    ${admin_password}

    Log    ${token}
    Should Not Be Empty    ${token}    Token do admin foi retornado!

Login do Novo Usuario
    ${token}=    Login API    ${email}    ${password}
    Should Not Be Empty    ${token}    Token do usuário foi retornado no login!

Login do Novo Admin
    ${token}=    Login API    ${admin_email}    ${admin_password}
    Should Not Be Empty    ${token}    Token do admin foi retornado no login!

Atualizar Senha do Usuario
    ${token}=    Login API    ${email}    ${password}
    Should Not Be Empty    ${token}    Token do usuário foi retornado no login!
    Log    Token do usuário: ${token}
    
    ${new_password}=    Set Variable    newuser123
    Update Password API    ${email}    ${password}    ${new_password}

    # Login com a nova senha
    ${token}=    Login API    ${email}    ${new_password}
    Should Not Be Empty    ${token}    Token do usuário foi retornado após atualização de senha!






