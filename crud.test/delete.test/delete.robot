*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser To Posts Page
Suite Teardown    Close Browser

*** Variables ***
${LOGIN_URL}      http://localhost:3000/auth/login
${POSTS_URL}      http://localhost:3000/posts

*** Test Cases ***
Login As Admin
    Go To    ${LOGIN_URL}
    Input Text    name=username    user3
    Input Text    name=password    user3
    Click Button    xpath=//button[@type="submit"]
    Location Should Be    http://localhost:3000/index

Delete First Post
    [Documentation]    ทดสอบลบโพสต์แรก
    Go To    ${POSTS_URL}
    ${title}=    Get Text    xpath=(//div[contains(@class,'post')])[1]//h2
    Click Button    xpath=(//button[contains(normalize-space(),"ลบ")])[1]
    Run Keyword And Ignore Error    Handle Alert    ACCEPT
    Sleep    1s
    Go To    ${POSTS_URL}
    Page Should Not Contain    ${title}

*** Keywords ***
Open Browser To Posts Page
    Open Browser    ${POSTS_URL}    Chrome
    Maximize Browser Window
