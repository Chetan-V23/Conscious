from langchain.chat_models import ChatOpenAI
from langchain.schema import HumanMessage
import openai
from openai import AuthenticationError, RateLimitError, OpenAIError
from dotenv import load_dotenv
import os

# Set your OpenAI API key
load_dotenv()

# (Optional) Set organization if needed
# openai.organization = "org-..."

# Also set in LangChain's environment
import os
os.environ["OPENAI_API_KEY"] = openai.api_key

# Initialize LangChain chat model
llm = ChatOpenAI(model_name="gpt-3.5-turbo")

try:
    response = llm([HumanMessage(content="Say hello")])
    print("✅ LangChain & OpenAI working. Response:")
    print(response.content)

except AuthenticationError:
    print("❌ Invalid API key or authentication issue.")

except RateLimitError as e:
    print("❌ Quota error or rate limit reached:")
    print(e)

except OpenAIError as e:
    print("❌ Some other OpenAI-related error:")
    print(e)

except Exception as e:
    print("❌ Unexpected error:")
    print(e)
