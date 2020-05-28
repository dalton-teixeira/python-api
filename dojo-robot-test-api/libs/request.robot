*** Settings ***
Library        REST    http://127.0.0.1:5000
Library        Collections

*** Variables ***
@{cart items}

*** Keywords ***
Insert new item ${item}
  PUT  /  ${item}
  Integer  response status  200

Add ${quantity} units of ${item id} to cart
  &{new item}  Create Dictionary  id=${item id}  quantity=${quantity}
  Append To List  ${cart items}  ${new item}
  
Load cart
  POST  /  ${cart items}
  Output  response  response.json

# Setting test only scope for cart items
Clean cart
  @{cart test scope}  Create List
  Set Test Variable  @{cart test scope}

I add ${quantity} ${item id} into my cart
  &{new item}  Create Dictionary  id=${item id}  quantity=${quantity}
  Append To List  ${cart test scope}  ${new item}
  
Load my cart session
  POST  /  ${cart test scope}
  Output  response  response.json

# Using arguments
Validate Cart
  [Arguments]  ${price}  ${quantity}
  Number  $.total   ${price * ${quantity}}