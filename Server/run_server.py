from typing import Union
import fastapi
from fastapi import FastAPI, Request, HTTPException

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Welcome to the LLMChecker API"}