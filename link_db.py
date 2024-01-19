import pandas as pd
from urllib.parse import quote_plus
from sqlalchemy import create_engine
password = "Enter_Your_PostgreSQL_Here"
encoded_password = quote_plus(password)
postgreSQL_username = "Your_postgresql_useranme"
db_name = 'Your_DB_Name'
conn_string= f'postgresql://{postgreSQL_username}:{encoded_password}@localhost/{db_name}'
db = create_engine(conn_string)
conn = db.connect()
files =['artist','canvas_size','image_link','museum','museum_hours','product_size','subject','work']
for file in files:
    df = pd.read_csv(f"archive/{file}.csv")
    df.to_sql(file,con=conn,if_exists='replace',index=False)