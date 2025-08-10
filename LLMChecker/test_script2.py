from openai import OpenAI
import os
from dotenv import load_dotenv

load_dotenv()
client = OpenAI(api_key=os.environ.get("OPEN_AI_API_KEY"), organization=os.environ.get("ORG_KEY"))


models = client.models.list()
for m in models.data:
    print(m.id, m.created, m.owned_by)