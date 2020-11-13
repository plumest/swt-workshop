*** Settings ***
Library               RequestsLibrary
Suite Setup           Create Session     alias=shopping    url=https://www.dminer.in.th

*** Variables ***
&{headers}            Content-Type=application/json     Accept=application/json

*** Test Cases ***
user ซื้อของเล่นให้ลูกสาว เลือกวิธีการจัดส่งเป็น kerry ชำระเงินด้วยบัตรเครดิตด้วย visa และชำระเงินสำเร็จ
    Search
    Product Detail
    Submit Order
    Confirm Payment

*** Keywords ***
Search
    ${response}=       Get Request       alias=shopping    uri=/api/v1/product
    Request Should Be Successful    ${response}
    Should Be Equal As Integers    ${response.json()["total"]}    2
    ${json}=     To Json     {"id": 2,"product_name": "43 Piece dinner Set","product_price": 12.95,"product_image": "/43_Piece_dinner_Set.png"}
    Should Contain     ${response.json()["products"]}        ${json}
    # Should Be Equal    ${response.json()["products"][1]["product_name"]}    43 Piece dinner Set
    # Should Be Equal As Numbers    ${response.json()["products"][1]["product_price"]}    12.95
    # Should Be Equal    ${response.json()["products"][1]["product_image"]}    /43_Piece_dinner_Set.png
Product Detail
    ${response}=       Get Request       alias=shopping    uri=/api/v1/product/2     headers=${headers}
    Request Should Be Successful    ${response}
    ${json}=     To Json     {"id": 2,"product_name": "43 Piece dinner Set","product_price": 12.95,"product_image": "/43_Piece_dinner_Set.png","quantity": 10,"product_brand": "CoolKidz"}
    Should be Equal     ${response.json()}        ${json}

Submit Order
    ${data}=    To Json    {"cart" : [{ "product_id": 2,"quantity": 1}],"shipping_method" : "Kerry","shipping_address" : "405/37 ถ.มหิดล","shipping_sub_district" : "ต.ท่าศาลา","shipping_district" : "อ.เมือง","shipping_province" : "จ.เชียงใหม่","shipping_zip_code" : "50000","recipient_name" : "ณัฐญา ชุติบุตร","recipient_phone_number" : "0970809292"}
    ${response}=    Post Request    alias=shopping    uri=/api/v1/order    headers=${headers}     json=${data}
    Request Should Be Successful    ${response}
    ${ORDER}=    Set Variable    ${response.json()}
    Set Test Variable    ${ORDER}
    ${expected_result}=    To Json     {"order_id": 8004359122, "total_price": 14.95}
    Should be Equal    ${ORDER}    ${expected_result}
Confirm Payment
    ${data}=    To Json     {"order_id" : ${ORDER["order_id"]},"payment_type" : "credit","type" : "visa","card_number" : "4719700591590995","cvv" : "752","expired_month" : 7,"expired_year" : 20,"card_name" : "Karnwat Wongudom","total_price" : ${ORDER["total_price"]}}
    ${response}=    Post Request    alias=shopping    uri=/api/v1/confirmPayment    headers=${headers}     json=${data}
    Request Should Be Successful    ${response}
    ${expected_result}=    To Json     {"notify_message": "วันเวลาที่ชำระเงิน 1/3/2020 13:30:00 หมายเลขคำสั่งซื้อ ${ORDER["order_id"]} คุณสามารถติดตามสินค้าผ่านช่องทาง Kerry หมายเลข 1785261900"}
    Should be Equal    ${response.json()}    ${expected_result}