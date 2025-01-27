# Software Requirements Specification Document

These requirements are based on the brief provided by BAC-IN and the further discssions we had with them during the pitch. 

__If we are no longer able to work with BAC-IN, these requirements might change as the product will become more broad and less specific to BAC-IN's 'lived experience' approach to recovery.__

## Initial Textual Analysis - BAC-IN Version

_Highlighting key:_

- _Purple_ text means non-functional requirement.
- _Yellow_ means use-case.
- _Blue_ mean an actor.

![textual analysis page 1](../reqs_specs_assets/textualAnalysis_1.png)
![textual analysis page 2](../reqs_specs_assets/textualAnalysis_2.png)
![textual analysis summary](../reqs_specs_assets/textualAnalysis_3.png)

## Updated Textual Analysis - Internal Version

Unfortunately, we were ___unable to continue working with BAC-IN___ due to unforeseen budget issues within the charity which led to their project director no longer being able to work with us.

In response, we have pivoted the product to be less BAC-IN specific and ___more broadly mental health focused___ (rather than narrowly targetted for addiction recovery.) In addition, this provides an opporunitiy to widen the reach of our product; as we can target it beyond BAME specific audiences - while certainly ___still keeping it, as well as inclusion and cultural sensitivity, as a vital factor___.

Our project supervisor kindly provided us with an ___updated brief___ which takes these changes into account:

![textual analysis updated page 1](../reqs_specs_assets/updatedTextAnalysis.png)
![textual analysis updated summary](../reqs_specs_assets/TextAnalysisTableUpdated.png)

## Purpose

Following the Textual Analysis, combined with further discussion with our academic supervisor, and team deliberation, we formally define the broad purpose of the project to be:

- To develop a ___mobile application___;
- With the core theme of ___'mental health support and information'___;
- Central feature is the ___natural language chat interface___;
- With elements of 'gamification'.

## Intended Audience 

___Individuals in recovery___ are the main audience we want to target.

However, following the divergence from BAC-IN, we are more flexible in our audience and will aim to keep the ___product inclusive for people who require general mental health support___ and information.

## Product Scope

Our scope has been changed to ___reduce 'AI' related requirements___ due to safety concerns, which we rasied with BAC-IN. We discussed the ___risk-reward trade-off___ in using ChatGPT, Gemini, or any other LLM model for mental health support; concluding that the ___risk of hallucinations___ (where the LLM fabricates information which is factually incorrect) is too great for the ___highly sensitive application of supporting individuals in addiction recovery___. 

This is reflected in the updated brief which focuses more on the ___gamification and personalisation aspect___. Our approach is to limit the scope of the chatbot so it uses ___key-word detection, sentiment analysis, and DialogueFlow 'contexts'___ to keep the natural language communication aspect and responsiveness, while ___reducing the risk___ which direct LLM integration may pose.

## Definitions and Acronyms

|Concept/Acronym|Explanation|
|---------------|-----------|
|NLP|Natural Language Processing|
|LLM|Large Language Model|
|AI|Artificial Intelligence|
|BAME|Black Asian and Minority Ethnic|
|DialogueFlow|Google's Natural Language Processing platform for conversational user interfaces|
|Flutter|Google's UI Development kit for cross-platform applications (mobile included)|
|UoN/UON|University of Nottingham|
|Hallucination|In regards to LLM: when a model states information or refers to a situation which does not exist in reality or is factually incorrect|
|Sentiment Analysis|Taking text and using NLP and other text analysis methods to extract meaning or emotion in a quantifiable or computable way|

## Assumptions and Dependencies

#TODO

## Stakeholders

Primary:

- ___Aislinn Bergin___ - Academic Project Supervisor - New 'client' as project has been taken over by UoN.
- ___University of Nottingham___ - will be published and released under the UoN name; we are exploring partnerships with the medicial or psychology departments.
- ___Individuals recovering from addiction___ - the target direct users of the app.
- ___Individuals who want to support their mental health___ more broadly - also desired direct users of the app.

Secondary:

- ___Mental health professionals___ - don't use the app directly, but their input should heavily influence how the product is developed to support the users.
- ___Researchers___ - potentially, the app could be studied to understand it's effects on user's mental health.

Tertiary:

- ___BAC-IN___ - Charity - Original client - still has some influence as they proposed the original concept and core idea which the evolved brief draws from.


## Functional Requirements



## External Interface Requirements

## System Features

## Non-Functional Requirements

