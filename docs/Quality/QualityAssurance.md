# Team 31 Project Quality Assurance

#### Introduction

Our project, at its base, is a mental health support app with an interactive chatbot and mental health themed games. The objective of the app is to provide users with access to mental health services and information through a chatbot whilst also providing entertainment through games which encourage the users to learn and understand positive vocabulary.

#### Test Plans

We predominantly used manual testing, but have also implemented some unit tests. We used unit tests for features within the application.

#### Function: Login 

|Test ID|Test|Inputs|Expected Outcome|Initial Test Result|2nd Test Result|3rd Test Result|
|----|------|----------------|-------------------|---------------|---------------|---------------|
|1.1|Login with correct details||Taken to Chatbot homepage||||
|1.2|Login with incorrect details||Unknown details error message is thrown||||
|1.3|Login with malicious unsanitised input, i.e. SQL injection||Input is sanitised, error message is thrown||||


#### Function: Journaling 

|Test ID|Test|Inputs|Expected Outcome|Initial Test Result|2nd Test Result|3rd Test Result|
|----|------|----------------|-------------------|---------------|---------------|---------------|
|2.1|Press Journal icon in navigation from Journal|Press Journal Icon|Remain on Journal screen||||
|2.2|Press Journal icon in navigation from Help|Press Journal Icon|Taken to Journal screen||||
|2.3|Press Journal icon in navigation from Chatbot|Press Journal Icon|Taken to Journal screen||||
|2.4|Press Journal icon in navigation from Games|Press Journal Icon|Taken to Journal screen||||
|2.5|Press Journal icon in navigation from Profile|Press Journal Icon|Taken to Journal screen||||


#### Function: Help Page 

|Test ID|Test|Inputs|Expected Outcome|Initial Test Result|2nd Test Result|3rd Test Result|
|----|------|----------------|-------------------|---------------|---------------|----|
|3.1|Press Help icon in navigation from Journal|Press Help Icon|Taken to Help screen||||
|3.2|Press Help icon in navigation from Help|Press Help Icon|Remain on Help screen||||
|3.3|Press Help icon in navigation from Chatbot|Press Help Icon|Taken to Help screen||||
|3.4|Press Help icon in navigation from Games|Press Help Icon|Taken to Help screen||||
|3.5|Press Help icon in navigation from Profile|Press Help Icon|Taken to Help screen||||
|3.6|Press "Tap for details" on individual charity element|Press Tap for details label|Charity information popup appears||||
|3.6.1|Press information on charity information popup|Press URL|Taken to chosen charity's website||||


#### Function: Chatbot 

|Test ID|Test|Inputs|Expected Outcome|Initial Test Result|2nd Test Result|3rd Test Result|
|----|------|----------------|-------------------|---------------|---------------|---------------|
|4.1|Press Chatbot icon in navigation from Journal|Press Chatbot Icon|Taken to Chatbot screen||||
|4.2|Press Chatbot icon in navigation from Help|Press Chatbot Icon|Taken to Chatbot screen||||
|4.3|Press Chatbot icon in navigation from Chatbot|Press Chatbot Icon|Remain Chatbot screen||||
|4.4|Press Chatbot icon in navigation from Games|Press Chatbot Icon|Taken to Chatbot screen||||
|4.5|Press Chatbot icon in navigation from Profile|Press Chatbot Icon|Taken to Chatbot screen||||


#### Function: Games 

|Test ID|Test|Inputs|Expected Outcome|Initial Test Result|2nd Test Result|3rd Test Result|
|----|------|----------------|-------------------|---------------|---------------|---------------|
|5.1|Press Games icon in navigation from Journal|Press Games Icon|Taken to Games screen||||
|5.2|Press Games icon in navigation from Help|Press Games Icon|Taken to Games screen||||
|5.3|Press Games icon in navigation from Chatbot|Press Games Icon|Taken to Games screen||||
|5.4|Press Games icon in navigation from Games|Press Games Icon|Remain on Games screen||||
|5.5|Press Games icon in navigation from Profile|Press Games Icon|Taken to Games screen||||


#### Function: Profile 

|Test ID|Test|Inputs|Expected Outcome|Initial Test Result|2nd Test Result|3rd Test Result|
|----|------|----------------|-------------------|---------------|---------------|---------------|
|6.1|Press Profile icon in navigation from Journal|Press Profile Icon|Taken to Profile screen||||
|6.2|Press Profile icon in navigation from Help|Press Profile Icon|Taken to Profile screen||||
|6.3|Press Profile icon in navigation from Chatbot|Press Profile Icon|Taken to Profile screen||||
|6.4|Press Profile icon in navigation from Games|Press Profile Icon|Taken to Profile screen||||
|6.5|Press Profile icon in navigation from Profile|Press Profile Icon|Remain on Profile screen||||
|6.6|Update password|Put in valid password and press confirm|Confirmation of updated password||||

