# actions.py
from typing import Any, Text, Dict, List
from rasa_sdk import Action
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.types import DomainDict
import crawler
import random
import requests
import sqlite3
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

happy = ["happy","ecstatic"]
anxious = ["anxious","overwhelmed","stressed out"]
sad = ["sad","not too great", "sad", "not good", "upset"]
triggers = ["worthless", "suicidal", "disapear","suicide"]

def create_database():
    conn = sqlite3.connect('user_data.db')
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS user_data (
            id TEXT PRIMARY KEY,
            triggers TEXT
        )
    ''')

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS access_time (
            id TEXT PRIMARY KEY,
            last_access DATETIME
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
            if emotion in url:
                relevant.append(url);
        return relevant
    
    def run(self, dispatcher, tracker, domain):
        id = str(tracker.sender_id)
        code = updateAccess(id)
        if code == 1:
            dispatcher.utter_message("Welcome back!")
        elif code == 2:
            dispatcher.utter_message("I haven't seen you in a while! Is everything okay?")
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
# TODO implement webiste checking functionality
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
        url = tracker.get_slot("url")
        if containsTrigger(id,url):
            dispatcher.utter_message("I would advise you not to visit the website you provided, as I detected it contains one of your triggers.")
        else:
            dispatcher.utter_message("I did not detect any of your triggers in the provided website.")
            dispatcher.utter_message("However, I am unable to fully check multi-media content and you should only use this as a preliminary check. I may be incorrect.")


# Use BeautifulSoup library to parse website content.
# Returns True/False depending on if any of this specific user's trigger words are found in the website's HTML.
def containsTrigger(id,url):
        try:
            response = requests.get(url)
            response.raise_for_status
            content = BeautifulSoup(response.text,"html.parser")
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
            for vid in content.find_all("video"):
                for track in vid.find_all("track"):
                    label = track.get("label","")
                    kind = track.get("kind","")
                    for trigger in triggers:
                        if (trigger.lower() in label.lower()) or (trigger.lower() in kind.lower()):
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
# otherwise, less than 24 hours, or user never added to DB, returns 0.
def updateAccess(id):
    currTime = datetime.now()
    conn = sqlite3.connect('user_data.db')
    cursor = conn.cursor()
    code = 0

    try:
        cursor.execute("SELECT last_access FROM access_time WHERE id = ?", (id,))
        result = cursor.fetchone
        if result:
            lastAccess = datetime.strptime(result[0], "%Y-%m-%d %H:%M:%S")
            print("Previous access was " + lastAccess)
            if currTime - lastAccess >= timedelta(hours=24):
                code = 1
            elif currTime - lastAccess >= timedelta(days=3):
                code = 2
    except Exception as e:
        print(f"Error accessing last access time: {e}")

    try:
        cursor.execute("INSERT OR REPLACE INTO access_time (id,last_access) VALUES (?,?)", (id,currTime))
    except Exception as e:
        print(f"Error saving acess data: {e}")
    conn.commit
    conn.close
    return code



# TODO implement explanations of app features if asked.

# TODO implement message scanning to filter out previously mentioned trigger words.


# TODO bot provides various journalling prompts to help users engage with the journal feature of the app.


# TODO reminders - based on server system time, if a time-period has passed, send a relevant reminder - perhaps set by the user earlier.
# for example, if they havent messaged for a couple days, send a 'welcome back' message before the main response.




# TODO use sender_id to hide private data - individualise the action.py behaviour.