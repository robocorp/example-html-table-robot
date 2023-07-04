*** Settings ***
Documentation       Working with HTML tables.

Library             html_tables.py
Library             RPA.Browser.Selenium
Library             RPA.Browser.Playwright    WITH NAME    Playwright
Library             RPA.Tables    WITH NAME    Tables

Task Teardown       Close All Brower Sessions


*** Variables ***
${TABLES_PAGE}      https://www.w3schools.com/html/html_tables.asp


*** Tasks ***
Read HTML table as Table - Selenium
    ${html_table}=    Get HTML table with Selenium
    ${table}=    Read Table From Html    ${html_table}
    Log Table Elements    ${table}

Read HTML table as Table - Playwright
    ${html_table}=    Get HTML table with Playwright
    ${table}=    Read Table From Html    ${html_table}
    Log Table Elements    ${table}


*** Keywords ***
Get HTML table with Selenium
    Open Available Browser
    ...    ${TABLES_PAGE}
    ...    headless=True
    ${html_table}=    Get Element Attribute    css:table#customers    outerHTML
    RETURN    ${html_table}

Get HTML table with Playwright
    New Browser
    New Page    ${TABLES_PAGE}
    ${html_table}=    Get Property    css=table#customers    outerHTML
    RETURN    ${html_table}

Log Table Elements
    [Arguments]    ${table}
    ${dimensions}=    Get Table Dimensions    ${table}
    Log    \nTable dimensions: ${dimensions}    console=${True}
    ${first_row}=    Get Table Row    ${table}    ${0}
    Log    First row: ${first_row}    console=${True}
    ${first_cell}=    Tables.Get Table Cell    ${table}    ${0}    ${0}
    Log    First cell: ${first_cell}    console=${True}
    FOR    ${row}    IN    @{table}
        Log    ${row}    console=${True}
    END

Close All Brower Sessions
    Close All Browsers    # Selenium
    Playwright.Close Browser    ALL    # Playwright
