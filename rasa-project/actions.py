# actions.py
from typing import Any, Text, Dict, List
from rasa_sdk import Action
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.types import DomainDict


class Action_advice(Action):
    def name(self):
        return "action_advice"

    def run(self, dispatcher, tracker, domain):
        emotion = tracker.get_slot('emotion')
        if emotion == 'happy':
            dispatcher.utter_message("That's great! Keep doing what you're doing.")
        elif emotion == 'sad':
            dispatcher.utter_message("I'm sorry you're feeling sad. Perhaps you should try talking to a friend and or do something that you enjoy.")
        elif emotion == 'anxious':
            dispatcher.utter_message("Anxiety can be difficult to deal with. Try doing things that usually help you calm down")
        elif emotion == 'depressed':
            dispatcher.utter_message("Depression is a very serious. Please consider consulting to a professional about this.")
        elif emotion == 'angry':
            dispatcher.utter_message("Anger is a normal emotion and everyone experiences it. I would recommend trying to find a way to express this anger in some way like writing or talking to someone.")
        else:
            dispatcher.utter_message("I'm not sure how to help with that emotion. Maybe you can tell me more?")
        return []