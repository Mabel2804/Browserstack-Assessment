*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    OperatingSystem
Library    String


*** Variables ***

${BASE_URL}              https://elpais.com/
${TRANSLATE_API_URL}     https://google-api31.p.rapidapi.com/translate
${DEEPL_API_KEY}         5652ee97-1aea-4287-99cc-8f267ed58c16:fx
${TARGET_LANGUAGE}       EN
${DOWNLOADS_DIR}         ${EXECDIR}/Downloads

