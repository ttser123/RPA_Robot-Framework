*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser To Register Page
Suite Teardown    Close Browser

*** Variables ***
${REGISTER_URL}   http://localhost:3000/auth/register

*** Test Cases ***
Register Success
    [Documentation]    สมัครสมาชิกสำเร็จ
    Input Text    name=email    user4@gmail.com
    Input Text    name=username    user4
    Input Text    name=password    user4
    Input Text    name=confirm_password    user4
    Input Text    name=f_name    user4
    Input Text    name=l_name    user4
    Input Text    name=phone    0957743131
    Click Button    xpath=//button[@type="submit"]
    Page Should Contain    ลงชื่อเข้าใช้

Register Duplicate Username Or Email
    [Documentation]    สมัครซ้ำ (username/email ซ้ำ)
    Go To    ${REGISTER_URL}
    Input Text    name=email    user1@gmail.com
    Input Text    name=username    user1
    Input Text    name=password    user1
    Input Text    name=confirm_password    user1
    Input Text    name=f_name    user1
    Input Text    name=l_name    user1
    Input Text    name=phone    0812345678
    Click Button    xpath=//button[@type="submit"]
    Location Should Be    ${REGISTER_URL}

Register With Missing Fields
    [Documentation]    กรอกข้อมูลไม่ครบ
    Click Button    xpath=//button[@type="submit"]
    Location Should Be    ${REGISTER_URL}

Register With Invalid Email
    [Documentation]    กรอก email ไม่ถูกต้อง
    Input Text    name=email    not-an-email
    Input Text    name=username    testuser_invalid
    Input Text    name=password    1234
    Input Text    name=confirm_password    1234
    Input Text    name=f_name    ทดสอบ
    Input Text    name=l_name    ผู้ใช้
    Input Text    name=phone    0812345678
    Click Button    xpath=//button[@type="submit"]
    Location Should Be    ${REGISTER_URL}

*** Keywords ***
Open Browser To Register Page
    Open Browser    ${REGISTER_URL}    Chrome
    Maximize Browser Window 