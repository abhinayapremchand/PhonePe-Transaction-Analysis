# phonepe_dashboard.py

import streamlit as st
import pandas as pd
import mysql.connector
import matplotlib.pyplot as plt
import seaborn as sns
import os

# -------------------------------
# 1. Connect to MySQL
# -------------------------------
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="1234",
    database="phonepe_insights"
)

# -------------------------------
# 2. Load Data
# -------------------------------
agg_user = pd.read_sql("SELECT * FROM aggregated_user;", conn)
agg_trans = pd.read_sql("SELECT * FROM aggregated_transaction;", conn)
agg_ins = pd.read_sql("SELECT * FROM aggregated_insurance;", conn)
map_user = pd.read_sql("SELECT * FROM map_user;", conn)
map_trans = pd.read_sql("SELECT * FROM map_transaction;", conn)
map_ins = pd.read_sql("SELECT * FROM map_insurance;", conn)

# -------------------------------
# 3. Streamlit Layout
# -------------------------------
st.title("PhonePe Transaction Insights Dashboard")

# Sidebar Navigation
section = st.sidebar.radio("Navigation", ["Aggregated", "Top Performers"])

# -------------------------------
# Aggregated Section
# -------------------------------
if section == "Aggregated":
    st.header("Aggregated Data Insights")

    # Year filter
    year_filter = st.slider("Select Year", int(agg_user.year.min()), int(agg_user.year.max()), int(agg_user.year.min()))
    agg_user_year = agg_user[agg_user["year"] == year_filter]
    agg_trans_year = agg_trans[agg_trans["year"] == year_filter]
    agg_ins_year = agg_ins[agg_ins["year"] == year_filter]

    # 1. Registered Users by State
    st.subheader(f"Registered Users by State ({year_filter})")
    fig, ax = plt.subplots(figsize=(10,6))
    users_state = agg_user_year.groupby("state")["registered_users"].sum().sort_values(ascending=False)
    sns.barplot(x=users_state.values, y=users_state.index, palette="magma", ax=ax)
    ax.set_xlabel("Registered Users")
    st.pyplot(fig)
    plt.close()

    # 2. App Opens by State
    st.subheader(f"App Opens by State ({year_filter})")
    fig, ax = plt.subplots(figsize=(10,6))
    app_state = agg_user_year.groupby("state")["app_opens"].sum().sort_values(ascending=False)
    sns.barplot(x=app_state.values, y=app_state.index, palette="viridis", ax=ax)
    ax.set_xlabel("App Opens")
    st.pyplot(fig)
    plt.close()

    # 3. Transaction Amount by State
    st.subheader(f"Transaction Amount by State ({year_filter})")
    fig, ax = plt.subplots(figsize=(10,6))
    trans_state = agg_trans_year.groupby("state")["amount"].sum().sort_values(ascending=False)
    sns.barplot(x=trans_state.values, y=trans_state.index, palette="cubehelix", ax=ax)
    ax.set_xlabel("Transaction Amount")
    st.pyplot(fig)
    plt.close()

    # 4. Insurance Amount by State
    st.subheader(f"Insurance Amount by State ({year_filter})")
    fig, ax = plt.subplots(figsize=(10,6))
    ins_state = agg_ins_year.groupby("state")["amount"].sum().sort_values(ascending=False)
    sns.barplot(x=ins_state.values, y=ins_state.index, palette="crest", ax=ax)
    ax.set_xlabel("Insurance Amount")
    st.pyplot(fig)
    plt.close()

# -------------------------------
# Top Performers Section
# -------------------------------
elif section == "Top Performers":
    st.header("Top 10 States/Districts by Metrics")

    # 1. Top 10 States by Transactions
    st.subheader("Top 10 States by Transaction Amount")
    fig, ax = plt.subplots(figsize=(10,6))
    top_states_trans = agg_trans.groupby("state")["amount"].sum().nlargest(10)
    sns.barplot(x=top_states_trans.values, y=top_states_trans.index, palette="viridis", ax=ax)
    ax.set_xlabel("Transaction Amount")
    st.pyplot(fig)
    plt.close()

    # 2. Top 10 States by Insurance Amount
    st.subheader("Top 10 States by Insurance Amount")
    fig, ax = plt.subplots(figsize=(10,6))
    top_states_ins = agg_ins.groupby("state")["amount"].sum().nlargest(10)
    sns.barplot(x=top_states_ins.values, y=top_states_ins.index, palette="cubehelix", ax=ax)
    ax.set_xlabel("Insurance Amount")
    st.pyplot(fig)
    plt.close()

    # 3. Top 10 Districts by Transactions
    st.subheader("Top 10 Districts by Transaction Amount")
    fig, ax = plt.subplots(figsize=(10,6))
    top_districts_trans = map_trans.groupby("district")["amount"].sum().nlargest(10)
    sns.barplot(x=top_districts_trans.values, y=top_districts_trans.index, palette="cubehelix", ax=ax)
    ax.set_xlabel("Transaction Amount")
    st.pyplot(fig)
    plt.close()

    # 4. Top 10 Districts by Registered Users
    st.subheader("Top 10 Districts by Registered Users")
    fig, ax = plt.subplots(figsize=(10,6))
    top_districts_users = map_user.groupby("district")["registered_users"].sum().nlargest(10)
    sns.barplot(x=top_districts_users.values, y=top_districts_users.index, palette="magma", ax=ax)
    ax.set_xlabel("Registered Users")
    st.pyplot(fig)
    plt.close()
