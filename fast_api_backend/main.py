from fastapi import FastAPI
from . import database
from Database import models
from .apis import company_apis

app = FastAPI()
models.Base.metadata.create_all(bind=database.engine)
@app.get('/')
def root():
    return {"something":"also something new 2"}

app.include_router(company_apis.router)

