import streamlit as st
import pandas as pd
from sqlalchemy import create_engine
import matplotlib.pyplot as plt
import seaborn as sns

# Database connection
engine = create_engine("mysql+mysqlconnector://root:1234@localhost/phonepe")

st.set_page_config(page_title="PhonePe Transaction Insights", layout="wide")

# Sidebar Navigation
section = st.sidebar.radio("Go to Section", ["Home", "Aggregated", "Map Insurance", "Top Tables"])

# ---------------------- HOME ----------------------
if section == "Home":
    st.title("📱 PhonePe Transaction Insights Dashboard")
    st.markdown("""
    Welcome to the interactive dashboard built using Streamlit, SQL, and Python.

    **What you can explore:**
    - Aggregated user, transaction, and insurance trends
    - Insurance patterns by district using map-level data
    - Top performing states by users, transactions, and insurance

    **Skills Demonstrated:** SQL, Data Analysis, Streamlit, Data Visualization
    """)

# ------------------ AGGREGATED --------------------
elif section == "Aggregated":
    st.header("📈 Aggregated Data Analysis")

    query = """
    SELECT year, quarter, state, SUM(user_count) AS users, SUM(transaction_amount) AS amount
    FROM aggregated_user au
    JOIN aggregated_transaction at ON au.state = at.state AND au.year = at.year AND au.quarter = at.quarter
    GROUP BY year, quarter, state
    ORDER BY year, quarter
    """
    df = pd.read_sql(query, engine)

    years = sorted(df['year'].unique())
    selected_year = st.selectbox("Select Year", years, index=len(years)-1)

    df_year = df[df['year'] == selected_year]
    st.write(f"### Users and Transaction Amount in {selected_year}")
    st.dataframe(df_year)

    fig, ax = plt.subplots(figsize=(10,6))
    sns.barplot(x='state', y='users', data=df_year, color='skyblue')
    plt.xticks(rotation=45)
    plt.title("Registered Users by State")
    st.pyplot(fig)

    fig2, ax2 = plt.subplots(figsize=(10,6))
    sns.barplot(x='state', y='amount', data=df_year, color='salmon')
    plt.xticks(rotation=45)
    plt.title("Transaction Amount by State")
    st.pyplot(fig2)

# ------------------ MAP INSURANCE --------------------
elif section == "Map Insurance":
    st.header("🗺️ Map Insurance Analysis")

    query = "SELECT * FROM map_insurance"
    df = pd.read_sql(query, engine)

    years = sorted(df['year'].unique())
    selected_year = st.selectbox("Select Year", years)
    states = sorted(df['state'].unique())
    selected_state = st.selectbox("Select State", states)

    filtered_df = df[(df['year'] == selected_year) & (df['state'] == selected_state)]
    st.dataframe(filtered_df)

    if not filtered_df.empty:
        fig, ax1 = plt.subplots(figsize=(10,6))
        sns.barplot(x='district', y='insurance_count', data=filtered_df.sort_values(by='insurance_count', ascending=False), color='lightblue')
        plt.xticks(rotation=45)
        plt.title(f"Insurance Count by District in {selected_state}, {selected_year}")
        st.pyplot(fig)

        fig2, ax2 = plt.subplots(figsize=(10,6))
        sns.barplot(x='district', y='insurance_amount', data=filtered_df.sort_values(by='insurance_amount', ascending=False), color='lightgreen')
        plt.xticks(rotation=45)
        plt.title(f"Insurance Amount by District in {selected_state}, {selected_year}")
        st.pyplot(fig2)
    else:
        st.warning("No data available for this selection.")

# ------------------ TOP TABLES --------------------
elif section == "Top Tables":
    st.header("🏆 Top Performing States")

    # Registered Users
    query_users = "SELECT state, SUM(registered_users) AS total_users FROM top_user GROUP BY state ORDER BY total_users DESC"
    df_users = pd.read_sql(query_users, engine)

    fig1, ax1 = plt.subplots(figsize=(10,6))
    sns.barplot(data=df_users, y='state', x='total_users', palette='magma')
    plt.title("Top States by Registered Users")
    st.pyplot(fig1)

    # Transaction Amount
    query_map = "SELECT state, SUM(transaction_amount) AS total_amount FROM top_map GROUP BY state ORDER BY total_amount DESC"
    df_map = pd.read_sql(query_map, engine)

    fig2, ax2 = plt.subplots(figsize=(10,6))
    sns.barplot(data=df_map, y='state', x='total_amount', palette='Blues')
    plt.title("Top States by Transaction Amount")
    st.pyplot(fig2)

    # Insurance Amount
    query_insurance = "SELECT state, SUM(insurance_amount) AS total_insurance FROM top_insurance GROUP BY state ORDER BY total_insurance DESC"
    df_insurance = pd.read_sql(query_insurance, engine)

    fig3, ax3 = plt.subplots(figsize=(10,6))
    sns.barplot(data=df_insurance, y='state', x='total_insurance', palette='coolwarm')
    plt.title("Top States by Insurance Amount")
    st.pyplot(fig3)
