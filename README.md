Project Overview

This project analyzes sales and customer data for "Monday Coffee," an online retailer operating in India since January 2023. The main goal is to identify the top three Indian cities ideal for new coffee shop locations, based on consumer demand and sales performance. Using SQL analytics, this project provides data-driven insights to support strategic business expansion.

Database Schema

The analysis uses data from sales, customers, city (including population and estimated_rent), and products tables.

Key Analyses & Insights

The project addresses critical business questions to inform strategic decisions:

Market Demand:

Estimated Coffee Consumers: Calculated by applying a 25% consumption rate to each city's population, indicating potential market size.

Total Revenue & Product Sales: Analyzed total coffee sales revenue for Q4 2023 and identified unit sales for each product to understand recent performance and product popularity.

Customer & City Performance:

Average Sales per City: Determined average transaction values to gauge purchasing power.

Unique Customers: Counted distinct customers per city to assess market penetration.

Top Selling Products by City: Identified localized product preferences for inventory planning.

Strategic Evaluation:

Average Sale vs. Rent: Compared sales performance with city-specific estimated rent for financial viability.

Monthly Sales Growth: Used LAG() functions to calculate month-over-month sales growth/decline, revealing trends and seasonality.

Top City Recommendation (Market Potential Analysis):

Final Output: Identified the top 3 cities with the highest sales, providing city_name, total_sales, total_rent, total_customers, and estimated_coffee_consumers to support strategic location recommendations.

Technologies
SQL (Transact-SQL): For data querying, aggregation, and advanced analytics (CTEs, Window Functions).

Microsoft SQL Server Management Studio (SSMS): For database interaction and execution.

Conclusion
This project delivers actionable insights, culminating in a data-backed recommendation for Monday Coffee's physical expansion in India, highlighting strong potential markets and key performance indicators.

