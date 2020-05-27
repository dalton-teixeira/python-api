*** Settings ***
Library        REST    http://127.0.0.1:5000

*** Test Case ***
My First Test
  GET  /CORONA
  Output  request  request.json
  Output  response  response.json
  Integer  response status   200