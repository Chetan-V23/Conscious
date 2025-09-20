from fast_api_backend.database import Base
from sqlalchemy import Column, Integer, String, TIMESTAMP, text, ARRAY, ForeignKey

class CompanyModel(Base):

    __tablename__ = "Company_Database"
    company_id = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
    company_name = Column(String, nullable=False)
    created_at = Column(TIMESTAMP(timezone=True), server_default=text('now()'))
    violations = Column(ARRAY(String), nullable=True)


# class ShortsModel(Base):
#
#     __tablename__ = "Company_Shortforms"
#     short_form = Column(String, primary_key=True, index=True)
#     company = Column(String, ForeignKey("Company_Database.company_id"))
