*** Settings ***
Resource              resource-t1.robot
Library               SeleniumLibrary

*** Test Case ***
Test post the content on Twitter
    Open twitter.com
    Waiting for loading    //*[@id="react-root"]/div/div/div/main/div/div/div/div[1]/div[1]/div/form/div/div[1]/div/label/div/div[2]/div/input
    Login to twitter.com
    Posting the Content
    Close Browsers