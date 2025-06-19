*** Settings ***
Library               RequestsLibrary
Library               Collections

*** Variables ***
${BASE_URL}    https://restful-booker.herokuapp.com

*** Keywords ***
Step 1: Montando os dados de uma reserva na base 
    ${bookingdates}=    Create Dictionary    checkin= 20125-01-01    checkout=2025-06-18 
    ${data}=    Create Dictionary    firstname=LaMelo    lastname=Ball    totalprice=1234    depositpaid=True    bookingdates=${bookingdates}    additionalneeds=Basketball court
    Log    ${data}
    Set Test Variable    ${data}

Step 2: Inserindo os dados de uma reserva na base via POST
    ${request}=    POST    ${BASE_URL}/booking    json=${data}
    Log    ${request.text}
    Log    ${request.status_code}
    Log    ${request.reason}
    Set Test Variable    ${request}

Step 3: Validando os status code do cadastro
    Should Be True    ${request.ok}
    Should Be Equal As Numbers    ${request.status_code}    200

Step 4: Imprimindo o conteúdo do dicionário enviado
    # Validando os valores retornados 
    ${reserva} =    Set Variable    ${request.json()}
    Log Dictionary    ${reserva}    #Exibe o conteúdo do dicionário para identificar as chaves disponíveis 
    Set Test Variable    ${reserva} 

Step 5: Validando os dados inseridos no cadastro
    # Validação dos valores dentro da chave 'reserva'
    ${reserva_info}=    Get From Dictionary   ${reserva}    booking
    Should Be Equal As Strings    ${reserva_info['firstname']}    LaMelo 
    Should Be Equal As Strings    ${reserva_info['lastname']}    Ball
    Should Be Equal As Strings    ${reserva_info['totalprice']}    1234
    Should Be Equal As Strings    ${reserva_info['additionalneeds']}    Basketball court
    Set Test Variable    ${reserva_info}

*** Test Cases ***
Cenário 1: Cadastrar e validar uma reserva 
    Step 1: Montando os dados de uma reserva na base
    Step 2: Inserindo os dados de uma reserva na base via POST
    Step 3: Validando os status code do cadastro
    Step 4: Imprimindo o conteúdo do dicionário enviado
    Step 5: Validando os dados inseridos no cadastro


    
