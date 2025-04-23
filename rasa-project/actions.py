# actions.py
from typing import Any, Text, Dict, List
from rasa_sdk import Action
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.types import DomainDict
import crawler
import random

# list of trusted URLs for mental health resources 
# the bot will use these to scrape/crawl for relevant information
trustedUrls = ["https://mentalhealth-uk.org/",
               "https://notts-talk.co.uk/",
               "https://www.nhs.uk/mental-health/",
               "https://www.mind.org.uk/get-involved/supported-self-help/"]

happy = ["happy","ecstatic"]
anxious = ["anxious","overwhelmed","stressed out"]
sad = ["sad","not too great", "sad", "not good", "upset"]
triggers = ["worthless", "suicidal", "disapear","suicide"]

trigger_words = []

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
            dispatcher.utter_message("I was unable to find any relevant resources online, but I tried my best!")


class Action_Save_Trigger(Action):
    def name(self):
        return "action_save_trigger"
    
    def run(self, dispatcher, tracker, domain):
        trigger_words.append(tracker.get_slot('trigger')[len(tracker.get_slot('trigger'))-1])
        print(trigger_words)

        if trigger_words:
            response = f"I understand that you find mentions of '{trigger_words[len(trigger_words)-1]}' difficult. I'll refrain from mentioning your triggers. Furthermore, I can scan websites for triggering content on your behalf if you ask."
        else:
            response = "I was unable to detect any previously saved triggers, feel free to inform me of any."

        dispatcher.utter_message(text=response)
        return []



# Used to help the user check websites for triggering words which they provide.
#class Action_Resources(Action):
#    def name(self):
#        return "action_resources"
#    
#    def run(self, dispatcher, tracker, domain):
# TODO implement webiste checking functionality


# TODO implement message scanning to filter out previously mentioned trigger words.


# TODO bot provides various journalling prompts to help users engage with the journal feature of the app.


# TODO reminders - based on server system time, if a time-period has passed, send a relevant reminder - perhaps set by the user earlier.
# for example, if they havent messaged for a couple days, send a 'welcome back' message before the main response.




# TODO use sender_id to hide private data - individualise the action.py behaviour.