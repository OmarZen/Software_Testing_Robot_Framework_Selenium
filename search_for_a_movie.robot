*** Settings ***
Library           SeleniumLibrary
Library           Collections

*** Variables ***
${MovieName}      The Shawshank Redemption
${first_result}    ${EMPTY}


*** Test Cases ***
Search test one
    [Setup]    Open Browser    https://www.imdb.com/    FireFox
    input text    id = suggestion-search    ${MovieName}
    click element    id = suggestion-search-button
    ${first_result}    Get Text    class=ipc-metadata-list-summary-item__t
    Should Be Equal As Strings    ${MovieName}    ${first_result}
