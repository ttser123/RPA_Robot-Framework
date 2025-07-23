*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser To Posts Page
Suite Teardown    Close Browser

*** Variables ***
${LOGIN_URL}      http://localhost:3000/auth/login
${POSTS_URL}      http://localhost:3000/posts
${EDIT_URL}       http://localhost:3000/posts/edit/1  
${INDEX_URL}      http://localhost:3000/index

*** Test Cases ***
Login As Admin
    Go To    ${LOGIN_URL}
    Input Text    name=username    user3
    Input Text    name=password    user3
    Click Button    xpath=//button[@type="submit"]
    Location Should Be    ${INDEX_URL}

Update First Post
    [Documentation]    ทดสอบแก้ไขโพสต์แรก
    Go To    ${POSTS_URL}
    Click Link    xpath=(//a[contains(@href,'/posts/edit')])[1]
    Input Text    name=title    โพสต์ที่ถูกแก้ไข
    Input Text    name=content  เนื้อหาใหม่หลังแก้ไข
    Click Button    xpath=//button[@type="submit"]
    Sleep    1s

*** Keywords ***
Open Browser To Posts Page
    Open Browser    ${POSTS_URL}    Chrome
    Maximize Browser Window
