*** Variables ***
${URL}                https://www.google.com
${EXPECTED_RESULT}    US Election 2020 - BBC News
${BROWSER}            chrome
${KEYWORD}            USElection2020

*** Keywords ***
พิมพ์ google.com
    Open Browser            ${URL}    ${BROWSER}
พิมพ์คำค้น USElection2020
    Input Text              name:q    ${KEYWORD}
กด Enter
    Press Keys              name:q    RETURN
ตรวจสอบ US Election 2020 - BBC News
    Page Should Contain     ${EXPECTED_RESULT}
    Click Link              ${EXPECTED_RESULT}
ปิด Browsers
    Close All Browsers