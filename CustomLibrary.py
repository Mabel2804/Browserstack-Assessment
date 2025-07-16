import os
import requests

class CustomLibrary:
    def download_file(self, url, filepath):
        """Download a file from the specified URL to the given filepath.

        Takes a list of titles.
        Translates each title into the target language using the DeepL API.
        Returns a list of translated titles."""

        response = requests.get(url, stream=True)
        response.raise_for_status()
        with open(filepath, 'wb') as file:
            for chunk in response.iter_content(chunk_size=8192):
                file.write(chunk)
        return f"File downloaded to: {filepath}"

    def translate_text(self, text, target_lang, api_url, auth_key):
        """
        Translates text using the DeepL API.

        :param text: Text to translate
        :param target_lang: Target language code (e.g., "EN", "DE")
        :param api_url: DeepL API URL
        :param auth_key: DeepL API Auth Key
        :return: Translated text

        Takes a list of translated titles.
        Breaks titles into individual words.
        Counts how often each word appears.
        Returns a dictionary of words that appear more than once with their frequency.
        """
        headers = {
            "Authorization": f"DeepL-Auth-Key {auth_key}"
        }
        data = {
            "text": text,
            "target_lang": target_lang
        }
        response = requests.post(api_url, headers=headers, data=data)

        if response.status_code != 200:
            raise Exception(f"DeepL API call failed: {response.status_code} - {response.text}")

        result = response.json()
        try:
            return result["translations"][0]["text"]  # Extract translated text
        except KeyError:
            raise Exception(f"Translation failed: {result}")