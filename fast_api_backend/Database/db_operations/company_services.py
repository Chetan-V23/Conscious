from fastapi.exceptions import HTTPException

from fast_api_backend.Database.models import CompanyModel
from sqlalchemy.orm import Session
from fast_api_backend.pydanticmodels.schema import CreateCompany, Company
from sqlalchemy.exc import IntegrityError

def add_company(company: CreateCompany, db: Session):

    #normalize company name - add sms names to database for each company and then check first
    existing_company = get_company_from_name(company_name=company.company_namem, db=db)
    if existing_company is not None:
        return existing_company
    try:
        company_instance = CompanyModel(**company.model_dump())
        db.add(company_instance)
        db.commit()
        db.refresh(company_instance)
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=500, detail="Company exists and code didnt work as expected")
    return company_instance

def get_companies(db:Session):
    return db.query(CompanyModel).all()

def get_company_from_name(company_name: str, db:Session) -> Company:
    return db.query(CompanyModel).filter(CompanyModel.company_name==company_name).first()
