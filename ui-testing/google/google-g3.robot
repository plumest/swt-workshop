*** Settings ***
Resource              resource-g3.robot
Library               SeleniumLibrary

*** Test Case ***
Test search keyword and verify search result on Google
    พิมพ์ google.com
    พิมพ์คำค้น USElection2020
    กด Enter
    ตรวจสอบ US Election 2020 - BBC News
    ปิด Browsers