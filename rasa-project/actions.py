# actions.py
from typing import Any, Text, Dict, List
from rasa_sdk import Action
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.types import DomainDict
import crawler


happy = ["happy","ecstatic"]
anxious = ["anxious","overwhelmed","stressed out"]
sad = ["sad","not too great", "sad", "not good", "upset"]

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
            dispatcher.utter_message("Depression is a very serious. Please consider consulting to a professional about this.")
        elif emotion == 'angry':
            dispatcher.utter_message("Anger is a normal emotion and everyone experiences it. I would recommend trying to find a way to express this anger in some way like writing or talking to someone.")
        else:
            dispatcher.utter_message("I'm not sure how to help with that emotion. Maybe you can tell me more?")
        return []

# Used to provide relevant, up-to-date resources by crawling mental-health websites which are known to be useful and safe.
class Action_Resources(Action):
    def name(self):
        return "action_resources"
    
    def findContaining(self, emotion, urls):
        relevant = []
        for url in urls:
            print(url)
            if emotion in url:
                relevant.append(url);
        return relevant
    
    def run(self, dispatcher, tracker, domain):
        urls = crawler.findAllLinks(crawler.get_url("https://notts-talk.co.uk/"))
        emotion = tracker.get_slot('emotion')
        if emotion in anxious:
            anxiousUrls = self.findContaining('anxious',urls)
            dispatcher.utter_message("Here is a website with information on dealing with anxiety: ")
            dispatcher.utter_message(anxiousUrls[0])
        else:
            dispatcher.utter_message("I was unable to find any relevant resources online, but I tried my best!")