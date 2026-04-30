import streamlit as st
import pandas as pd
import snowflake.connector

st.title("📊 Marketing Analytics Dashboard")

# Connexion Snowflake (à adapter)
conn = snowflake.connector.connect(
    user="ANNYEBEOLLOMO",
    password="InnovTech2025??",
    account="CYDWIXW-VHB62280",
)

query = "SELECT * FROM anycompany_lab.analytics.features_marketing LIMIT 1000"
df = pd.read_sql(query, conn)

st.subheader("Aperçu des données")
st.dataframe(df)

st.subheader("Revenu par catégorie")
st.bar_chart(df.groupby("PRODUCT_CATEGORY")["TOTAL_REVENUE"].sum())

st.subheader("Impact des promotions")
st.line_chart(df[["PROMO_RATIO", "AVG_BASKET"]])