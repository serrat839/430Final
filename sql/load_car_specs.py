import os
import pandas as pd
import pyodbc
import numpy as np

def read_df(filepath):
    specs = pd.read_csv(filepath)
    specs = specs[~specs.OriginCountry.isnull()]
    specs = specs.fillna("NULL")
    return specs


def insert_to_db(df, server, database, username, password):
    stored_proc = "EXEC sp_new_car @Pros=?,@Cons=?,@StartingPrice=?,@Review=?,@New=?,@OriginCountry=?,@usSale=?," \
                  "@bodyStyle=?,@exteriorColors=?,@interiorColors=?,@engineLocation=?,@engineType=?," \
                  "@engineCylinders=?,@engineDisplacement_cc=?,@engineDisplacement_I=?,@engineDisplacement_cubicIn=?," \
                  "@engineBore_mm=?,@engineBore_in=?,@engineStroke_mm=?,@engineStroke_in=?,@valvePerCylinder=?," \
                  "@maxPower_hp=?,@maxPower_ps=?,@maxPower_kW=?,@maxPower_rpm=?,@maxTorque_Nm=?,@maxTorque_Lb_ft=?," \
                  "@maxTorque_kgf_m=?,@maxTorque_rpm=?,@engineCompressionRatio=?,@engineFuelType=?,@drive=?," \
                  "@transmission=?,@topSpeed_mph=?,@zeroToSixtytwoMPH=?,@doors=?,@seats=?,@weight_kg=?,@weight_lbs=?," \
                  "@length_mm=?,@length_in=?,@width_mm=?,@width_in=?,@height_mm=?,@height_in=?,@wheelbase_mm=?," \
                  "@wheelbase_in=?,@fuelEconomyCity_L_100km=?,@fuelEconomyCity_mpg=?,@fuelEconomyHWY_L_100km=?," \
                  "@fuelEconomyHWY_mpg=?,@fuelEconomyMixed_L_100km=?,@fuelEconomyMixed_mpg=?,@fuelCapacity_L=?," \
                  "@fuelCapacity_g=?,@ModelYear=?,@ModelName=?,@Make=?"

    conn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
    cursor = conn.cursor()

    for index, row in df.iterrows():
        print(index, row["ModelName"], row["ModelYear"])
        row[row == "Not Avai"] = None
        row[row == "NULL"] = None
        cursor.execute(stored_proc,
                       row["Pros"], row["Cons"], row["StartingPrice"], row["Review"], row["New"], row["OriginCountry"], row["usSale"],
                       row["bodyStyle"], row["exteriorColors"], row["interiorColors"], row["engineLocation"], row["engineType"],
                       row["engineCylinders"], row["engineDisplacement_cc"], row["engineDisplacement_I"], row["engineDisplacement_cubicIn"],
                       row["engineBore_mm"], row["engineBore_in"], row["engineStroke_mm"], row["engineStroke_in"], row["valvePerCylinder"],
                       row["maxPower_hp"], row["maxPower_ps"], row["maxPower_kW"], row["maxPower_rpm"], row["maxTorque_Nm"], row["maxTorque_Lb_ft"],
                       row["maxTorque_kgf_m"], row["maxTorque_rpm"], row["engineCompressionRatio"], row["engineFuelType"], row["drive"],
                       row["transmission"], row["topSpeed_mph"], row["zeroToSixtytwoMPH"], row["doors"], row["seats"], row["weight_kg"], row["weight_lbs"],
                       row["length_mm"], row["length_in"], row["width_mm"], row["width_in"], row["height_mm"], row["height_in"], row["wheelbase_mm"],
                       row["wheelbase_in"], row["fuelEconomyCity_L_100km"], row["fuelEconomyCity_mpg"], row["fuelEconomyHWY_L_100km"],
                       row["fuelEconomyHWY_mpg"], row["fuelEconomyMixed_L_100km"], row["fuelEconomyMixed_mpg"], row["fuelCapacity_L"],
                       row["fuelCapacity_g"], row["ModelYear"], row["ModelName"], row["Make"])
        conn.commit()
    cursor.close()


if __name__ == '__main__':
    f = open("../passwords.txt", "r")
    server, username, password = (i for i in f.read().split("\n"))
    db = "davidsList"
    df = read_df("../scraping/all_spec_kbb_final.csv")
    insert_to_db(df, server, db, username, password)