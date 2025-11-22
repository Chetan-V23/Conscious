from fastapi.exceptions import HTTPException
from fastapi import APIRouter, status
from fast_api_backend.database import db_dependency
from fast_api_backend.pydanticmodels.schema import TokenRequest, UserBase
from google.oauth2 import id_token
from google.auth.transport import requests
from fast_api_backend.pydanticmodels.schema import UserResponseModel
import os
from fast_api_backend.AuthHelper.create_jwt import create_access_token
from fast_api_backend.Database.db_operations.auth_services import add_user_to_db

GOOGLE_CLIENT_ID = os.getenv("GOOGLE_CLIENT_ID")
router = APIRouter(prefix='/auth', tags=["authorization"])

@router.post("/google", response_model=UserResponseModel)
async def google_auth(payload: TokenRequest, db: db_dependency):
    try:
        # Verify the token with Google
        idinfo = id_token.verify_oauth2_token(
            payload.id_token,
            requests.Request(),
            GOOGLE_CLIENT_ID
        )
        user_id = idinfo["sub"]
        email = idinfo.get("email")
        access_token = create_access_token({"sub": user_id, "email": email})
        user = UserBase(id_token=access_token, email= email, username=user_id)
        user = add_user_to_db(user, db_dependency)
        return user
    except Exception:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="ion kno something u did"
        )

@router.post("/dummy", response_model=UserResponseModel)
async def dummy_auth(payload: TokenRequest, db: db_dependency):
    try:
        # Verify the token with Google
        print(payload.id_token)
        user_id = "dummy_user"
        email = "dummy@dummy.com"
        access_token = create_access_token({"sub": user_id, "email": email})
        user = UserBase(id_token=access_token, email= email, username=user_id)
        user = add_user_to_db(user, db_dependency)
        return user
    except Exception:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="ion kno something u did"
        )