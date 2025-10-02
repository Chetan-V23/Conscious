from pydantic import BaseModel
from typing import List
from datetime import datetime

class CompanyBase(BaseModel):
    company_name: str
    violations: List[str]

class CreateCompany(CompanyBase):
    pass

class Company(CompanyBase):
    company_id: int
    created_at: datetime

    class config:
        from_attribute = True

# class CompanyShorts(BaseModel):
#     company_short: str
#     company_name: str