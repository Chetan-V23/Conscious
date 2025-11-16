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

class TokenRequest(BaseModel):
    id_token: str

class UserBase(BaseModel):
    id_token: str
    email: str
    username:str

class UserResponseModel(UserBase):
    user_id: int
    class config:
        from_attribute = True