from langchain_openai import OpenAI
from langchain.tools.tavily_search import TavilySearchResults
from langgraph.prebuilt import create_react_agent
from langgraph.checkpoint.memory import MemorySaver
from langchain.output_parsers import JsonOutputToolsParser
import os
from dotenv import load_dotenv

load_dotenv()

search_tool = TavilySearchResults(api_key=os.getenv("TAVILY_API_KEY"), search_type="news", num_results=10)
tools = [search_tool]

# Initialize model
llm = OpenAI(
    model="gpt-4o-mini",
    api_key=os.getenv("OPENAI_API_KEY"),
    temperature=0,
    top_p=1.0
)

# Function to run agent
def run_agent(company_name: str):
    query = f"List the main atrocities committed by {company_name} against climate and human rights"
    articles = search_tool.invoke(query)
    context = "\n\n".join([article["title"] + "\n"+ article["content"] for article in articles])
    prompt = f"""Context:
    {context}
    
    Question: {query}
    Try and get atleast 5 main points about the atrocities committed by {company_name} against climate and human rights.
    If there are more than 5 crucial points, add more points to the list. if there are less than 5 crucial points, reduce points on the list.
    in the answer, include one link as the main source at the end of each point. Return the answer in JSON format as below:
    {{
        'points': [
            {{
                'point': 'Summary of point 1',
                'source': 'https://example.com/source1'
            }},
            {{
                'point': 'Summary of point 2',
                'source': 'https://example.com/source2'
            }},
            {{
                'point': 'Summary of Point 3',
                'source': 'https://example.com/source3'
            }},
            {{
                'point': 'Summary of Point 4',
                'source': 'https://example.com/source4'
            }},
            {{
                'point': 'Summary of Point 5',
                'source': 'https://example.com/source5'
            }}
        ]
    }}
    """
    response = llm.invoke(prompt)
    print(response)
    # Parse the response using the JSON output parser
    parser = JsonOutputToolsParser()
    response = parser.parse(response)
    return response


if __name__ == "__main__":
    # Example usage
    response = run_agent("Adani Group")
    for point in response['points']:
        print(f"Point: {point['point']}\nSource: {point['source']}\n")

