*** Settings ***
Library           SeleniumLibrary
Library           Collections

*** Variables ***
${MovieName}      The Shawshank Redemption
${first_movie}    ${EMPTY}


*** Test Cases ***
Top Rated test one
    [Setup]    Open Browser    https://www.imdb.com/    FireFox
    click element    id = imdbHeader-navDrawerOpen
    Click Link    Top 250 Movies
    wait until page contains Element    class=header
    ${first_movie}    Get Text    (//td[@class="titleColumn"]/a)[1]
    Should Be Equal As Strings    ${first_movie}    The Shawshank Redemption
