# Team 31 Project Quality Assurance

#### Introduction

Our project, at its base, is a mental health support app with an interactive chatbot and mental health themed games. The objective of the app is to provide users with access to mental health services and information through a chatbot whilst also providing entertainment through games which encourage the users to learn and understand positive vocabulary.

#### Test Plans

We predominantly used manual testing, but have also implemented some unit tests. We used unit tests for features within the application.

#### Function: Login 

|Test|Inputs|Expected Outcome|Initial Test Result|2nd Test Result|3rd Test Result|
|----|------|----------------|-------------------|---------------|---------------|
|Login with correct details||Taken to Chatbot homepage||||
|Login with incorrect details||Unknown details error message is thrown||||
|Login with malicious unsanitised input, i.e. SQL injection||Input is sanitised, error message is thrown||||


#### Function: Journaling 

|Test|Inputs|Expected Outcome|Initial Test Result|2nd Test Result|3rd Test Result|
|----|------|----------------|-------------------|---------------|---------------|
|Press Journal icon in navigation from Journal|Press Journal Icon|Remain on Journal screen||||
|Press Journal icon in navigation from Help|Press Journal Icon|Taken to Journal screen||||
|Press Journal icon in navigation from Chatbot|Press Journal Icon|Taken to Journal screen||||
|Press Journal icon in navigation from Games|Press Journal Icon|Taken to Journal screen||||
|Press Journal icon in navigation from Profile|Press Journal Icon|Taken to Journal screen||||


#### Function: Help Page 

|Test|Inputs|Expected Outcome|Initial Test Result|2nd Test Result|3rd Test Result|
|----|------|----------------|-------------------|---------------|---------------|
|Press Help icon in navigation from Journal|Press Help Icon|Taken to Help screen||||
|Press Help icon in navigation from Help|Press Help Icon|Remain on Help screen||||
|Press Help icon in navigation from Chatbot|Press Help Icon|Taken to Help screen||||
|Press Help icon in navigation from Games|Press Help Icon|Taken to Help screen||||
|Press Help icon in navigation from Profile|Press Help Icon|Taken to Help screen||||


#### Function: Chatbot 

|Test|Inputs|Expected Outcome|Initial Test Result|2nd Test Result|3rd Test Result|
|----|------|----------------|-------------------|---------------|---------------|
|Press Chatbot icon in navigation from Journal|Press Chatbot Icon|Taken to Chatbot screen||||
|Press Chatbot icon in navigation from Help|Press Chatbot Icon|Taken to Chatbot screen||||
|Press Chatbot icon in navigation from Chatbot|Press Chatbot Icon|Remain Chatbot screen||||
|Press Chatbot icon in navigation from Games|Press Chatbot Icon|Taken to Chatbot screen||||
|Press Chatbot icon in navigation from Profile|Press Chatbot Icon|Taken to Chatbot screen||||


#### Function: Games 

|Test|Inputs|Expected Outcome|Initial Test Result|2nd Test Result|3rd Test Result|
|----|------|----------------|-------------------|---------------|---------------|
|Press Games icon in navigation from Journal|Press Games Icon|Taken to Games screen||||
|Press Games icon in navigation from Help|Press Games Icon|Taken to Games screen||||
|Press Games icon in navigation from Chatbot|Press Games Icon|Taken to Games screen||||
|Press Games icon in navigation from Games|Press Games Icon|Remain on Games screen||||
|Press Games icon in navigation from Profile|Press Games Icon|Taken to Games screen||||


#### Function: Profile 

|Test|Inputs|Expected Outcome|Initial Test Result|2nd Test Result|3rd Test Result|
|----|------|----------------|-------------------|---------------|---------------|
|Press Profile icon in navigation from Journal|Press Profile Icon|Taken to Profile screen||||
|Press Profile icon in navigation from Help|Press Profile Icon|Taken to Profile screen||||
|Press Profile icon in navigation from Chatbot|Press Profile Icon|Taken to Profile screen||||
|Press Profile icon in navigation from Games|Press Profile Icon|Taken to Profile screen||||
|Press Profile icon in navigation from Profile|Press Profile Icon|Remain on Profile screen||||
|Update password|Put in valid password and press confirm|Confirmation of updated password||||

