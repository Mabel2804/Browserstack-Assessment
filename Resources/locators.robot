*** Settings ***
Library    SeleniumLibrary

*** Variables ***

${OPINION_LINK}          css:a[href*='opinion']
${ARTICLE_TITLE}         xpath://article//h2[contains(@class, 'c_t')]
${ARTICLE_CONTENT}       xpath://article//p[contains(@class, 'c_d')]
${COVER_IMAGE}           xpath://article//img
${POPUP_CLOSE}           xpath=//*[@id="didomi-notice-agree-button"]