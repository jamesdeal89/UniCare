TO BE CONVERTED TO .MD

# App Usability Tests

## Document Overview

This document aims to lay out the tests that discern the app’s adherence to the usability criterion laid out in the [*Web Content Accessibility Guidelines (WCAG)*](https://www.w3.org/TR/WCAG22/#abstract) , and how well the application would perform on the [*Mobile App Rating Scale (MARS)*](https://pmc.ncbi.nlm.nih.gov/articles/PMC4376132/) in regard to accessibility and useability. It will also point out areas where potential accessibility features are missing and the impact this may
have on a user in need of them.

To prevent potential legal issues, the application must conform to a “Level AA” WCAG standard. Whilst the WCAG itself is not a law, the Equality Act 2010 states applications are required to meet the guidelines of WCAG 2.2 AA. The tests below will ensure a thorough conformity to the five components of the WCAG (perceivable, operable, understandable, robust and conformance), with another section below dedicated to finding a MARS score for the app.

Some sections may seem irrelevant to the app, but it is a good idea to include them anyway to recognise any areas where accessibility may need improvement.

This section has been performed internally and has not been verified independently. Areas which are perceived to be in conformation are denoted with an "X".

### Section 1- Perceivable

This section dictates how information and user interface components must be presentable to users in ways they can perceive. The definition of each section can be [found here.](https://www.w3.org/TR/WCAG22/#abstract)

|  |  |  |
|----|----|----|
| Section 1: Perceivable | Level of Conformity | Conforms? |
| **1.1 Text Alternatives** | \- | \- |
| 1.1.1 Non-Text Content | A | X |
| **1.2 Time-Based Media** | \- | \- |
| 1.2.1 Audio-only and Video-only (Pre-recorded) | A | N/A |
| 1.2.2 Captions (Pre-recorded) | A | N/A |
| 1.2.3 Audio Description or Media Alternative (Pre-recorded) | A | N/A |
| 1.2.4 Captions (Live) | AA | N/A |
| 1.2.5 Audio Description (Pre-recorded) | AA | N/A |
| 1.2.6 Sign Language (Pre-recorded) | AAA | N/A |
| 1.2.7 Extended Audio Description (Pre-recorded) | AAA | N/A |
| 1.2.8 Media Alternative (Pre-recorded) | AAA | N/A |
| 1.2.9 Audio-only (Live) | AAA | N/A |
| **1.3 Adaptable** | \-------------------------- | -- |
| 1.3.1 Info and Relationships | A | X |
| 1.3.2 Meaningful Sequence | A | X |
| 1.3.3 Sensory Characteristics | A | X |
| 1.3.4 Orientation | AA | X |
| 1.3.5 Identify Input Purpose | AA | X |
| 1.3.6 Identify Purpose | AAA |  |
| **1.4 Distinguishable** | ***-*** | \- |
| 1.4.1 Use of colour | A | X |
| 1.4.2 Audio Control | A | N/A |
| 1.4.3 Contrast (Minimum) | AA | X |
| 1.4.4 Resize Text | AA | X |
| 1.4.5 Images of Text | AA | X |
| 1.4.6 Contrast (Enhanced) | AAA |  |
| 1.4.7 Low or No Background Audio | AAA | X |
| 1.4.8 Visual Presentation | AAA | X |
| 1.4.9 Images of Text (No Exception) | AAA | X |
| 1.4.10 Reflow | AA | X |
| 1.4.11 Non-text Contrast | AA | X |
| 1.4.12 Text Spacing | AA | X |
| 1.4.13 Content on Hover or Focus | AA | N/A |

|                              |      |
| ---------------------------- | ---- |
| Level of Conformity Achieved | AA   |

### Section 2 – Operable

This section gives guidance on the operability of user interface components and navigation. The full details of each section can be
[*found here.*](https://www.w3.org/TR/WCAG22/#operable)

|                                         |                     |           |
| --------------------------------------- | ------------------- | --------- |
| **Section 2: Operable**                 | Level of Conformity | Conforms? |
| **2.1 Keyboard Accessible**             | \-                  | \-        |
| 2.1.1 Keyboard                          | A                   | X         |
| 2.1.2 No Keyboard Tap                   | A                   | X         |
| 2.1.3 Keyboard (No Exception)           | AAA                 | X         |
| 2.1.4 Character Key Shortcuts           | AAA                 | N/A       |
| **2.2 Enough Time**                     | \-                  | \-        |
| 2.2.1 Timing Adjustable                 | A                   | N/A       |
| 2.2.2 Pause, Stop Hide                  | A                   | N/A       |
| 2.2.3 No Timing                         | AAA                 | X         |
| 2.2.4 Interruptions                     | AAA                 | N/A       |
| 2.2.5 Re-authenticating                 | AAA                 | X         |
| 2.2.6 Timeouts                          | AAA                 | X         |
| **2.3 Seizures and Physical Reactions** | \-                  | \-        |
| 2.3.1 Three Flashes or Below Threshold  | A                   | N/A       |
| 2.3.2 Three Flashes                     | AAA                 | X         |
| 2.3.3 Animation from Interactions       | AAA                 | X         |
| **2.4 Navigable**                       | \-                  | \-        |
| 2.4.1 Bypass Blocks                     | A                   | N/A       |
| 2.4.2 Page Titled                       | A                   | X         |
| 2.4.3 Focus Order                       | A                   | X         |
| 2.4.4 Link Purpose (in context)         | A                   | X         |
| 2.4.5 Multiple Ways                     | AA                  | X         |
| 2.4.6 Headings and Labels               | AA                  | X         |
| 2.4.7 Focus Viable                      | AA                  | X         |
| 2.4.8 Location                          | AAA                 | X         |
| 2.4.9 Link Purpose (Link Only)          | AAA                 | X         |
| 2.4.10 Section Headings                 | AAA                 | X         |
| 2.4.11 Focus Not Obscured (Minimum)     | AA                  | X         |
| 2.4.12 Focus Not Obscured (Enhanced)    | AAA                 | X         |
| 2.4.13 Focus Appearance                 | AAA                 | X         |
| **2.5 Input Modalities**                | \-                  | \-        |
| 2.5.1 Pointer Gestures                  | A                   | N/A       |
| 2.5.2 Pointer Cancellation              | A                   | N/A       |
| 2.5.3 Label in Name                     | A                   | X         |
| 2.5.4 Motion Actuation                  | A                   | X         |
| 2.5.5 Target Size (Enhanced)            | AAA                 | N/A       |
| 2.5.6 Concurrent Input Mechanisms       | AAA                 | N/A       |
| 2.5.7 Dragging Movements                | AA                  | N/A       |
| 2.5.8 Target Size (Minimum)             | AA                  | N/A       |

|                              |      |
| ---------------------------- | ---- |
| Level of Conformity Achieved | AAA  |

### Section 3 – Understandable

This section details how information and the operation of the user interface must be understandable. As always, the link to this section can be [*found here.*](https://www.w3.org/TR/WCAG22/#understandable)

|  |  |  |
|----|----|----|
| Section 3: Understandable | Level of Conformity | Conforms? |
| **3.1 Readable** | \- | \- |
| 3.1.1 Language of Page | A | X |
| 3.1.2 Language of Parts | AA | X |
| 3.1.3 Unusual Words | AAA | N/A |
| 3.1.4 Abbreviations | AAA | N/A |
| 3.1.5 Reading Level | AAA | X |
| 3.1.6 Pronunciation | AAA | N/A |
| **3.2 Predictable** | - | - |
| 3.2.1 On Focus | A | X |
| 3.2.2 On Input | A | X |
| 3.3.3 Consistent Navigation | AA | X |
| 3.2.4 Consistent Identification | AA | X |
| 3.2.5 Change on Request | AAA | X |
| 3.2.6 Consistent Help | A | X |
| **3.3 Input Assistance** | - | - |
| 3.3.1 Error Identification | A | X |
| 3.3.2 Labels or Instructions | A | X |
| 3.3.3 Error Suggestion | AA | X |
| 3.3.4 Error Prevention (Legal, Financial, Data) | AA | N/A |
| 3.3.5 Help | AAA |  |
| 3.3.6 Error Prevention (All) | AAA | N/A |
| 3.3.7 Redundant Entry | A | N/A |
| 3.3.8 Accessible Authentication (Minimum) | AA | X |
| 3.3.9 Accessible Authentication | AAA | X |

|                              |      |
| ---------------------------- | ---- |
| Level of Conformity Achieved | AA   |

### Section 4 – Robust

This section details how content is displayed on varying screen sizes
and how content must be robust enough to be interpreted by a wide
variety of user agents, including assistive technology. The link to this
section can be [*found here.*](https://www.w3.org/TR/WCAG22/#robust)

|                        |                     |           |
| ---------------------- | ------------------- | --------- |
| Section 4: Robust      | Level of Conformity | Conforms? |
| **4.1 Compatible**     | \-                  | \-        |
| 4.1.1 \[OBSOLETE\]     | \-                  | \-        |
| 4.1.2 Name, Role Value | A                   | X         |
| 4.1.3 Status Messages  | AA                  | X         |

|                                  |      |
| -------------------------------- | ---- |
| **Level of Conformity Achieved** | AA   |

|                                          |      |
| ---------------------------------------- | ---- |
| **Overall Level of Conformity Achieved** | AA   |

## MARS Testing

The Mobile App Rating Scale is a tool to assess the quality of apps providing health and wellbeing advice. A series of questions about the app are asked and respondents are given a 1 to 5 scale as possible answers, with 1 being the lowest score and a 5 being the highest score. The average score is then calculated from the sum of the ratings given by a respondent. A downloadable PDF example of this can be [*found here.*](https://jmir.org/api/download?alt_name=mhealth_v3i1e27_app2.pdf&filename=86161240dc0e5f7e86306b19d1bcd1a8.pdf)

The questions itself are split into 5 sections, 4 of which are scored upon and cover topics such as the engagement factor, functionality, aesthetics and quality of information provided. The final section is a “final remarks” section, which asks the users real world scenarios around using the app.

The MARS for the application is filled in below.

**MARS**

**App Name:** Team 31 Health App
**Developer:** Team 31
**Version:** 1.0.0
**Last update:** 1.0.0
**Platform(s):** iOS, Android

**Brief application description:** Guidance app around achieving positive mental health through games and being provided resources
**App focus:** Mental health
**Theoretical background/strategies:** CBT

**Affiliation:** University
**Target age group:** 18-65
**Technical aspects of the app:** Requires login, has password-protection, needs web access to function

### Section 1 – Engagement

This section scores the app on its engageability; fun, customisable, interactive, how well targeted it is towards the intended audience etc.

1.  Is the app fun/entertaining to use? Does it use any strategies to
    increase engagement through entertainment (i.e. gamification)?

    1.  Dull, not fun or entertaining at all
    2.  Mostly boring
    3.  OK, fun enough to entertain the user for a brief time (under 5
        minutes)
    4.  Moderately fun and entertaining, would entertain user for some
        time (5 to 10 minutes total)
    5.  Highly entertaining and fun, would stimulate repeat use

|                  |      |
| ---------------- | ---- |
| Question 1 Score | 3    |

2.  Is the app interesting to use? Does it use any strategies to
    increase engagement by present its content in an interesting way?

    1.  Not interesting at all
    2.  Mostly uninteresting
    3.  OK, neither interesting nor uninteresting; would engage user for
        a brief time (under 5 minutes)
    4.  Moderately interesting; would engage user for some time (5-10
        minutes total)
    5.  Very interesting, would engage user in repeat use

|                  |      |
| ---------------- | ---- |
| Question 2 Score | 4    |

3.  Does it provide/retain all necessary settings/preferences for apps
    features (e.g. sound, content, notifications, etc.)?

    1. Does not allow any customisation or requires setting to be input
        every time
    2. Allows insufficient customisation limiting functions
    3. Allows basic customisation to functional adequately
    4. Allows numerous options for customisation
    5. Allows complete tailoring to the individual’s
        characteristics/preferences, retains all settings

|                  |      |
| ---------------- | ---- |
| Question 3 Score | 3    |

4.  Does it allow user input, provide feedback, contain prompts
    (reminders, sharing options, notifications, etc.)? Note: These
    functions must be customisable and not overwhelming to be perfect.
    1. No interactive features and/or no response to user interaction
    2. Insufficient interactivity, or feedback, or user input options,
        limiting functions
    3. Basic interactive features to function adequately
    4. Offers a variety of interactive features/feedback/user input
        options
    5. Very high level of responsiveness through interactive
        features/feedback/user input options

|                  |      |
| ---------------- | ---- |
| Question 4 Score | 3    |

5.  Is the app content (visual information, language, design)
    appropriate for your target audience?

    1. Completely inappropriate/unclear/confusing
    2. Mostly inappropriate/unclear/confusing
    3. Acceptable but not targeted, may be
        inappropriate/unclear/confusing
    4. Well-targeted, with negligible issues
    5. Perfectly targeted, no issues found

|                  |      |
| ---------------- | ---- |
| Question 5 Score | 4    |

|                      |      |
| -------------------- | ---- |
| Section 1 Mean Score | 3.4  |

### Section 2 – Functionality

This section queries the app functions, how easy it is to learn and
navigate, the flow logic and gestural design of the app.

6.  How accurately/fast do the app features (functions) and components
    (buttons/menus) work?

    1. App is broken; no/insufficient/inaccurate response
        (crashes/bugs/broken features)
    2. Some functions work, but lag or contain major technical problems
    3. App works overall. Some technical problems need fixing/Slow at
        times
    4. Mostly functional with minor/negligible problems
    5. Perfect/timely response; no technical bugs found/contains a
        ‘loading time left’ indicator

|                  |      |
| ---------------- | ---- |
| Question 6 Score | 3    |

7.  How easy is it to learn how to use the app; how clear are the menu
    labels/icons and instructions?

    1. No/limited instructions; menu labels/icons are confusing;
        complicated
    2. Useable after a lot of time/effort
    3. Useable after some time/effort
    4. Easy to learn how to use the app (or has clear instructions)
    5. Able to use app immediately; intuitive; simple

|                  |      |
| ---------------- | ---- |
| Question 7 Score | 4    |

8.  Is moving between screens
    logical/accurate/appropriate/uninterrupted; are all necessary screen
    links?

    1. Different sections within the app seem logically disconnected
        and random/confusing/navigation is difficult
    2. Useable after a lot of time/effort
    3. Useable after some time/effort
    4. Easy to use or missing a negligible link
    5. Perfectly logical, easy, clear and intuitive screen flow
        throughout, or offer shortcuts

|                  |      |
| ---------------- | ---- |
| Question 8 Score | 5    |

9. Are interactions with the touch screen consistent and intuitive
    across all components/screens?

    1. Completely inconsistent/confusing
    2. Often inconsistent/confusing
    3. OK with some inconsistencies/confusing elements
    4. Mostly consistent/intuitive with negligible problems
    5. Perfectly consistent and intuitive

|                  |      |
| ---------------- | ---- |
| Question 9 Score | 5    |

|                      |      |
| -------------------- | ---- |
| Section 2 Mean Score | 4.25 |

### Section 3 – Aesthetics

This section queries the graphic design, overall visual appeal, colour
scheme and stylistic consistency.

10. Is arrangement and size of buttons/icons/menus/content on the screen
    appropriate or zoomable if needed?

    1. Very bad design, cluttered, some options impossible to
        select/locate/see/read device display not optimised
    2. Bad design, random, unclear, some options difficult to
        select/locate/see/read
    3. Satisfactory, few problems with
        selecting/locating/seeing/reading items or with minor
        screen-size problems
    4. Mostly clear, able to select/locate/see/read items
    5. Professional, simple, clear, orderly, logically organised,
        device display optimised. Every design component has a purpose

|                   |      |
| ----------------- | ---- |
| Question 10 Score | 4    |

11. How high is the quality/resolution of graphics used for
    buttons/icons/menus/content?

    1. Graphics appear amateur, very poor visual design –
        disproportionate, complete stylistically inconsistent
    2. Low quality/low resolution graphics; low quality visual design –
        disproportionate, stylistically inconsistent
    3. Moderate quality graphics and visual design (generally
        consistent in style)
    4. High quality/resolution graphics and visual design – mostly
        proportionate, stylistically consistent
    5. Very high quality/resolution graphics and visual design –
        proportionate, stylistically consistent

|                   |      |
| ----------------- | ---- |
| Question 11 Score | 3    |

12. How good does the app look?

    1. No visual appeal, unpleasant to look at, poorly designed,
         clashing/mismatching colours
    2. Little visual appeal – poorly designed, bad use of colour,
         visually boring
    3. Some visual appeal – average, neither pleasant, nor unpleasant
    4. High level of visual appeal – seamless graphics – consistent
         and professionally designed
    5. As above, plus very attractive, memorable, stands out; use of
         colour enhances app features/menus

|                   |      |
| ----------------- | ---- |
| Question 12 Score | 4    |

|                      |      |
| -------------------- | ---- |
| Section 3 Mean Score | 3.67 |

### Section 4 – Information

This section details the quality of the information within the app, such
as text, feedback and the sources used.

13. Accuracy of app description (in app store): Does app contain what is
    described?  
    1. Misleading. App does not contain the described
         components/functions. Or has no description.
    2. Inaccurate. App contains very few of the described
         components/functions
    3. OK. App contains very few of the described component/functions
    4. Accurate. App contains most of the described
         components/functions
    5. Highly accurate description of the app components/functions

|                   |      |
| ----------------- | ---- |
| Question 13 Score | 5    |

14. Does app have specific, measurable and achievable goals (specified
    in app store description or within the app itself)? \[Leave blank if
    app does not list goals or app is irrelevant to research goal.\]

    1. App has no chance of achieving its stated goals
    2. Description lists some goals, but app has very little chance of
       achieving them
    3. OK. App has clear goals which may be achievable
    4. App has clearly specified goals, which are measurable and achievable
    5. App has specific and measurable goals, which are highly likely to be
       achieved

|                   |      |
| ----------------- | ---- |
| Question 14 Score | N/A  |

15. Is app content correct, well written, and relevant to the goal/topic
    of the app?
    1. Irrelevant/inappropriate/incoherent/incorrect
    2. Poor, barely relevant/appropriate/coherent/may be incorrect
    3. Moderately relevant/appropriate/coherent/and appears correct
    4. Relevant/appropriate/coherent/correct
    5. Highly relevant, appropriate, coherent, and correct

|                   |      |
| ----------------- | ---- |
| Question 15 Score | 4    |

16. Is the extent coverage within the scope of the app; and
    comprehensive but concise?

    1. Minimal or overwhelming
    2. Insufficient or possibly overwhelming
    3. OK but not comprehensive or concisde
    4. Offers are broad range of information, has some gaps or
         unnecessary detail; or has no links to more information and
         resources
    5. Comprehensive and concise; contains links to more information
         and resources

|                   |      |
| ----------------- | ---- |
| Question 16 Score | 5    |

17.  Is visual explanation of concepts – through
    charts/graphs/images/videos etc. - clear, logic and correct?

    1. Completely unclear/confusing/wrong or necessary but missing
    2. Mostly unclear/confusing/wrong
    3. OK but often unclear/confusing/wrong
    4. Mostly clear/logic/correct with negligible issues
    5. Perfectly clear/logical/correct

|                   |      |
| ----------------- | ---- |
| Question 17 Score | 4    |

18.  Does the app come from a legitimate source?

    1. Source identified but legitimacy/trustworthiness of source is
         questionable
    2. Appears to come from a legitimate source, but it cannot be
         verified
    3. Developed by a small NGO/institution
    4. Developed by government, university or as above but larger in
         scale
    5. Developed using nationally competitive government or research
         funding

|                   |      |
| ----------------- | ---- |
| Question 18 Score | 4    |

19. Has the app been trialled/tested? \[N/A if not tested\]

    1. Evidence suggests the app does not work
    2. App has been trialled (e.g. acceptability, usability,
         satisfaction ratings) and has partially positive outcomes in
         studies that are not randomised controlled trials (RCTs), or
         there is little or no contradictory evidence
    3. App has been trialled (e.g. acceptability, usability,
         satisfaction ratings) and has positive outcomes in studies that
         are not RCTs, and there is no contradictory evidence
    4. App has been trialled and outcome tested in 1-2 RCTs indicating
         positive results
    5. App has been trialled and outcome tested in 3 or more high
         quality RCTs indicating positive results

|                   |      |
| ----------------- | ---- |
| Question 19 Score | 3    |

|                        |      |
| ---------------------- | ---- |
| Section 4 Mean Score\* | 4.1  |
|                        |      |

\*exclude N/A questions from the mean score calculation

### Section 5 – Subjective Quality

This section does not count towards the MARS, but rather indicative of
the subjective qualities and how users would feel about the app outside
of its legitimacy and accuracy, i.e. the aesthetic and quality of
design.

20. Would you recommend this app to people who might benefit from it?

    1. Not at all
    2. 
    3. Maybe
    4. 
    5. Definitely

|                   |      |
| ----------------- | ---- |
| Question 20 Score | 4    |

21. How many times do you think you would use this app in the next 12
    months if it was relevant to you?

    1. None
    2. 1-2
    3. 3-10
    4. 10-50
    5. \>50

|                   |      |
| ----------------- | ---- |
| Question 21 Score | 3    |

22.  Would you pay for this app?

    1.  Not at all
    2. 
    3. Maybe
    4. 
    5. Definitely

|                   |      |
| ----------------- | ---- |
| Question 22 Score | 2    |

23. What is your overall star rating of the app?

    1. One of the worst apps I’ve used
    2. Below average
    3. Average
    4. Above average
    5. One of the best apps I’ve used

|                   |      |
| ----------------- | ---- |
| Question 23 Score | 3    |

|                      |      |
| -------------------- | ---- |
| Section 5 Mean Score | 3    |
|                      |      |

### Scoring

The MARS is calculated by taking sections 1 to 4 and calculating an
overall mean to 2 decimal places. Any N/A answers must be removed from
individual section scores in order to not negatively affect the final
scoring. Section 5 can be seen as a subjective opinion on the app.

|            |      |
| ---------- | ---- |
| MARS Score | 3.86 |
