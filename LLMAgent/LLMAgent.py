"""
this file is supposed to-
takes company name as input
"""

from typing import TypedDict, Sequence, Annotated, List, Union
from langgraph.graph import StateGraph, START, END, add_messages
from langchain_openai import ChatOpenAI, OpenAIEmbeddings
from langchain_tavily.tavily_search import TavilySearch
from langchain_core.messages import BaseMessage, SystemMessage
from langgraph.prebuilt.chat_agent_executor import AgentState


class Agent:
    """
    take a company
    return atrocities
    by-
    using openai
    and
    using tavily search for web results and web scraping
    this will hold the graph and the compiled graph. it should be singleton
    """
    class AgentState(TypedDict):
        company: str
        message: Annotated[Sequence[BaseMessage], add_messages]
        result: bool


    #Nodes of the graph
    def __invoke_model(self, state: AgentState) -> AgentState:
        """
        calls the method
        :param state:
        :return:
        """
        system_message = SystemMessage(["You are an AI agent thats responsible to find out the blah blah blah"])
        self.__model.invoke(state["company"])
        return state

    def __search_tool_node(self, state: AgentState)-> AgentState:
        pass



    def __init__(self):
        self.__model = ChatOpenAI(model= 'gpt-4o')
        self.__search_tool = TavilySearch(search_type="news", num_results=10)

        graph = StateGraph(AgentState)
        graph.add_node(self.__invoke_model.__name__, self.__invoke_model)
        self.__app = graph.compile()

    def invoke_llm(self, company_name) -> Union[List[str],None]:
        res = self.__app.invoke(company_name)

        return res