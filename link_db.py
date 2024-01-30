import pandas as pd
from urllib.parse import quote_plus
from sqlalchemy import create_engine,text

password = "#ndeNu00@#"
encoded_password = quote_plus(password)
postgreSQL_username = "nzangi"
db_name = 'project_2'

# db_name = 'Your_DB_Name'
# conn_string= f'postgresql://{postgreSQL_username}:{encoded_password}@localhost/{db_name}'
# db = create_engine(conn_string)
# conn = db.connect()
# files =['artist','canvas_size','image_link','museum','museum_hours','product_size','subject','work']
# for file in files:
#     df = pd.read_csv(f"archive/{file}.csv")
#     df.to_sql(file,con=conn,if_exists='replace',index=False)


conn_string= f'postgresql://{postgreSQL_username}:{encoded_password}@localhost/{db_name}'
db = create_engine(conn_string)
conn = db.connect()
# files =['athlete_events','noc_regions']
files_and_tables = {'athlete_events': 'olympics_history', 'noc_regions': 'olympics_history_noc_regions'}
for file, table in files_and_tables.items():
    df = pd.read_csv(f"Project_2/{file}.csv")

    # Ensure column names are lowercase
    df.columns = map(str.lower, df.columns)

    # Use a text object for the query
    table_columns_query = text("SELECT column_name, data_type FROM information_schema.columns WHERE table_name = :table_name")
    
    # Execute the query with the table_name parameter
    result = conn.execute(table_columns_query, {'table_name': table})
    table_columns = result.fetchall()

    # Create a data_types dictionary dynamically based on the PostgreSQL table structure
    data_types = {col[0]: 'VARCHAR' if 'character' in col[1].lower() else 'INTEGER' for col in table_columns}

    # Explicitly cast the 'year' column to int
    if 'year' in data_types:
        df['year'] = df['year'].astype(int)

    # Apply data types to the DataFrame
    df = df.astype(data_types)

    # Use the to_sql method with the dtype parameter
    df.to_sql(table, con=conn, if_exists='append', index=False, dtype=data_types)


conn.close()