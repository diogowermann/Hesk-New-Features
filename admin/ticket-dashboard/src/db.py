from mysql.connector import connect, Error, cursor
from dotenv import load_dotenv
import os

# Load environment variables from .env
load_dotenv()

DB_CONFIG = {
    'host':     os.getenv('DB_HOST'),
    'user':     os.getenv('DB_USER'),
    'password': os.getenv('DB_PASS'),
    'database': os.getenv('DB_NAME')
}

def dbConnect():
    try:
        connection = connect(**DB_CONFIG)
        return connection
    except Error as e:
        print(f"Database connection error: {e}")
