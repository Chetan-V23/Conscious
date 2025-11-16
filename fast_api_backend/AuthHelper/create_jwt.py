from jose import jwt
import time
import os

SECRET_KEY = os.getenv("SECRETJWTKEY")
ALGORITHM = "HS256"

def create_access_token(data: dict, expires_delta: int = 3600):
    to_encode = data.copy()
    expire = int(time.time()) + expires_delta
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)