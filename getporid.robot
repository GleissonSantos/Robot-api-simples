*** Settings ***
Library               RequestsLibrary
Library               Collections

*** Keywords ***
Step 1: Fazer a request GET por ID
    ${response}=    GET    https://restful-booker.herokuapp.com/booking/2546
    Log    ${response.text}
    Set Test Variable    ${response}

Step 2: Validar campo firstname da reserva do cliente LaMelo
    ${firstnamevalue}=     GET From Dictionary    ${response.json()}    firstname
    Should Be Equal As Strings    ${firstnamevalue}    LaMelo

Step 3: Validar campo lastname da reserva do cliente LaMelo
    ${lastnamevalue}=     GET From Dictionary    ${response.json()}    lastname
    Should Be Equal As Strings     ${lastnamevalue}    Ball  

Step 4: Validar campo depositpaid é igual a true
    ${depositpaidvalue}=     GET From Dictionary    ${response.json()}    depositpaid
    Should Be True    ${depositpaidvalue}

Step 5: Validar campo totalprice da reserva do cliente LaMelo
    ${totalpricevalue}=     GET From Dictionary    ${response.json()}    totalprice
    Should Be Equal As Integers     ${totalpricevalue}    1234

Step 6: Validar campo necessidades adicionais da reserva do cliente LaMelo
    ${additionalneedsvalue}=     GET From Dictionary    ${response.json()}    additionalneeds
    Should Be Equal As Strings     ${additionalneedsvalue}    Basketball court


*** Test Cases ***
Cenário 1: Consultando os dados da reserva de um cliente específico
    Step 1: Fazer a request GET por ID
    Step 2: Validar campo firstname da reserva do cliente LaMelo
    Step 3: Validar campo lastname da reserva do cliente LaMelo
    Step 4: Validar campo depositpaid é igual a true
    Step 5: Validar campo totalprice da reserva do cliente LaMelo
    Step 6: Validar campo necessidades adicionais da reserva do cliente LaMelo


    