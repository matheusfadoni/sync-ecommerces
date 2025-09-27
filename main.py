from db.connection import get_connection

if __name__ == "__main__":
    try:
        conn = get_connection()
        print("✅ Conectado ao MySQL:", conn.is_connected())
        conn.close()
    except Exception as e:
        print("❌ Erro ao conectar:", e)
