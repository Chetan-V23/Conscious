from LLMAgent import Agent
from typing import List, Union

class LanggraphCaller:
    """
    Handles Database and LLM interactions
    """
    def __init__(self):
        pass

    #Pure python methods
    def __check_for_existence(self, company: str) -> List[str]:

        pass

    def __add_results_to_database(self, company: str ,res: Union[bool, List[str] ]):
        pass


    def get_offences(self, company_name:str) -> List[str]:

        db_results = self.__check_for_existence(company_name)

        if db_results is not None:
            return db_results

        agent = Agent()
        res = agent.invoke_llm(company_name)
        self.__add_results_to_database("some-company", ["something", "also something"])

        return res
