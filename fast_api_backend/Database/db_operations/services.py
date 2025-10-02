from fast_api_backend.Database.models import CompanyModel
from sqlalchemy.orm import Session
from fast_api_backend.Database.schema import CreateCompany, Company


def add_company(company: CreateCompany, db: Session):
    company_instance = CompanyModel(**company.model_dump())
    db.add(company_instance)
    db.commit()
    db.refresh(company_instance)
    return company_instance


def get_companies(db:Session):
    return db.query(CompanyModel).all()

def get_company_from_name(company_name: str, db:Session) -> Company:
    return db.query(CompanyModel).filter(CompanyModel.company_name==company_name).first()
