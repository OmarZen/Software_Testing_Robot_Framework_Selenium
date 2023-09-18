*** Settings ***
Library           SeleniumLibrary
Library           Collections

*** Variables ***
${MovieName_Search}    The Shawshank Redemption
${first_result_Search}    ${EMPTY}
${first_movie_Top_Rated}    ${EMPTY}
${Excepected_Top_Rated}    The Shawshank Redemption
${start_year}     2010
${end_year}       2020
${Rates_Elements}    ${EMPTY}
${Original_Rates}    ${EMPTY}
${Rates_Element}    ${EMPTY}
@{Rates_Elements}
${Rate_Attr}      ${EMPTY}
${Copied_Rates}    ${EMPTY}


*** Test Cases ***
search for a movie on the IMDb
    [Setup]    Open Browser    https://www.imdb.com/    FireFox
    input text    id = suggestion-search    ${MovieName_Search}
    click element    id = suggestion-search-button
    ${first_result_Search}    Get Text    class=ipc-metadata-list-summary-item__t
    Should Be Equal As Strings    ${MovieName_Search}    ${first_result_Search}
    [Teardown]    Close Browser

Top-Rated
    [Setup]    Open Browser    https://www.imdb.com/    FireFox
    click element    id = imdbHeader-navDrawerOpen
    Click Link    Top 250 Movies
    wait until page contains Element    class=header
    ${first_movie_Top_Rated}    Get Text    (//td[@class="titleColumn"]/a)[1]
    Should Be Equal As Strings    ${first_movie_Top_Rated}    ${Excepected_Top_Rated}
    [Teardown]    Close Browser

search for movies released in a specific year
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
    [Teardown]    Close Browser
