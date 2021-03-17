*** Settings ***
Documentation     Working with HTML tables.
Library           html_tables.py
Library           RPA.Browser.Selenium
Library           RPA.Tables
Task Teardown     Close All Browsers

*** Keywords ***
Get HTML table
    Open Available Browser
    ...    https://www.w3schools.com/html/html_tables.asp
    ...    headless=True
    ${html_table}=    Get Element Attribute    css:table#customers    outerHTML
    [Return]    ${html_table}

*** Tasks ***
Read HTML table as Table
    ${html_table}=    Get HTML table
    ${table}=    Read Table From Html    ${html_table}
    ${dimensions}=    Get Table Dimensions    ${table}
    ${first_row}=    Get Table Row    ${table}    ${0}
    ${first_cell}=    RPA.Tables.Get Table Cell    ${table}    ${0}    ${0}
    FOR    ${row}    IN    @{table}
        Log To Console    ${row}
    END
