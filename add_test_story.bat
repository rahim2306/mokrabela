@echo off
REM Firestore REST API - Add Test Story
REM Replace YOUR_PROJECT_ID and YOUR_API_KEY with your actual values

set PROJECT_ID=mokrabela-31058
set API_KEY=AIzaSyDMZioFPPWr27clxQtVGUrllTQhT7zYqaw

curl -X POST ^
  "https://firestore.googleapis.com/v1/projects/%PROJECT_ID%/databases/(default)/documents/stories?key=%API_KEY%" ^
  -H "Content-Type: application/json" ^
  -d "{\"fields\": {\"title\": {\"mapValue\": {\"fields\": {\"en\": {\"stringValue\": \"The Magical Forest\"}, \"ar\": {\"stringValue\": \"الغابة السحرية\"}, \"fr\": {\"stringValue\": \"La Forêt Magique\"}}}}, \"description\": {\"mapValue\": {\"fields\": {\"en\": {\"stringValue\": \"A story about a magical forest\"}, \"ar\": {\"stringValue\": \"قصة عن غابة سحرية\"}, \"fr\": {\"stringValue\": \"Une histoire sur une forêt magique\"}}}}, \"pages\": {\"arrayValue\": {\"values\": [{\"mapValue\": {\"fields\": {\"content\": {\"mapValue\": {\"fields\": {\"en\": {\"stringValue\": \"Once upon a time, there was a magical forest where trees could talk and animals could sing.\"}, \"ar\": {\"stringValue\": \"في قديم الزمان، كانت هناك غابة سحرية حيث يمكن للأشجار أن تتحدث والحيوانات أن تغني.\"}, \"fr\": {\"stringValue\": \"Il était une fois, une forêt magique où les arbres pouvaient parler et les animaux chanter.\"}}}}, \"imageUrl\": {\"stringValue\": \"\"}}}}]}}, \"gradientColors\": {\"arrayValue\": {\"values\": [{\"stringValue\": \"#9C27B0\"}, {\"stringValue\": \"#E91E63\"}]}}, \"icon\": {\"stringValue\": \"forest\"}, \"isActive\": {\"booleanValue\": true}, \"order\": {\"integerValue\": \"0\"}}}"

echo.
echo Story added! Check your Firebase Console.
pause
