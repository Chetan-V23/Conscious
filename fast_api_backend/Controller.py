from typing import List, Union
from LLMAgent.LLMAgent import Agent
from fast_api_backend.database import db_dependency

class Controller:
    """
    Handles Database and LLM interactions
    """
    _instance = None
    def __new__(cls):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance

    def __init__(self):
        pass

    #Pure python methods
    def __check_for_existence(self, company: str, db: db_dependency) -> List[str]:
        pass

    def __add_results_to_database(self, company: str ,res: Union[bool, List[str]], db: db_dependency):
        pass


    def get_offences(self, company_name:str, db: db_dependency) -> List[str]:

        db_results = self.__check_for_existence(company_name, db)

        if db_results is not None:
            return db_results

        agent = Agent()
        res = agent.invoke_llm(company_name)
        self.__add_results_to_database("some-company", ["something", "also something"])

        return res
