# %%
from langchain_openai import OpenAI
from langchain.tools.tavily_search import TavilySearchResults
import os
from dotenv import load_dotenv

# %%
load_dotenv()

search_tool = TavilySearchResults(api_key=os.getenv("TAVILY_API_KEY"), search_type="news", num_results=10)
tools = [search_tool]

# Initialize model
llm = OpenAI(
    model="gpt-4o-mini",
    api_key=os.getenv("OPENAI_API_KEY"),
    temperature=0,
    top_p=1.0,
    max_tokens=500,
)

# %%
company_name = "Nestle"

initial_prompt = f"""answer in yes or no only. 
Do not give any other text
Does {company_name} have a history of human rights violations and anti climate practices?"""

reesponse_1 = llm.invoke(initial_prompt)

if reesponse_1.lower().split()[0] == "no":
    print("No history of human rights violations and anti-climate practices found.")
    exit()

query = f"List the main atrocities committed by {company_name} against climate and human rights"
articles = search_tool.invoke(query)
context = "\n\n".join([article["title"] + "\n"+ article["content"] for article in articles])
prompt = f"""Context:
{context}

Question: {query}
Try and get atleast 5 main points about the atrocities committed by {company_name} against climate and human rights.
in the answer, include one link as the main source at the end of each point.
Also include the Date of when the accusation of the atrocity has been made. 
Return the answer ONLY in JSON format as below:
{{
    'points': [
        {{
            'point': 'Summary of point 1',
            'date': 'Date of accusation',
            'source': 'Link to main source',
        }},
        {{
            'point': 'Summary of point 2',
            'date': 'Date of accusation',
            'source': 'Link to main source
        }},
        {{
            'point': 'Summary of Point 3',
            'date': 'Date of accusation',
            'source': 'Link to main source'
        }},
        {{
            'point': 'Summary of Point 4',
            'date': 'Date of accusation',
            'source': 'Link to main source'
        }},
        {{
            'point': 'Summary of Point 5',
            'date': 'Date of accusation',
            'source': 'L'
        }}
    ]
}}
"""
response = llm.invoke(prompt)

# %%
raw_content = response.content if hasattr(response, 'content') else response

# %%
from langchain.output_parsers.json import SimpleJsonOutputParser
parser = SimpleJsonOutputParser()
response = parser.parse(raw_content)

# %%
for points in response['points']:
    print(f"Point: {points['point']}, Source: {points['source']}, Date: {points['date']}") 
