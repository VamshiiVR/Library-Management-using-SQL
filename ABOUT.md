# Music Management Suite with SQL
Welcome to Music Data Insights, a showcase of my expertise in using SQL to tackle key data challenges within the music industry. This project features a well-structured database encompassing essential business components like artist and album management, customer interactions, sales records, and employee performance.

Through this work, I’ve addressed a variety of real-world scenarios, applying SQL to unlock critical insights that drive decision-making and operational improvements. From analyzing customer behaviors to optimizing sales strategies, each solution highlights my ability to transform raw data into valuable business intelligence.

**RDBMS:** Postgresql

**Approach:** Data Exploration

# Highlights
- **Joins**: Different types of joins (e.g., `INNER JOIN`) are used to merge data from multiple tables such as customers, invoices, tracks, and genres.
  
- **Aggregations**: Functions like `SUM()`, `COUNT()`, and `AVG()` are employed to calculate totals (e.g., total sales, number of purchases, track lengths).

- **Ranking and Segmentation**: Window functions like `ROW_NUMBER()` and `RANK()` help identify top performers (e.g., customers, employees, genres) within specific groups.

- **Filtering and Conditions**: `WHERE` and `HAVING` clauses are used to filter data based on certain conditions (e.g., track length exceeding the average, specific genres or countries).

- **Subqueries and CTEs**: Common Table Expressions (`WITH` clauses) and subqueries help manage complex logic and calculations, like determining the most popular genres or best-selling artists.

- **Grouping and Sorting**: `GROUP BY` and `ORDER BY` are used to categorize data (e.g., by country, artist, or genre) and sort it based on desired metrics (e.g., total spending, track count).

- **Limiting Results**: `LIMIT` is used to restrict the number of rows returned, focusing on top results (e.g., top customers, highest-selling genres).

# Database Schema
Here are descriptions of the database tables:

**Album:** Stores information about albums, including the album's title and the associated artist.

**Artist:** Contains details about artists, such as their unique ID and name.

**Customer:** Holds customer data including contact information and their support representative.

**Employee:** Captures details of employees, including their name, title, hire date, and reporting structure.

**Genre:** Lists different genres of music, identified by genre ID and name.

**Invoice:** Tracks sales transactions made by customers, including billing details and total amounts.

**Invoice Line:** Represents individual items in each invoice, including track and pricing details.

**Media Type:** Categorizes media formats for tracks, such as digital or physical.

**Playlist:** Stores playlists created within the music platform, identified by playlist ID and name.

**Playlist Track:** Associates tracks with playlists, linking track IDs to playlist IDs.

**Track:** Contains information about individual tracks, including the album, genre, media type, and pricing.

![Music label ERD](https://github.com/user-attachments/assets/d32a39eb-3a98-4efc-b61f-b839b8827457)

# Scenarios and Approach
**Scenario 1**: Sales aims to pinpoint the top-spending customers to offer them exclusive discounts. 
By focusing on high-value customers, the company seeks to enhance customer retention and 
drive revenue growth, as these top spenders are more likely to respond positively to targeted 
promotions and continue their purchases.

**Scenario 2:** The Board needs to identify the most senior employee in the department to 
temporarily take over decision-making responsibilities while the department head is on leave. 
This will ensure continuity in leadership and maintain effective operations during the absence.

**Scenario 3:** One of the country's top artists wants to start their tour in the country with the 
highest sales volume and market presence. This strategy aims to maximize the impact and success
of the tour by targeting the location with the strongest fan base and sales potential.

**Scenario 4:** The company needs to analyze the data to design incentive programs, such as bonuses
or promotions, for the three employees who have processed the most invoices. This approach 
ensures that the rewards are aligned with employee contributions and recognizes those who 
significantly impact the company's revenue through their invoicing efforts.

**Scenario 5:** One of the city's top artists wants to launch their tour in the city with the 
highest sales volume and market presence. This choice aims to maximize tour success by 
starting in a location with the strongest fan base and sales potential. 

**Scenario 6:** The company aims to offer exclusive deals or VIP upgrades to one highly loyal 
customer. This gesture is designed to reward and retain a customer who has demonstrated 
exceptional loyalty and significant engagement with the company’s products or services.

**Scenario 7:** The company plans to organize concerts and special events featuring top rock bands 
with strong track records to ensure high attendance and maximize audience engagement.

**Scenario 8:** The company aims to curate playlists with extended tracks for listeners who prefer 
longer listening sessions, with the goal of enhancing user satisfaction and keeping these 
engaged listeners more satisfied with their experience.

**Scenario 9:** The company needs to evaluate the viability of longer tracks by analyzing audience 
preferences. To make an informed decision, they must review all track names that exceed the 
average song length, including the name and duration (in milliseconds) for each. The tracks 
should be ordered by length, starting with the longest, to identify trends and potential for 
listener engagement with extended tracks.

**Scenario 10:** The company aims to strategically focus on promoting emerging artists or investing 
in high-demand artists to boost visibility and capitalize on market trends, ensuring 
sustained growth and audience engagement.

**Scenario 11:** The company seeks to identify the most popular music genre in each country by 
analyzing purchase data. The most popular genre will be determined as the one with the 
highest sales in each country, allowing the company to tailor its offerings and marketing 
strategies to align with regional preferences.

**Scenario 12:** The company prefers targeted promotions in specific countries over regular 
promotions to better cater to local market demands. High-value customers in these regions are 
offered VIP services to enhance loyalty and maximize revenue from their top spenders.


