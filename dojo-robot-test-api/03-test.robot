*** Settings ***
Library        REST    http://127.0.0.1:5000

*** Variables ***
${new guarana}=  {"id": "new guarana", "price": 1.7, "delivery": 0} 
${new_juice}

*** Keywords ***
Add new item ${new item}
  Log  ${new item}
  PUT  /  ${new item}
  Integer  response status  200
  
  
Get item ${item id} with price ${price}
  Get  /${item id} 
  Output  request  request.json
  Output  response  response.json
  Integer  response status  200
  Number  response body price  ${price}

Add item to Cart
  POST  /  [{"id": "new guarana", "quantity": 10}, {"id": "CORONA", "quantity": 10}]
  Output  response  response.json

Validate Cart
  Number  response body total  87
  String  $.items[0].id  new guarana
  Number  $.items[?(@.id \= "CORONA")].subtotal  50  
  
Add new ${flavour} juice
  Set Local Variable  ${new juice}  {"id": "new ${flavour} juice", "price": 3.1, "delivery":0} 
  #${new juice}=  Set Variable  {"id":"new ${flavour} juice", "price": 2.1, "delivery": 0} 
  Add new item ${new juice}

*** Test Case ***
Create new item
  #Add new item ${new guarana}
  #Get item just Added ${new guarana}
  Add new Test juice
  Get item new Test juice with price 3.1
  #Add item to Cart
  #Validate Cart
  
Validate response list

  ${new IPA beer}  Create Dictionary    id=new IPA  price=${5.1}  delivery=${0}
  #{"id": "new guarana", "price": 1.7, "delivery": 0} 
  Set Global Variable   ${new IPA beer}

  Set Global Variable  ${quantity}  ${70}
  PUT  /  ${new IPA beer}
  Integer  response status  200

  
Reuse same item form last test
  Log Variables
  POST  /  [{"id": "${new IPA beer.id}", "quantity": ${quantity}}]
  Output  response  response.json
  
  #Array  response body items    minItems=2  maxItems=2  
  Number  $.items[?(@.id \= "${new IPA beer.id}")].subtotal   ${new IPA beer.price * ${quantity}}
