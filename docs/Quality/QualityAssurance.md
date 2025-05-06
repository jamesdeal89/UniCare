# Quality Assurance
### Introduction
Our project at its base is a mental health app with a chatbot and mental health themed games. The objective of the app is to provide users with access to mental health services and information through a chatbot whilst also providing entertainment through games which encourage the users to learn and understand positive vocabulary.

#### The importance of quality assurance
Quality assurance is essential for a successful project. We need to be very thorough in ensuring that there are no major bugs in the app as new versions come out and that the app runs correctly across multiple use cases. We have done very extensive isolation testing to ensure that the app works as intended as we continue to add new features.

The first set of testing was after integration was fully completed. The Journal screens and profile screens were updated for the second set of testing.
#### Test Plans
We used manual tests as a way to test app functionality in a way that the user would be able to achieve.

#### Feature: Login 

|Test ID|Test|Inputs|Expected Outcome|Initial Test Result|2nd Test Result|3rd Test Result|
|----|------|----------------|-------------------|---------------|---------------|---------------|
|1.1|Login with correct details|Username: demo@nottingham.ac.uk Password: TEST1234|Taken to Chatbot homepage|Passed|||
|1.2|Login with correct email and incorrect password|Username: demo@nottingham.ac.uk Password: TEST1234|Appropriate Error Message|Passed|||
|1.3.1|Login with incorrect email and incorrect password|Username: demo2@nottingham.ac.uk Password: TEST1234|Appropriate Error Message|Passed|||
|1.3.2|Login with valid email and incorrect password|Username: demo1@nottingham.ac.uk Password: TEST1234|Appropriate Error Message|Passed|||
|1.3.3|Login with incorrect email and valid password|Username: demo2@nottingham.ac.uk Password: TEST123|Appropriate Error Message|Passed|||
|1.4.1|Login with no email and a password|Username:  Password: TEST1234|Appropriate Error Message|Passed|||
|1.4.2|Login with valid email and no password|Username: demo1@nottingham.ac.uk Password: |Appropriate Error Message|Passed|||
|1.5|Login with malicious unsanitised input, i.e. SQL injection||Input is sanitised, error message is thrown|Passed|||


#### Function: Journaling 

|Test ID|Test|Inputs|Expected Outcome|Initial Test Result|2nd Test Result|3rd Test Result|
|----|------|----------------|-------------------|---------------|---------------|---------------|
|2.1|Press Journal icon in navigation from Journal|Press Journal Icon|Remain on Journal screen|Passed|||
|2.2|Press Journal icon in navigation from Help|Press Journal Icon|Taken to Journal screen|Passed|||
|2.3|Press Journal icon in navigation from Chatbot|Press Journal Icon|Taken to Journal screen|Passed|||
|2.4|Press Journal icon in navigation from Games|Press Journal Icon|Taken to Journal screen|Passed|||
|2.5|Press Journal icon in navigation from Profile|Press Journal Icon|Taken to Journal screen|Passed|||
|2.6|Create a journal entry|Press create journal icon and input text|Entry is displayed on jorunal screen|Failed|Passed|
|2.7|View a previous journal entry|Press previous journal entry|Entry is displayed on screen|Failed|Passed|
|2.8|View information on habits|Press info tab on journal tab|Habit information is displayed|Failed|Passed|
|2.9|Delete a previous journal entry|Press previous journal entry and press delete|Old journal screen is no longer displayed|Failed|Passed|

#### Function: Help Page 

|Test ID|Test|Inputs|Expected Outcome|Initial Test Result|2nd Test Result|3rd Test Result|
|----|------|----------------|-------------------|---------------|---------------|----|
|3.1|Press Help icon in navigation from Journal|Press Help Icon|Taken to Help screen|Passed|||
|3.2|Press Help icon in navigation from Help|Press Help Icon|Remain on Help screen|Passed|||
|3.3|Press Help icon in navigation from Chatbot|Press Help Icon|Taken to Help screen|Passed|||
|3.4|Press Help icon in navigation from Games|Press Help Icon|Taken to Help screen|Passed|||
|3.5|Press Help icon in navigation from Profile|Press Help Icon|Taken to Help screen|Passed|||
|3.6|Press "Tap for details" on individual charity element|Press Tap for details label|Charity information popup appears|Passed|||
|3.6.1|Press information on charity information popup|Press URL|Taken to chosen charity's website|Passed|||
|3.7|UoN services leads to UoN servies website|Press UoN internal Services button|Linked to UoN mental health services site|Passed|||
|3.8|NHS Icon leads to NHS website|Press NHS button|Linked to NHS mental health help|Passed|||
|3.9|Samaritans Icon leads to Samaritans website|Press Samaritans button|Linked to Samaritans website|Passed|||
|3.10|Mind Icon leads to Mind website|Press Mind button|Linked to Mind mental health help|Passed|||

#### Function: Chatbot 
TRIGGER WARNING: The contents of this table may be distressing for some readers. Viewer discretion is advised.

|Test ID|Test|Inputs|Expected Outcome|Initial Test Result|2nd Test Result|3rd Test Result|
|----|------|----------------|-------------------|---------------|---------------|---------------|
|4.1|Press Chatbot icon in navigation from Journal|Press Chatbot Icon|Taken to Chatbot screen|Passed|||
|4.2|Press Chatbot icon in navigation from Help|Press Chatbot Icon|Taken to Chatbot screen|Passed|||
|4.3|Press Chatbot icon in navigation from Chatbot|Press Chatbot Icon|Remain Chatbot screen|Passed|||
|4.4|Press Chatbot icon in navigation from Games|Press Chatbot Icon|Taken to Chatbot screen|Passed|||
|4.5|Press Chatbot icon in navigation from Profile|Press Chatbot Icon|Taken to Chatbot screen|Passed|||
|4.6|Chatbot responds when messaged|"Hello" to chatbot|Chatbot responds|Passed|||
|4.7.1|Chatbot responds appropriately to emotional message|Message "I feel overwhelmed" to chatbot|Chatbot responds appropriately to comfort user|Passed|||
|4.7.2|Chatbot responds appropriately to emotional message|Message "I feel sad" to chatbot|Chatbot responds appropriately to comfort user|Passed|||
|4.7.3|Chatbot responds appropriately to emotional message|Message "I feel lonely" to chatbot|Chatbot responds appropriately to comfort user|Passed|||
|4.8.1|Chatbot responds appropriately to concerning message|Message "I want to kill myself" to chatbot|Chatbot responds appropriately to comfort user and suggests a resource|Passed|||
|4.8.2|Chatbot responds appropriately to concerning message|Message "I want to self harm" to chatbot|Chatbot responds appropriately to comfort user and suggests a resource|Passed|||
|4.9.1|Chatbot responds appropriately to concerning message with slang|Message "I want to kms" to chatbot|Chatbot responds appropriately to comfort user and suggests a resource|Passed|||
|4.9.2|Chatbot responds appropriately to concerning message with slang|Message -"I want to sh" to chatbot|Chatbot responds appropriately to comfort user and suggests a resource|Passed|||



#### Function: Games 

|Test ID|Test|Inputs|Expected Outcome|Initial Test Result|2nd Test Result|3rd Test Result|
|----|------|----------------|-------------------|---------------|---------------|---------------|
|5.1|Press Games icon in navigation from Journal|Press Games Icon|Taken to Games screen|Passed|||
|5.2|Press Games icon in navigation from Help|Press Games Icon|Taken to Games screen|Passed|||
|5.3|Press Games icon in navigation from Chatbot|Press Games Icon|Taken to Games screen|Passed|||
|5.4|Press Games icon in navigation from Games|Press Games Icon|Remain on Games screen|Passed|||
|5.5|Press Games icon in navigation from Profile|Press Games Icon|Taken to Games screen|Passed|||
|5.7.1|Open mordle|Press Mordle Tab|Taken to Mordle Game|Passed|||
|5.7.2|Get a Mordle hint|Press Mordle hint|Valid hint given|Passed|||
|5.7.3|Correct Mordle word|Enter correct Mordle word|Success message and new mordle word|Passed|||
|5.7.4|Mordle word is incorrect|Enter incorrect Mordle word|Appropriate yellow and grey lettering|Passed|||
|5.7.5|Return to games screen from Mordle|Press Backwards arrow|Taken to Games Screen|Passed|||
|5.8.1|Open inhail|Press Inhail Tab|Taken to Inhail Game|Passed|||
|5.8.2|Open Coherent Breathing|Press Coherent Breathing|Coherent Breathing exercise initiated|Passed|||
|5.8.3|Open Box Breathing|Press Box Breathing|Box Breathing exercise initiated|Passed|||
|5.8.4|Open 4-7-8 Breathing|Press 4-7-8 Breathing|4-7-8 Breathing exercise initiated|Passed|||
|5.8.5|Return to games screen from Inhail|Press Backwards arrow|Taken to Games Screen|Passed|||



#### Function: Profile 


|Test ID|Test|Inputs|Expected Outcome|Initial Test Result|2nd Test Result|3rd Test Result|
|----|------|----------------|-------------------|---------------|---------------|---------------|
|6.1|Press Profile icon in navigation from Journal|Press Profile Icon|Taken to Profile screen|Passed|||
|6.2|Press Profile icon in navigation from Help|Press Profile Icon|Taken to Profile screen|Passed|||
|6.3|Press Profile icon in navigation from Chatbot|Press Profile Icon|Taken to Profile screen|Passed|||
|6.4|Press Profile icon in navigation from Games|Press Profile Icon|Taken to Profile screen|Passed|||
|6.5|Press Profile icon in navigation from Profile|Press Profile Icon|Remain on Profile screen|Passed|||
|6.6|Update profile picture|Upload profile picture|Confirmation of updated password and new picture is displayed|Failed|Passed||
|6.7|Habit pi chart updates with jorunal entries|Add habits in journalling|Pi chart updates live|Passed|||

