# actions.py
from typing import Any, Text, Dict, List
from rasa_sdk import Action
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.types import DomainDict
import crawler
import random
import sqlite3
from bs4 import BeautifulSoup

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
        # when API for rasa bot is accessed by the front-end, it should set the sender_id to the username of the logged-in account in-app.
        # allowing it be accessed here.
        id = str(tracker.sender_id)
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
        pass


# Use BeautifulSoup library to parse website content.
# Returns True/False depending on if any of this specific user's trigger words are found in the website's HTML.
def containsTrigger(id,site):
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

    if result:
        return result[0].split(',')  
    else:
        return None


        
class Action_Ask_Check(Action):
    def name(self):
        return "action_ask_check"
    
    def run(self, dispatcher, tracker, domain):
        pass


# TODO implement message scanning to filter out previously mentioned trigger words.


# TODO bot provides various journalling prompts to help users engage with the journal feature of the app.


# TODO reminders - based on server system time, if a time-period has passed, send a relevant reminder - perhaps set by the user earlier.
# for example, if they havent messaged for a couple days, send a 'welcome back' message before the main response.




# TODO use sender_id to hide private data - individualise the action.py behaviour.