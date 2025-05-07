import mysql.connector
import json
from dotenv import load_dotenv
import os

# Load environment variables from .env file
load_dotenv()
api_key = os.getenv("OPENAI_API_KEY")

# Database connection parameters
host = 'localhost'
port = 3306
user = 'root'
password = 'psyaj9'
database = 'rasa_db'

# Connect to database
conn = mysql.connector.connect(
    host=host,
    port=port,
    user=user,
    password=password,
    database=database
)
cursor = conn.cursor()

# Query to get user and bot events, ordered by timestamp
query = """
    SELECT id, sender_id, type_name, timestamp, data
    FROM events
    WHERE type_name IN ('user', 'bot')
    ORDER BY timestamp
"""
cursor.execute(query)
rows = cursor.fetchall()

# Filter and prepare conversation
conversation = ""
trigger_phrases = ["hello", "How are you feeling today?"]
for row in rows:
    event_id, sender_id, event_type, timestamp, data = row
    try:
        event_data = json.loads(data)
        text = event_data.get('text', '')
        if text:  # Ensure text exists
            # Check for trigger phrases or responses after them
            if event_type == 'user' and any(phrase in text.lower() for phrase in trigger_phrases):
                conversation += f"User ({timestamp}): {text}\n"
            elif event_type == 'bot' and (any(phrase in conversation.lower() for phrase in trigger_phrases) or "feeling" in text.lower()):
                conversation += f"Bot ({timestamp}): {text}\n"
    except json.JSONDecodeError:
        print(f"Error decoding JSON for event ID {event_id}: {data}")

conn.close()

# Summarize using OpenAI API
if conversation:
    from openai import OpenAI
    client = OpenAI(api_key=api_key)

    prompt = f"""
    The following is a conversation between a user and a bot. Summarize the conversation focusing on greetings and emotional exchanges:

    {conversation}

    Provide a concise summary.
    """
    
    response = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": "You are a helpful assistant that summarizes conversations."},
            {"role": "user", "content": prompt}
        ],
        max_tokens=150,
        temperature=0.2
    )
    
    summary = response.choices[0].message.content.strip()
    print("Summary:")
    print(summary)
else:
    print("No relevant conversation found.")