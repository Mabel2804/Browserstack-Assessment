*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    OperatingSystem
Library    String
Resource   ../Resources/keywords.robot
Resource   ../Variables/variables.robot
Resource   ../Resources/locators.robot

*** Test Cases ***

Verify Opinion Articles Workflow
    Open Browser And Navigate    ${BASE_URL}
    Validate Website Language
    Click Opinion Section    ${OPINION_LINK}
    ${titles}    ${contents}    ${image_urls}=    Fetch Article Details
    Log To Console    Titles: ${titles}
    Log To Console    Contents: ${contents}
    Log To Console    Image URLs: ${image_urls}
    Download Images    @{image_urls}
    ${translated_titles}=    Translate Article Titles    @{titles}
    Log To Console    Translated Titles: ${translated_titles}
    ${repeated_words}=    Analyze Translations    @{translated_titles}
    Log To Console    Repeated Words: ${repeated_words}
    SeleniumLibrary.Close Browser