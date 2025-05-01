# actions.py
from typing import Any, Text, Dict, List
from rasa_sdk import Action
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.types import DomainDict
import crawler
import random
import requests
import sqlite3
from math import factorial
from bs4 import BeautifulSoup
from datetime import datetime, timedelta

# list of trusted URLs for mental health resources 
# the bot will use these to scrape/crawl for relevant information
trustedUrls = ["https://mentalhealth-uk.org/",
               "https://notts-talk.co.uk/",
               "https://www.nhs.uk/mental-health/",
               "https://www.mind.org.uk/get-involved/supported-self-help/"
               "https://www.mind.org.uk/information-support/"
               "http://www.combatstress.org.uk/"
               "https://www.mentalhealth.org.uk/"]

# set of journalling prompts 
# (i.e for the other feature of the app where the user can store daily text entries) 
# which the user may ask for - it will be randomly selected from this pool
prompts = ["What's something you're proud of today?",
           "What is a challenge you've faced recently? What has it taught you?",
           "Write a letter to your future self in 5 years.",
           "Who has the biggest positive impact on your life? Why is that?",
           "Write about a time when kindness, which you have received or which you've given, has impacted you.",
           "Write about someone who inspires you and why.",
           "Describe and recall and memorable conversation you've had with someone which impacted you.",
           "What emotions have you noticed the most today? If you had to imagine them on your body, where would you feel them?",
           "Describe your surroundings using all 5 senses.",
           "Write a detailed description of a place where you feel safe or secure."]
           

happy = ["happy","ecstatic"]
anxious = ["anxious","overwhelmed","stressed out","anxiety"]
sad = ["sad","not too great", "sad", "not good", "upset","depression"]
# trigger words which lead to crisis services being reccomended.
# not to be confused with 'trigger words' which refers to words the user finds uncomfortable.
# these are based on NHS suicide prevention warning signs, as seen in this help page:
# https://www.merseycare.nhs.uk/health-and-wellbeing/suicide-prevention/worried-about-someone/warning-signs
triggers = ["worthless", "suicidal", "disappear", "disapear", "suicide", "death", "dead", "burden", "hopeless", "ashamed", "hate myself", "give up", "given up"]

def create_database():
    conn = sqlite3.connect('user_data.db')
    cursor = conn.cursor()
    # Create table for tracking user's private information (like trigger words).
    # Primary key is the user's unique ID.
    # (ensure that ID cannot be spoofed in the app to access private info.)
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS user_data (
            id TEXT PRIMARY KEY,
            triggers TEXT
        )
    ''')
    # Create table for tracking access times.
    # Primary key is the user's unique ID.
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS access_time (
            id TEXT PRIMARY KEY,
            last_access DATETIME
        )
    ''')
    # Create table for tracking journal prompts used. 
    # No primary key as it's not required to be unique, we're accepting duplicate id records.
    # Accessed via id.
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS journal_records (
            id TEXT,
            last_access DATETIME,
            ind INTEGER
        )
    ''')
    conn.commit()
    conn.close()

# initialise a database for user data like triggers, last log-in time, etc.
# shouldn't overwrite pre-exisiting DB if it exists already.
create_database()

# Detect and respond to emotion, providing relevant advice.
class Action_advice(Action):
    def name(self):
        return "action_advice"

    def run(self, dispatcher, tracker, domain):
        id = str(tracker.sender_id)
        code = updateAccess(id)
        if code == 1:
            dispatcher.utter_message("Welcome back!")
        elif code == 2:
            dispatcher.utter_message("I haven't seen you in a while! Is everything okay?")
        elif code == 3:
            dispatcher.utter_message("I noticed you're new here, before I respond to your prompt, here are some of my features for future reference:")
            dispatcher.utter_message("You can inform me of triggering words via 'I respond badly to TRIGGER'.")
            dispatcher.utter_message("You can ask me to scan websites for previously mentioned triggers by providing a URL.")
            dispatcher.utter_message("You can express your feelings. E.g: 'I feel overwhelmed' and I'll try give you advice and find resources online.")
            dispatcher.utter_message("I can provide journalling prompts to help you write via 'help me with my journal entry'.")
            dispatcher.utter_message("If you need other aspects of this app explained you can ask me. E.g: 'Explain the games section'.")
            dispatcher.utter_message("Now, responding to what you said:")
        emotion = tracker.get_slot('emotion')
        if emotion in happy:
            dispatcher.utter_message("That's great! Keep doing what you're doing.")
        elif emotion in sad:
            dispatcher.utter_message("I'm sorry you're feeling sad. Perhaps you should try talking to a friend and or do something that you enjoy.")
        elif emotion in anxious:
            dispatcher.utter_message("Anxiety can be difficult to deal with. Try doing things that usually help you calm down")
        elif emotion == 'depressed':
            dispatcher.utter_message("Depression can be very serious. Understanding and recognising that you feel depressed is a great first step. Please consider consulting to a professional about this.")
        elif emotion == 'angry':
            dispatcher.utter_message("Anger is a normal emotion and everyone experiences it. I would recommend trying to find a way to express this anger in some way like writing or talking to someone.")
        else:
            pass
        return []

# Used to provide relevant, up-to-date resources by crawling mental-health websites which are known to be useful and safe.
class Action_Resources(Action):
    def name(self):
        return "action_resources"
    
    def findContaining(self, emotion, urls):
        relevant = []
        for url in urls:
            if emotion.lower() in url.lower():
                relevant.append(url);
        return relevant
    
    def run(self, dispatcher, tracker, domain):
        id = str(tracker.sender_id)
        code = updateAccess(id)
        if code == 1:
            dispatcher.utter_message("Welcome back!")
        elif code == 2:
            dispatcher.utter_message("I haven't seen you in a while! Is everything okay?")
        elif code == 3:
            dispatcher.utter_message("I noticed you're new here, before I respond to your prompt, here are some of my features for future reference:")
            dispatcher.utter_message("You can inform me of triggering words via 'I respond badly to TRIGGER'.")
            dispatcher.utter_message("You can ask me to scan websites for previously mentioned triggers by providing a URL.")
            dispatcher.utter_message("You can express your feelings. E.g: 'I feel overwhelmed' and I'll try give you advice and find resources online.")
            dispatcher.utter_message("I can provide journalling prompts to help you write via 'help me with my journal entry'.")
            dispatcher.utter_message("If you need other aspects of this app explained you can ask me. E.g: 'Explain the games section'.")
            dispatcher.utter_message("Now, responding to what you said:")
        urls = []
        for url in trustedUrls:
            for link in crawler.findAllLinks(crawler.get_url(url)):
                urls.append(link)
        emotion = tracker.get_slot('emotion')
        if emotion in anxious:
            for synonym in anxious:
                urlsE = self.findContaining(synonym,urls)
            if (len(urlsE) > 0):
                dispatcher.utter_message("Here is a website with information on dealing with anxiety: ")
                dispatcher.utter_message(urlsE[random.randint(0,len(urlsE)-1)])
            else:
                pass
        elif emotion in sad:
            for synonym in sad:
                urlsE = self.findContaining(synonym,urls)
                print(urls)
                print(synonym)
            if (len(urlsE) > 0):
                dispatcher.utter_message("Here is a website with information on dealing with sadness: ")
                dispatcher.utter_message(urlsE[random.randint(0,len(urlsE)-1)])
            else:
                pass
        elif emotion in happy:
            pass
        elif emotion in triggers:
            for synonym in triggers:
                urlsE = self.findContaining(synonym,urls)
            dispatcher.utter_message("You are important and don't have to face these issues alone. There are people who can help. Please consider reaching out to one of the 24/7 hotlines below: ")
            dispatcher.utter_message("Online: samaritans.org")
            dispatcher.utter_message("UK phone - Samaritans: 116 123")
            dispatcher.utter_message("UK phone - National Suicide Prevention Hotline: 0800 587 0800")
            dispatcher.utter_message("Globally - https://findahelpline.com/ can help you find help no matter where you are.")
            if (len(urlsE) > 0):
                dispatcher.utter_message("Here is a website with information on dealing with these feelings: ")
                dispatcher.utter_message(urlsE[random.randint(0,len(urlsE)-1)])
            else:
                pass
        else:
            dispatcher.utter_message("I was sadly unable to find any relevant resources after performing a search of trusted providers.")

class Action_Crisis(Action):
    def name(self):
        return "action_crisis"
    
    def run(self, dispatcher, tracker, domain):
        dispatcher.utter_message("You are important and don't have to face these issues alone. There are people who can help. Please consider reaching out to one of the 24/7 hotlines below: ")
        dispatcher.utter_message("Online: samaritans.org")
        dispatcher.utter_message("UK phone - Samaritans: 116 123")
        dispatcher.utter_message("UK phone - National Suicide Prevention Hotline: 0800 587 0800")
        dispatcher.utter_message("Globally - https://findahelpline.com/ can help you find help no matter where you are.")



class Action_Save_Trigger(Action):
    def name(self):
        return "action_save_trigger"
    
    def run(self, dispatcher, tracker, domain):
        id = str(tracker.sender_id)
        code = updateAccess(id)
        if code == 1:
            dispatcher.utter_message("Welcome back!")
        elif code == 2:
            dispatcher.utter_message("I haven't seen you in a while! Is everything okay?")
        # when API for rasa bot is accessed by the front-end, it should set the sender_id to the username of the logged-in account in-app.
        # allowing it be accessed here.
        # access the detcted NLP token for the trigger
        trigger = tracker.get_slot("trigger")
        
        if trigger:
            trigger = trigger[0]

            # to help debug, print the id detected.
            print(f"User ID: {id}")

            conn = sqlite3.connect('user_data.db')
            cursor = conn.cursor()

            new = False

            # try to access user's current trigger words saved in the persistent DB
            try:
                cursor.execute('SELECT triggers FROM user_data WHERE id = ?', (id,))
                result = cursor.fetchone()
                # for debugging, print the result
                print(f"Query result: {result}") 
            except Exception as e:
                print(f"Error retrieving data: {e}")

            if result:
                # NOTE: we are storing it in an SQL column as a single long string of text.
                # this is also done as list column support is more complex for SQL DB's in python.

                # this converts back to list from the string 
                currTriggers = result[0].split(',')  
                # if the user already has trigger word(s) saved, append this new one to it.
                if trigger not in currTriggers:
                    # add it to the list
                    currTriggers.append(trigger) 
                # convert list into long string seperated by commas
                updatedTrigs = ','.join(currTriggers)  
            else:
                new = True
                # if no trigger entry found for id, just use the single trigger.
                updatedTrigs = trigger

            # update the DB entry to store the trigger word (plus any pre-existing stored triggers.)
            cursor.execute('''
                INSERT INTO user_data (id, triggers)
                VALUES (?, ?)
                ON CONFLICT(id) DO UPDATE SET triggers=excluded.triggers
            ''', (id, updatedTrigs))

            conn.commit()
            conn.close()

            dispatcher.utter_message(f"I will remeber that you find mentions of {trigger} difficult. Thank you for informing me as it helps me support you.")
            # if the user has never added a trigger word before, inform them of it's uses.
            if new:
                dispatcher.utter_message(f"By asking 'Can you check this website for me?' and providing a URL, I can scan the webiste for potential triggers on your behalf and warn you if it contains any.")




# Used to help the user check websites for triggering words which they provided.
# Provides a warning that it cannot check multi-media.
# While it cannot parse images/video for triggering content, it can check alt text.
class Action_Check(Action):
    def name(self):
        return "action_check"
    
    def run(self, dispatcher, tracker, domain):
        id = str(tracker.sender_id)
        code = updateAccess(id)
        if code == 1:
            dispatcher.utter_message("Welcome back!")
        elif code == 2:
            dispatcher.utter_message("I haven't seen you in a while! Is everything okay?")
        urllist = tracker.get_slot("url")
        if urllist:
            url = urllist[0]
            if containsTrigger(id,url):
                dispatcher.utter_message("I would advise you not to visit the website you provided, as I detected it contains one of your triggers.")
            else:
                dispatcher.utter_message("I did not detect any of your triggers in the provided website.")
                dispatcher.utter_message("However, I am unable to fully check multi-media content and you should only use this as a preliminary check. I may be incorrect.")
        else:
            dispatcher.utter_message("I apologise, I was unable to detect the URL in your message. Please retry with different phrasing.")


# Use BeautifulSoup library to parse website content.
# Returns True/False depending on if any of this specific user's trigger words are found in the website's HTML.
def containsTrigger(id,url):
        print("checking " + url)
        try:
            # set an agent as sometimes sites block python's default one
            headers = {"User-Agent": "Mozilla/5.0"}
            response = requests.get(url, headers=headers, timeout=10)
            response.raise_for_status() 
            content = BeautifulSoup(response.text, "html.parser")
            text = content.getText()
            triggers = getTriggers(id)
            for trigger in triggers: 
                if trigger.lower() in text.lower():
                    return True
            # also check multi-media alt text as an additional check
            for img in content.find_all("img"):
                alt = img.get("alt","")
                for trigger in triggers:
                    if trigger.lower() in alt.lower():
                        return True
            return False

        except requests.RequestException:
            print("Except occured when checking if contains trigger")
            return False
    

# Retrieve a list of triggers for a given user id as per the DB.
# Returns None if no triggers saved for given user id.
def getTriggers(id):
    conn = sqlite3.connect('user_data.db')
    cursor = conn.cursor()
    try:
        cursor.execute('SELECT triggers FROM user_data WHERE id = ?', (id,))
        result = cursor.fetchone()
        # for debugging, print the result
        print(f"Query result: {result}") 
    except Exception as e:
        print(f"Error retrieving data: {e}")
        conn.commit()
        conn.close()
    if result:
        conn.commit()
        conn.close()
        return result[0].split(',')  
    else:
        conn.commit()
        conn.close()
        return None

        
# This is an action as need to access DB and check if they have any trigger words saved.
# If this user does not, prompt them to inform the bot of any.
# If they do already have triggers saved, ask for confirmation and then perform check (via NLP - not programmatically)
class Action_Ask_Check(Action):
    def name(self):
        return "action_ask_check"
    
    def run(self, dispatcher, tracker, domain):
        id = str(tracker.sender_id)
        code = updateAccess(id)
        if code == 1:
            dispatcher.utter_message("Welcome back!")
        elif code == 2:
            dispatcher.utter_message("I haven't seen you in a while! Is everything okay?")
        if getTriggers(str(tracker.sender_id)):
            dispatcher.utter_message("Would you like me to check the website you provided for triggering content you've previously informed you're sensitive to?")
        else:
            dispatcher.utter_message("I am able to check websites you provide for triggering content. However you have yet to inform me of any triggers.")
            dispatcher.utter_message("If you would like to inform me of any, please try saying 'I am sensitive to mentions of TRIGGER'.")
            dispatcher.utter_message("Otherwise, just tell me 'no' and I'll move on.")


# Simply takes the current user_id and updates their last access time in the DB
# If last access (before updating it) was more than 24 hours ago, welcome the user back.
# represented by returning 1.
# If last access was more than 3 days ago, bring up the break and check on the user.
# represented by returning 2.
# If the user is new, it returns 3.
# this signals the caller to output an explanation of features.
# otherwise, less than 24 hours, returns 0.
def updateAccess(id):
    currTime = datetime.now()
    conn = sqlite3.connect('user_data.db')
    cursor = conn.cursor()
    code = 0

    try:
        cursor.execute("SELECT last_access FROM access_time WHERE id = ?", (id,))
        result = cursor.fetchone()
        if result:
            lastAccess = datetime.strptime(result[0], "%Y-%m-%d %H:%M:%S.%f")
            print("Previous access was " + str(lastAccess))
            if currTime - lastAccess >= timedelta(hours=24):
                code = 1
            elif currTime - lastAccess >= timedelta(days=3):
                code = 2
        else:
            code = 3
    except Exception as e:
        print(f"Error accessing last access time: {e}")

    try:
        cursor.execute("INSERT OR REPLACE INTO access_time (id,last_access) VALUES (?,?)", (id,currTime))
    except Exception as e:
        print(f"Error saving acess data: {e}")
    conn.commit()
    conn.close()
    return code


# Guides the user through different aspects of the app (outside the chatbot).
# Alongside highlighting their mental health benefits.
class Action_Explain(Action):
    def name(self):
        return "action_explain"
    
    def run(self, dispatcher, tracker, domain):
        feature = tracker.get_slot("feature")
        
        if feature:
            print(feature)
            feature = feature[0]
            print(feature)
            if feature.lower() in ["game","murdle","wordle","mordle","games"]:
                dispatcher.utter_message("The 'Games' section allows you to engage with mentally stimulating activites.")
                dispatcher.utter_message("Keeping your brain active by trying to solve puzzles is shown to benefit your mental health.")
                dispatcher.utter_message("See this article from the University of Oxford: https://www.ox.ac.uk/news/2020-11-16-groundbreaking-new-study-says-time-spent-playing-video-games-can-be-good-your-well")
                dispatcher.utter_message("The 'Murdle' game is based around guessing a short word within a given number of attempts.")
                dispatcher.utter_message("After each guess, it will show you which letters you guessed are in the target word in yellow, and which letters are both in the word and in the correct position in green.")
                dispatcher.utter_message("Remember! the word's meaning will always be related to something positive in this version of the game.")
            elif feature.lower() in ["journal","journalling","journaling","diary"]:
                dispatcher.utter_message("The 'Journalling' section lets you keep a self-written record of your daily activites.")
                dispatcher.utter_message("However, the amount you write or the frequency is entirely up to you! Journalling should be a fun part of your routine so it's okay to do it less frequently if you can't find the time.")
                dispatcher.utter_message("There is research to suggest it can help your mental health as you reflect on your day.")
                dispatcher.utter_message("See this article from the National Library of Medicine for more information on the benefits: https://pmc.ncbi.nlm.nih.gov/articles/PMC6305886/")

            else:
                dispatcher.utter_message("I'm not sure what feature you're refering to. Perhaps try phrasing it as 'games' or 'journalling' for example.")
        else:
            print("no feature")

        

# Provide journalling prompts to the user if they ask.
# Randomly selected, but uses the server-side DB to check which prompts were recently given to a specific user.
# If a prompt has been randomly selected, but has been given before within the last 2 days, it reselects.
class Action_Journal(Action):
    def name(self):
        return "action_journal"
    
    def run(self, dispatcher, tracker, domain):
        conn = sqlite3.connect('user_data.db')
        cursor = conn.cursor()
        id = str(tracker.sender_id)
        blacklist = []
        currTime = datetime.now()

        try:
            cursor.execute("SELECT last_access, ind FROM journal_records WHERE id = ?", (id,))
            results = cursor.fetchall()
            if results:
                for i in range(len(results)):
                    # not here the 0th index is the last use datetime
                    # and the 1st index is the index into the prompts list for that prompt
                    lastAccess = datetime.strptime(results[i][0], "%Y-%m-%d %H:%M:%S.%f")
                    if currTime - lastAccess <= timedelta(hours=48):
                        recent = results[i][1]
                        if recent not in blacklist:
                            blacklist.append(recent)
                            print("blacklisted prompt: ", recent)
        except Exception as e:
            print(f"Error accessing last access time: {e}")

        selected = random.randint(0,len(prompts)-1) 
        # need to prevent infinite loop caused by all indexes into prompts list being blacklisted.
        # to determine if all indexes are blacklisted: use the factorial of the length of prompts list
        # compared to the sum of the blacklisted indexes.
        # e.g: assume:
        # blacklist = 0,1,2,3
        # len(prompts) = 4 
        # then:
        # factorial(4-1) = 1 + 2 + 3 = 6
        # sum of 0,1,2,3 = 6
        # equality comparison will be true and we know all indexes are blacklisted.
        print(blacklist)
        if sum(blacklist) >= factorial((len(prompts)-1)):
            # if all indexes blacklisted, don't enter an infinite unique generation loop,
            # instead just add a disclaimer informing the user that the prompt won't be fresh.
            dispatcher.utter_message("Sorry, but I'll have to recycle a prompt I've used within the past couple days.")
        else:
            # in this case, we know not all indexes are blacklisted
            while selected in blacklist:
                print("regenerate index")
                selected = random.randint(0,len(prompts)-1) 

        dispatcher.utter_message("Here is a prompt to help you journal/write:")
        dispatcher.utter_message(prompts[selected])

        # Add the prompt we just sent to the DB so we know to not use it again too soon
        cursor.execute('''
                    INSERT INTO journal_records (id, last_access, ind) VALUES (?,?,?)
        ''',(id,currTime,selected))

        # close the DB connection while committing any changes
        conn.commit()
        conn.close()


        

