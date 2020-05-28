*** Settings ***
Library        REST    http://127.0.0.1:5000
Resource       libs/request.robot
Test Setup     Clean Cart
Test Teardown  Log Variables

*** Test Case ***
Test using libs

  ${new IPA beer}  Create Dictionary    id=new IPA  price=${5.1}  delivery=${0}
  Set Local Variable  ${quantity}  ${70}
  Insert new item ${new IPA beer} 
  Add ${quantity} units of ${new IPA beer.id} to cart
  Load Cart
  Number  $.items[?(@.id \= "${new IPA beer.id}")].subtotal   ${new IPA beer.price * ${quantity}}

Second test using libs
  ${new soda}  Create Dictionary    id=new Soda  price=${2.1}  delivery=${0}
  Set Local Variable  ${quantity}  ${10}
  Insert new item ${new soda} 
  I add ${quantity} ${new soda.id} into my cart
  Load my cart session
  Number  $.total   ${new soda.price * ${quantity}}


Third test using libs
  ${new soda 2}  Create Dictionary    id=new Soda 2  price=${3.1}  delivery=${0}
  Set Local Variable  ${quantity}  ${7}
  Insert new item ${new soda 2} 
  I add ${quantity} ${new soda 2.id} into my cart
  Load my cart session
  Number  $.total   ${new soda 2.price * ${quantity}}

Test using arguments
  ${new soda 2}  Create Dictionary    id=new Soda 2  price=${3.1}  delivery=${0}
  Set Local Variable  ${quantity}  ${7}
  Insert new item ${new soda 2} 
  I add ${quantity} ${new soda 2.id} into my cart
  Load my cart session
  Validate Cart  price=${new soda 2.price}  quantity=${quantity}
