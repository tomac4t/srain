#!/usr/bin/python3
import sys, os, json, requests
from requests.exceptions import Timeout

# It should set env variable on the github actions files:
#      env: |
#        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
#        GITHUB_REPOSITORY: ${{ GITHUB_REPOSITORY }}
# https://github.community/t5/GitHub-Actions/Unable-to-access-GITHUB-TOKEN/td-p/41184
GITHUB_TOKEN = os.environ["GITHUB_TOKEN"];
GITHUB_REPOSITORY = os.environ["GITHUB_REPOSITORY"];

# https://developer.github.com/v3/repos/releases
RELEASES_API = "https://api.github.com/repos/" + GITHUB_REPOSITORY + "/releases";

# `text/plain` is the default value for textual files. 
# `application/octet-stream` is the default value for all 
# other cases. An unknown file type should use this type.
MINETYPE = "application/octet-stream"

def get_uploadurl():
  global UPLOAD_URL;

  headers = {
    'Authorization': 'token ' + GITHUB_TOKEN,
  }

  try:
    response = requests.get(RELEASES_API, headers=headers);
  
  except Timeout:
    print("\033[1;31;40mThe request failed: " + RELEASES_API + "\033[0m");
    sys.exit(1);

  UPLOAD_URL = response.json()[0]["upload_url"].replace(u'{?name,label}','');

  print("Releases API: "+ RELEASES_API + "\nUpload URL: "+ UPLOAD_URL);


def upload_assets():
  OUT_FILES = os.listdir(r'out/');
  OUT_FILES_NUMBER = len(OUT_FILES);
  print("Assets: " + str(OUT_FILES[0]) + "\nAssets number: " + str(OUT_FILES_NUMBER));
  
  for i in range (0, OUT_FILES_NUMBER):
    FILENAME = OUT_FILES[i];
    print("Current asset: " + FILENAME);

    # Upload a release asset
    # https://developer.github.com/v3/repos/releases/#upload-a-release-asset
    headers = {
      'Authorization': 'token ' + GITHUB_TOKEN,
      'Content-Type': MINETYPE,
    }

    params = (
      ('name', FILENAME),
    )
  
    data = open("out/" + FILENAME, 'rb').read();

    try:
      response = requests.post(UPLOAD_URL, headers=headers, params=params, data=data);

    except Timeout:
      print('\033[1;31;40mThe request failed: ' + UPLOAD_URL + "\033[0m");
      sys.exit(1);

    print("debug: " + str(response.status_code));
    print("debug:\n" + str(response.text));

    # Response for successful upload: 201 Created
    # https://developer.github.com/v3/repos/releases/#response-for-successful-upload
    if response.status_code == 201:
      print("\033[1;32;40m" + FILENAME + ": success.\033[0m");
    
    else:
      print("\033[1;31;40m" + FILENAME + ": fail.\033[0m");
      sys.exit(1);
  
get_uploadurl();
upload_assets();