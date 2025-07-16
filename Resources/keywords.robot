*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    OperatingSystem
Library    Collections
Library    Browser
Library    String
Library    ../CustomLibrary.py
Resource   ../Variables/variables.robot
Resource   ../Resources/locators.robot

*** Keywords ***

Open Browser And Navigate
    [Arguments]    ${url}
    SeleniumLibrary.Open Browser    ${url}    chrome
    Maximize Browser Window
    Handle Popup If Exists

Validate Website Language
    Handle Popup If Exists
    Wait Until Page Contains Element    xpath://html
    ${language}=    Get Element Attribute    xpath://html    lang
    Log    The detected language is: ${language}
    Should Be Equal As Strings    ${language}    es-ES

Handle Popup If Exists
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${POPUP_CLOSE}    5 seconds
    Run Keyword And Ignore Error    Wait Until Element Is Enabled    ${POPUP_CLOSE}    5 seconds
    Run Keyword And Ignore Error    Click Element    ${POPUP_CLOSE}

Click Opinion Section
    [Arguments]    ${opinion_link}
    Handle Popup If Exists
    Click Element    ${opinion_link}

Fetch Article Details
    [Documentation]    Fetches the first five articles from the Opinion section
    ${titles_elements}=    Get WebElements    ${ARTICLE_TITLE}
    ${contents_elements}=    Get WebElements    ${ARTICLE_CONTENT}
    ${images_elements}=    Get WebElements    ${COVER_IMAGE}
    Log    Titles Elements: ${titles_elements}
    ${titles}=    Create List
    ${contents}=    Create List
    ${image_urls}=    Create List
    FOR    ${index}    IN RANGE    0    5
        ${title}=        SeleniumLibrary.Get Text    ${titles_elements[${index}]}
        ${content}=      SeleniumLibrary.Get Text    ${contents_elements[${index}]}
        ${image_src}=    Get Element Attribute    ${images_elements[${index}]}    src
        Append To List   ${titles}    ${title}
        Append To List   ${contents}    ${content}
        Append To List   ${image_urls}    ${image_src}
    END
    Log    Titles: ${titles}
    Log    Contents: ${contents}
    Log    Image URLs: ${image_urls}
    RETURN    ${titles}    ${contents}    ${image_urls}

Download Images
    [Arguments]    @{image_urls}
    Log To Console    Starting Image Download Process...
    Create Directory    ${DOWNLOADS_DIR}
    ${index}=    Set Variable    1
    FOR    ${url}    IN    @{image_urls}
            Log To Console    Processing Image URL: ${url}
            ${filename}=    Set Variable    Image${index}.jpg
            ${filepath}=    Evaluate    os.path.join('${DOWNLOADS_DIR}', '${filename}')
            Run Keyword If    '${url}' != ''    CustomLibrary.Download File    ${url}    ${filepath}
            Log To Console    Downloaded Image to: ${filepath}
            ${index}=    Evaluate    ${index} + 1
    END

Translate Article Titles
    [Arguments]    @{titles}
    Log To Console    Titles to Translate: ${titles} #Debugging Purpose
    ${translated_titles}=    Create List
    FOR    ${title}    IN    @{titles}
        Log To Console    Translating Title: ${title}
        ${translation}=    Evaluate    CustomLibrary.CustomLibrary().translate_text("${title}", "${TARGET_LANGUAGE}", "https://api-free.deepl.com/v2/translate", "${DEEPL_API_KEY}")    modules=CustomLibrary
        Log To Console    Translated Title: ${translation}
        Append To List    ${translated_titles}    ${translation}
    END
    Log To Console    Translated Titles: ${translated_titles}
    Log               Translated Titles: ${translated_titles}
    RETURN    ${translated_titles}


Analyze Translations
    [Arguments]    @{titles}
    Log To Console    Titles Received for Analysis: ${titles}
    ${all_words}=    Evaluate    [word.lower().strip(",.") for title in @{titles} for word in title.split()]
    Log To Console    All Words Extracted: ${all_words}
    ${repeated_words}=    Create Dictionary
    FOR    ${word}    IN    @{all_words}
        ${count}=    Count Values In List    ${all_words}    ${word}
        Log To Console    Word: ${word}, Count: ${count}
        Run Keyword If    ${count} > 1    Set To Dictionary    ${repeated_words}    ${word}    ${count}
    END
    Log To Console    Repeated Words: ${repeated_words}
    Log               Repeated Words: ${repeated_words}
    RETURN    ${repeated_words}

