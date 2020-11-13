*** Settings ***
Library    SeleniumLibrary

*** Variables ***

*** Test Case ***
Test search keyword and verify search result on Google
    พิมพ์ google.com
    พิมพ์คำค้น USElection2020
    กด Enter
    ตรวจสอบ US Election 2020 - BBC News
    ปิด

*** Keywords ***
พิมพ์ google.com
    Open Browser   https://www.google.com    chrome
พิมพ์คำค้น USElection2020
    Input Text    name:q    USElection2020
กด Enter
    Press Keys    name:q    RETURN
ตรวจสอบ US Election 2020 - BBC News
    Page Should Contain    US Election 2020 - BBC News
    Click Link    US Election 2020 - BBC News
ปิด
    Close All Browsers