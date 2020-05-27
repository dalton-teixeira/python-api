*** Settings ***
Library        REST    http://127.0.0.1:5000

*** Test Case ***
Create new item
  PUT  /  {"id": "new guarana", "price": 1.7, "delivery": 0}
  Integer  response status  200
  Get  /new guarana 
  
  Number  response body price  1.7
  POST  /  [{"id": "new guarana", "quantity": 10}, {"id": "CORONA", "quantity": 10}]
  Output  response  response.json
  Number  response body total  87
  String  $.items[0].id  new guarana
  Number  $.items[?(@.id \= "CORONA")].subtotal  50  
  