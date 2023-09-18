*** Settings ***
Library           SeleniumLibrary
Library           Collections

*** Variables ***
${start_year}     2010
${end_year}       2020
${Rates_Elements}    ${EMPTY}
${Original_Rates}    ${EMPTY}
${Rates_Element}    ${EMPTY}
${Rate_Attr}      ${EMPTY}
${Copied_Rates}    ${EMPTY}
@{Rates_Elements}




*** Test Cases ***
search_in_a_specific_year
    [Setup]    Open Browser    https://www.imdb.com/    FireFox
    click element    class=ipc-btn__text
    Wait Until Element is Visible    id=iconContext-find-in-page
    click element    id=iconContext-find-in-page
    wait until page contains Element    id=header
    click link    Advanced Title Search
    wait until page contains Element    id=header
    Select Checkbox    id=title_type-1
    Select Checkbox    id=genres-1
    input text    name=release_date-min    ${start_year}
    input text    name=release_date-max    ${end_year}
    Select From List By Value    name=sort    user_rating,desc
    click element    class=primary
    wait until page contains Element    class=header
    ${Rates_Elements}=    Get WebElements    //div[@class="inline-block ratings-imdb-rating" and @name="ir"]/strong
    ${Original_Rates}=    Create List
    FOR    ${Rates_Element}    IN    @{Rates_Elements}
        ${Rate_Attr}=    Get Text    ${Rates_Element}
        ${Rate_Attr}=    convert to number    ${Rate_Attr.strip('$')}
        Append To List    ${Original_Rates}    ${Rate_Attr}
    END
    ${Copied_Rates}=    Copy List    ${Original_Rates}
    Sort List    ${Copied_Rates}
    reverse list    ${Copied_Rates}
    Lists Should Be Equal    ${Copied_Rates}    ${Original_Rates}
