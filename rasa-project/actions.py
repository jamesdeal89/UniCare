# actions.py
from typing import Any, Text, Dict, List
from rasa_sdk import Action
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.types import DomainDict


class ActionExample(Action):
    """An example of a custom action."""

    def name(self) -> Text:
        return "action_example"

    def run(self,
            dispatcher: CollectingDispatcher,
            tracker,
            domain: DomainDict
            ) -> List[Dict[Text, Any]]:
        # Here you can add custom logic. For example:
        dispatcher.utter_message(text="This is a response from a custom action.")
        return []
