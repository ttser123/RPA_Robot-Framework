*** Settings ***
Library           SeleniumLibrary
Library           RPA.Excel.Files
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser

*** Variables ***
${LOGIN_URL}      http://localhost:3000/auth/login   

*** Test Cases ***
Login With Excel Data
    Open Workbook    ../users.xlsx
    ${rows}=    Read Worksheet As Table    header=True
    FOR    ${row}    IN    @{rows}
        Login And Check Result    ${row}[username]    ${row}[password]
    END
    Close Workbook

Login With Invalid Username
    [Documentation]    กรณี username ไม่ถูกต้อง
    Go To    ${LOGIN_URL}
    Input Text    name=username    wronguser
    Input Text    name=password    admin
    Click Button    xpath=//button[@type="submit"]
    Page Should Contain    ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง

Login With Invalid Password
    [Documentation]    กรณี password ไม่ถูกต้อง
    Go To    ${LOGIN_URL}
    Input Text    name=username    user1
    Input Text    name=password    wrongpassword
    Click Button    xpath=//button[@type="submit"]
    Page Should Contain    ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง

Login With Empty Fields
    [Documentation]    กรณีกรอกช่องว่าง/ไม่กรอกข้อมูล
    Go To    ${LOGIN_URL}
    Click Button    xpath=//button[@type="submit"]
    Location Should Be    ${LOGIN_URL}

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN_URL}    Chrome
    Maximize Browser Window

Login And Check Result
    [Arguments]    ${username}    ${password}
    Input Text    name=username    ${username}
    Input Text    name=password    ${password}
    Click Button    xpath=//button[@type="submit"]
    Sleep   2s
    
    # ตรวจสอบว่าล็อกอินสำเร็จหรือไม่ (เช่น มี redirect ไปหน้า index หรือมีข้อความ error)
    Run Keyword And Continue On Failure    Page Should Not Contain    ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง
    Go To    ${LOGIN_URL}   