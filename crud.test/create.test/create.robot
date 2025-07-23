*** Settings ***
Library           SeleniumLibrary
Library           RPA.Excel.Files
Suite Setup       Open Browser To Index Page
Suite Teardown    Close Browser

*** Variables ***
${LOGIN_URL}      http://localhost:3000/auth/login
${INDEX_URL}      http://localhost:3000/index
${ADD_URL}        http://localhost:3000/posts/add
${POSTS_URL}      http://localhost:3000/posts

*** Test Cases ***
Login As Admin
    Go To    ${LOGIN_URL}
    Input Text    name=username    admin
    Input Text    name=password    admin
    Click Button    xpath=//button[@type="submit"]
    Location Should Be    ${INDEX_URL}

Create Posts From Excel
    Open Workbook    ../crud.xlsx
    ${rows}=    Read Worksheet As Table    header=True
    FOR    ${row}    IN    @{rows}
        Create Post    ${row}[title]    ${row}[content]    ${row}[category_id]
    END
    Close Workbook

*** Keywords ***
Open Browser To Index Page
    Open Browser    ${INDEX_URL}    Chrome
    Maximize Browser Window

Create Post
    [Arguments]    ${title}    ${content}    ${category_id}
    Go To    ${ADD_URL}
    Input Text    name=title    ${title}
    Input Text    name=content  ${content}
    Select From List By Value    name=category_id    ${category_id}
    Click Button    xpath=//button[@type="submit"]
    Sleep    2s