*** Settings ***
Library           SeleniumLibrary
Library           RPA.Excel.Files
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser

*** Variables ***
${LOGIN_URL}      http://localhost:3000/auth/login   
${LOGOUT_URL}     http://localhost:3000/auth/logout

*** Test Cases ***
Login And Logout With Excel Data
    Open Workbook    ../users.xlsx
    ${rows}=    Read Worksheet As Table    header=True
    FOR    ${row}    IN    @{rows}
        Login And Logout    ${row}[username]    ${row}[password]
    END
    Close Workbook

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN_URL}    Chrome
    Maximize Browser Window

Login And Logout
    [Arguments]    ${username}    ${password}
    Go To    ${LOGIN_URL}
    Input Text    name=username    ${username}
    Input Text    name=password    ${password}
    Click Button    xpath=//button[@type="submit"]
    Sleep   2s
    # ตรวจสอบว่าล็อกอินสำเร็จหรือไม่ (ถ้ามี error ให้ข้าม logout)
    Run Keyword If    '${username}' != '' and '${password}' != ''    Run Keyword And Continue On Failure    Page Should Not Contain    ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง
    # ไปหน้า logout
    Go To    ${LOGOUT_URL}
    Sleep   1s