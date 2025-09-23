from fastapi import FastAPI, Depends
from . import database
from Database import models
from Controller import Controller
from typing import Annotated
from .apis import company_apis

app = FastAPI()
models.Base.metadata.create_all(bind=database.engine)

controller_dependency = Annotated[Controller, Depends(lambda : Controller())]

@app.get('/')
def root():
    return {"something":"also something new 2"}


app.include_router(company_apis.router)

