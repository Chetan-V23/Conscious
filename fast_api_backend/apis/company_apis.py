from fastapi import APIRouter
from fast_api_backend.database import db_dependency
from fast_api_backend.Database.db_operations.company_services import get_companies, get_company_from_name, add_company
from fast_api_backend.pydanticmodels.schema import CreateCompany, Company
from typing import List

router = APIRouter(prefix='/company', tags=["company"])

@router.get('/companies', response_model= List[Company])
def get_all_companies(db: db_dependency):
    return get_companies(db = db)

@router.get('/{company}')
def get_company_name(company: str, db: db_dependency):
    return get_company_from_name(company_name=company, db=db)

@router.post('/addcompany', response_model=Company)
def put_company_into_db_temp(company: CreateCompany, db: db_dependency):
    return add_company(company, db)
