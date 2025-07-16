*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    OperatingSystem
Library    String
Resource   ../Resources/keywords.robot
Resource   ../Variables/variables.robot
Resource   ../Resources/locators.robot

#This test script validates the following scenarios:
 #1. Ensures that the website's text is displayed in Spanish.
 #2. Fetches the first five articles in the Opinion section.
 #3. Prints the title and content of each article in Spanish.
 #4. Downloads and saves the cover image of each article into the local machine.
 #5. Translates and Prints the title of each article to English.
 #6. From the translated headers, identifies any words that are repeated more than twice across all headers combined.

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