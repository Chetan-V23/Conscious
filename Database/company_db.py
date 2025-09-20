from fast_api_backend import database


def get_company_entries(company_name: str):
    db = database.get_db()

