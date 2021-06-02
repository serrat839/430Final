import os
import pandas as pd
import pyodbc
import numpy as np

def read_df(filepath):
    specs = pd.read_csv(filepath)
    specs = specs.fillna("NULL")
    specs = specs[specs.CarModel != "NULL"]
    print(specs.shape)
    return specs


def insert_to_db(df, server, database, username, password):
    stored_proc = "EXEC sp_new_listing @Make=?, @ModelAlias=?, @ModelGuess=?, @Year=?, @Price=?, @Condition=?," \
                  "@Miles=?, @PostingDate=?, @PostingUrl=?, @ImageLinks=?, @Region=?"

    conn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
    cursor = conn.cursor()

    for index, row in df.iterrows():
        print(index, row["alias"], row["CarYear"])
        row[row == "Not Avai"] = None
        row[row == "NULL"] = None
        cursor.execute(stored_proc,
                       row["CarMake"],row["Model"],row["alias"],row["Year"],row["CarPrice"], row["CarCondition"],
                       row["MilesOnCar"], row["PostingDate"],row["PostingUrl"],row["CarImageLinks"],row["PostingRegion"])
    conn.commit()
    cursor.close()


if __name__ == '__main__':
    f = open("../passwords.txt", "r")
    server, username, password = (i for i in f.read().split("\n"))
    db = "davidsList"
    df = read_df("../scraping/craigslist_with_alias.csv")
    insert_to_db(df, server, db, username, password)