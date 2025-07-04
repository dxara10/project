*** Settings ***
Library    FakerLibrary

Resource    ../base.resource

*** Keywords ***
Gerar Dados Fake de Filme
    ${title}             FakerLibrary.Word
    ${synopsis}          FakerLibrary.Sentence
    ${director}          FakerLibrary.Name
    ${genres}            Create List    Action    Comedy    Drama
    ${duration}          Evaluate    random.randint(60, 180)
    ${classification}    Set Variable    16+
    ${poster}            Set Variable    string
    ${releaseDate}      Set Variable    2025-06-28
    RETURN    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}

Cadastrar Filme API
    [Arguments]    ${token}    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${release_date}
    ${body}=    Create Dictionary    
    ...    title=${title}    
    ...    synopsis=${synopsis}    
    ...    director=${director}    
    ...    genres=${genres}    
    ...    duration=${duration}    
    ...    classification=${classification}    
    ...    poster=${poster}    
    ...    releaseDate=${releaseDate}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    ${response}=    POST On Session    cinema    /movies    headers=${headers}    json=${body}
    Should Be Equal As Integers    ${response.status_code}    201
    ${json}=    To JSON    ${response.content}
    RETURN    ${json['data']['id']}

Buscar Filme Por ID API
    [Arguments]    ${token}    ${movie_id}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    cinema    /movies/${movie_id}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    To JSON    ${response.content}
    RETURN    ${json['data']}

Atualizar Filme API
    [Arguments]    ${token}    ${movie_id}    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}
    ${body}=    Create Dictionary
    ...    title=${title}
    ...    synopsis=${synopsis}
    ...    director=${director}
    ...    genres=${genres}
    ...    duration=${duration}
    ...    classification=${classification}
    ...    poster=${poster}
    ...    releaseDate=${releaseDate}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    ${response}=    PUT On Session    cinema    /movies/${movie_id}    headers=${headers}    json=${body}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    To JSON    ${response.content}
    RETURN    ${json['data']}

Deletar Filme API
    [Arguments]    ${token}    ${movie_id}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    DELETE On Session    cinema    /movies/${movie_id}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    To JSON    ${response.content}
    RETURN    ${json['success']}