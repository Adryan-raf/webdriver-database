import os
from pathlib import Path

from dotenv import load_dotenv
import mysql.connector

load_dotenv(Path(__file__).resolve().parent.parent / ".env")


def get_connection():
    return mysql.connector.connect(
        host=os.getenv("MYSQL_HOST", "127.0.0.1"),
        port=int(os.getenv("MYSQL_PORT", "3306")),
        user=os.getenv("MYSQL_USER", "root"),
        password=os.getenv("MYSQL_PASSWORD", ""),
        database=os.getenv("MYSQL_DATABASE", "web_driver"),
    )


def consultar(sql, params=None):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute(sql, params or ())
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    return rows


def executar(sql, params=None):
    conn = None
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(sql, params or ())
        conn.commit()
        cursor.close()
        return True, "Operacao realizada."
    except mysql.connector.Error as erro:
        if conn is not None:
            conn.rollback()
        return False, str(erro)
    finally:
        if conn is not None and conn.is_connected():
            conn.close()
