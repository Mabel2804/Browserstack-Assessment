# BrowserStackProject
This project is part of BrowserStack Tech Assessment


## Features
- Validates that the website displays text in Spanish.
- Fetches and validates the first five opinion articles, including titles, content, and images.
- Translates article titles using the DeepL API.
- Identifies repeated words in translated titles.
- Cross-browser testing with BrowserStack integration.

## Prerequisites
- Python 3.13 or later
- Robot Framework
- SeleniumLibrary
- RequestsLibrary
- BrowserStack SDK
- DeepL API Key

## Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/your-repository.git
   ```
2. Navigate to the project directory:
   ```bash
   cd your-repository
   ```
3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

## Usage
1. Update the `variables.robot` file with your API keys and configuration settings.
2. Run the tests locally:
   ```bash
   robot tests/test_opinion.robot
   ```
3. Execute cross-browser tests on BrowserStack:
   ```bash
   browserstack-sdk robot --outputdir reports tests/test_opinion.robot
   ```

## Project Structure
- `tests/`: Contains test cases.
- `keywords/`: Custom keywords and reusable logic.
- `variables.robot`: Stores global variables and configuration settings.
- `locators.robot`: Stores web element locators.
- `README.md`: Project documentation.

## Known Issues
- Playwright connection errors during BrowserStack integration for Safari.
- StaleElementReferenceException during cross-browser tests for certain configurations.

## Troubleshooting
- **API Certificate Errors**:
  - Ensure all certificates are installed correctly.
  - Run the following command for Python certificate updates:
    ```bash
    /Applications/Python\ <version>/Install\ Certificates.command
    ```

- **UnboundLocalError in BrowserStack Listener**:
  - Ensure proper initialization of all variables.
  - Update listener code to handle session closures gracefully.

- **StaleElementReferenceException**:
  - Refresh the element reference before retrying interactions.

## Contributors
- Mabel Peter

