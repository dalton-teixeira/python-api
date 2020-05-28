*** Settings ***
Library        REST
Library        uuid
Library        libs/MyLib.py
Test Setup     Import Variables  ${env}.yml
Test Teardown  Log Variables

*** Test Case ***
Test using header
    ${timestamp}=  Get Time    epoch
    ${requestTraceId}=    Evaluate    uuid.uuid4()
    
    ${header}=    Catenate
    ...  { "x-timestamp": "${timestamp}",
    ...    "requestTraceId": "${requestTraceId}",
    ...    "authorization": "Bearer ${token}"}
    Set Headers    ${header}
    
    Get  ${base_url}/
    Number   response status  200
    Output  request  request.json
    Output  response  response.json

Test using python Library
  ${test folder}=  Get Test Folder  
  LOG  ${test folder}