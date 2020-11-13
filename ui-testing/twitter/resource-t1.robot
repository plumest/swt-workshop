*** Variables ***
${EMAIL}              <YOUR_EMAIL>
${SECRET}             <YOUR_PASSWORD>
${URL}                https://twitter.com/
${BROWSER}            chrome
${KEYWORD}            สวัสดี Robot Framework

*** Keywords ***
Open twitter.com
    Open Browser                        ${URL}        ${BROWSER}
Waiting for loading
    [Arguments]    ${PATH}
    Wait Until Page Contains Element    xpath:${PATH}
Login to twitter.com
    Input Text                          name:session[username_or_email]      ${EMAIL}
    Input Text                          name:session[password]               ${SECRET}
    Press Keys                          name:session[password]               RETURN
Posting the Content
    Press Keys                          None    n
    Press Keys                          None    ${KEYWORD}
    Press Keys                          None    COMMAND+ENTER
Close Browsers
    Close All Browsers   