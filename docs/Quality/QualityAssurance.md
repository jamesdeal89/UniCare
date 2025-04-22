1. Introduction
Our project at its base is a mental health app with a chatbot and mental health themed games.

2. Test Plans
We used mostly manual tests but we have also implemented some unit tests. We used unit tests for features

#### Function: Login 

|Test|Inputs|Expected Outcome|Initial Test Result|2nd Test Result|3rd Test Result|
|----|------|----------------|-------------------|---------------|---------------|
|Login with correct details|Username: demo@nottingham.ac.uk Password: TEST123|Taken to Chatbot homepage||||
|Login with correct username and incorrect password|Username: demo@nottingham.ac.uk Password: TEST1234|Appropriate Error Message||||
|Login with incorrect username and incorrect password|Username: demo1@nottingham.ac.uk Password: TEST1234|Appropriate Error Message||||
|Login with no username and a password|Username: demo@nottingham.ac.uk Password: TEST1234|Appropriate Error Message||||

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
|NHS Icon leads to NHS website|Press NHS button|Linked to NHS mental health help||||
|Samaritans Icon leads to Samaritans website|Press Samaritans button|Linked to Samaritans website||||
|Mind Icon leads to Mind website|Press Mind button|Linked to Mind mental health help||||


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


