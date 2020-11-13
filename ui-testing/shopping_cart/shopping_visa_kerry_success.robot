*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser    https://www.dminer.in.th/Product-list.html    chrome
Suite Teardown    Close All Browsers

*** Variables ***
${Item}         43 Piece Dinner Set
${Price}        12.95 USD

*** Test Cases ***
user ซื้อของเล่นให้ลูกสาว เลือกวิธีการจัดส่งเป็น kerry ชำระเงินด้วยบัตรเครดิตด้วย visa และชำระเงินสำเร็จ
    แสดงสินค้า
    แสดงรายละเอียดสินค้า
    ระบุจำนวนสินค้า
    นำสินค้าใส่ตะกร้า
    ยืนยันการสั่งซื้อ
    ชำระเงินด้วยบัตรเครดิตวีซ่าคาร์ด
    ขอบคุณ

*** Keywords ***
แสดงสินค้า
    Element Should Contain          id=productName-1          expected=${Item}
    Element Should Contain          id=productPrice-1         expected=${Price}
แสดงรายละเอียดสินค้า
    Click Button                    id=viewMore-1
    Wait Until Element Contains     id=productName            text=43 Piece dinner Set
    Element Should Contain          id=productBrand           expected=CoolKidz
    Element Should Contain          id=productGender          expected=UNISEX
    Element Should Contain          id=productAge             expected=13+
    Element Should Contain          id=productPrice           expected=${Price}
ระบุจำนวนสินค้า
    Input Text                      id=productQuantity        1
นำสินค้าใส่ตะกร้า
    Click Button                    id=addToCart
ยืนยันการสั่งซื้อ
    Wait Until Element Contains     id=productName-1          text=43 Piece dinner Set
    Element Should Contain          id=receiverName           expected=ณัฐญา ชุติบุตร
    Element Should Contain          id=recevierAddress        expected=405/37 ถ.มหิดล ต.ท่าศาลา อ.เมือง จ.เชียงใหม่ 50000
    Element Should Contain          id=recevierPhonenumber    expected=0970809292
    Element Should Contain          id=totalProductPrice      expected=${Price}
    Element Should Contain          id=totalShippingCharge    expected=2.00 USD
    Element Should Contain          id=totalAmount            expected=14.95 USD
    Click Button                    id=confirmPayment
ชำระเงินด้วยบัตรเครดิตวีซ่าคาร์ด
    Wait Until Element Contains     id=totalPrice             text=241.90 
    Input Text                      id=cardNumber             4719700591590995
    Input Text                      id=expiredMonth           7
    Input Text                      id=expiredYear            20
    Input Text                      id=cvv                    752
    Input Text                      id=cardName               Karnwat Wongudom
    Click Button                    id=Payment
ขอบคุณ
    Wait Until Element Contains     id=title                  text=ชำระเงินสำเร็จ
