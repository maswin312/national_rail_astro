# National Rail UK Ticket Sales Data Pipeline

This project is a data pipeline built to handle and analyze mock train ticket sales data for National Rail in the UK. The pipeline processes data from January to April 2024, detailing various aspects such as ticket types, journey dates & times, departure & arrival stations, ticket prices, and more. This README provides an overview of the project, the tools used, and step-by-step instructions on reproducing the pipeline.

## Table of Contents

1. [Project Overview](#project-overview)
2. [Data Description](#data-description)
3. [Tools and Technologies](#tools-and-technologies)
4. [Architecture Diagram](#architecture-diagram)


## Project Overview

The National Rail UK Ticket Sales Data Pipeline project is designed to simulate and manage the data processing workflow for train ticket sales across the United Kingdom. This project aims to provide a comprehensive data ingestion, transformation, orchestration, and visualization pipeline, leveraging modern data engineering tools.

### Objectives

- **Data Ingestion:** Automatically extract and load mock train ticket sales data into a data warehouse.
- **Data Transformation:** Clean, transform, and aggregate, raw data to create meaningful insights using dbt.
- **Data Orchestration:** Schedule and manage the end-to-end data pipeline using Airflow.
- **Data Visualization:** Create interactive dashboards to visualize key metrics and trends in ticket sales data using Looker.
- **Infrastructure as Code:** Use Terraform to provision and manage cloud infrastructure, ensuring reproducibility and scalability.



## Data Description 

The dataset used in this project simulates train ticket sales for National Rail in the UK from January to April 2024. The data is designed to resemble real-world ticket sales and includes various attributes crucial for analyzing travel patterns, pricing strategies, and station usage. 

You can download the data here : https://mavenanalytics.io/challenges/maven-rail-challenge/08941141-d23f-4cc9-93a3-4c25ed06e1c3

## Tools and Technologies

This project leverages powerful tools and technologies to build a robust and scalable data pipeline. Below is a brief overview of each tool used:

- **Airbyte:** An open-source data integration platform that extracts and loads data from data sources into BigQuery. Airbyte handles the data ingestion,

- **Terraform:** Terraform is An Infrastructure as Code (IaC) tool that automates the provisioning and management of cloud resources. It is used to set up and manage the infrastructure, including BigQuery, Airbyte, and Airflow.

- **BigQuery:** A fully managed data warehouse provided by Google Cloud. BigQuery stores and analyzes the ingested data, offering scalability and fast query performance.

- **DBT (Data Build Tool):** DBT is a transformation tool that enables data modeling and transformation within BigQuery. It is used to clean, transform, and organize raw data into analytics-ready tables.

- **Airflow:** A workflow orchestration tool used to schedule and manage the various tasks within the pipeline. It ensures that each component of the pipeline runs in the correct sequence and on time.

- **Looker:** A business intelligence tool that connects to BigQuery to create interactive dashboards and reports. It visualizes the processed data, providing insights into ticket sales and other trends.

These tools work together to create an end-to-end data pipeline, from data ingestion to visualization.

## Architecture Diagram
The architecture of this data pipeline is designed to be modular and scalable, ensuring that each component can be managed and extended independently. Below is the architecture diagram :


![](images/architecture.gif)

### Data Flow

1. **Infrastructure As Code:** Terraform is used to automate the creation of the BigQuery dataset and configure the Airbyte connection, ensuring consistent and repeatable infrastructure setup.
2. **Data Ingestion:** Airbyte extracts data from the source (Google Sheets) and loads it into BigQuery.
3. **Data Transformation:** dbt transforms the raw data in BigQuery into structured, analytics-ready tables.
4. **Data Orchestration:** Airflow manages and schedules the pipeline's various tasks, ensuring they run in the correct order.
5. **Data Visualization:** Looker connects to the transformed data in BigQuery to create dashboards and reports.
