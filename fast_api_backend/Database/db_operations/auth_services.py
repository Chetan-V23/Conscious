from fast_api_backend.Database.models import UserModel
from fastapi.exceptions import HTTPException
from fast_api_backend.pydanticmodels.schema import UserResponseModel, UserBase
from sqlalchemy.orm import Session
from sqlalchemy import or_

def add_user_to_db(user: UserBase, db: Session) -> UserResponseModel:
    existing_user = get_user_fron_db(db, user.email)
    if existing_user:
        return UserResponseModel(**existing_user.model_dump())
    user_instance = UserModel(**user.model_dump())
    db.add(user_instance)
    db.commit()
    db.refresh(user_instance)
    return user_instance

def get_user_fron_db( db: Session, user_email: str =None):
    if user_email is None:
        raise HTTPException(status_code=400, detail="email cant be none")
    return db.query(UserModel).filter(or_(
        UserModel.email_id == user_email,
    )).first()
