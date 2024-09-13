
-------- SCENARIO & APPROACH --------


/*
Scenario 1: Sales aims to pinpoint the top-spending customers to offer them exclusive discounts. 
By focusing on high-value customers, the company seeks to enhance customer retention and 
drive revenue growth, as these top spenders are more likely to respond positively to targeted 
promotions and continue their purchases.
--Identify the Top 5 Customers:
*/

SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total_spent
FROM customer as c
JOIN 
invoice as i 
ON c.customer_id = i.customer_id
GROUP BY 1,2,3
ORDER BY 4 DESC
LIMIT 5;


/*
Scenario 2: The Board needs to identify the most senior employee in the department to 
temporarily take over decision-making responsibilities while the department head is on leave. 
This will ensure continuity in leadership and maintain effective operations during the absence.
-- Seniormost Employee based on job title:
*/

SELECT employee_id, first_name, last_name, title, levels
FROM employee
GROUP BY employee_id
ORDER BY levels DESC;
LIMIT 1


/*
Scenario 3: One of the country's top artists wants to start their tour in the country with the 
highest sales volume and market presence. This strategy aims to maximize the impact and success
of the tour by targeting the location with the strongest fan base and sales potential.
-- Country with most invoices:
*/

SELECT COUNT(*) AS c, billing_country
FROM invoice
GROUP BY billing_country,
ORDER BY c DESC
LIMIT 1;


/* 
Scenario 4: The company needs to analyze the data to design incentive programs, such as bonuses
or promotions, for the three employees who have processed the most invoices. This approach 
ensures that the rewards are aligned with employee contributions and recognizes those who 
significantly impact the company's revenue through their invoicing efforts.
-- Top 3 Employees based on Invoice Contributions:
*/

SELECT c.first_name,c.last_name,i.total
FROM invoice AS i 
JOIN
customer AS c
ON i.customer_id=c.customer_id
ORDER BY 3 DESC
LIMIT 3;


/* 
Scenario 5: One of the city's top artists wants to launch their tour in the city with the 
highest sales volume and market presence. This choice aims to maximize tour success by 
starting in a location with the strongest fan base and sales potential. 
-- City with most invoices:
*/

SELECT SUM(total), billing_city FROM invoice
GROUP  BY 2
ORDER BY 1 DESC
LIMIT 1;


/* 
Scenario 6: The company aims to offer exclusive deals or VIP upgrades to one highly loyal 
customer. This gesture is designed to reward and retain a customer who has demonstrated 
exceptional loyalty and significant engagement with the company’s products or services.
-- The Top Spending Customer:
*/

SELECT c.customer_id,sum(total), c.first_name, c.last_name
FROM invoice AS i
JOIN
customer AS c
ON i.customer_id=c.customer_id
GROUP BY 1
ORDER BY 2 DESC;


/* 
Scenario 7: The company plans to organize concerts and special events featuring top rock bands 
with strong track records to ensure high attendance and maximize audience engagement.
-- Contact Details of Rock Music Listeners: Email, First Name, Last Name:
*/

SELECT DISTINCT email,first_name, last_name
FROM customer
JOIN invoice 
on customer.customer_id = invoice.customer_id
JOIN invoice_line 
on invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre 
	on track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY 1;


/* 
Scenario 8: The company aims to curate playlists with extended tracks for listeners who prefer 
longer listening sessions, with the goal of enhancing user satisfaction and keeping these 
engaged listeners more satisfied with their experience.
-- Top 10 Rock Bands: Artist Name and Total Track Count:
*/

select artist.artist_id, artist.name,count(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;


/* 
Scenario 9: The company needs to evaluate the viability of longer tracks by analyzing audience 
preferences. To make an informed decision, they must review all track names that exceed the 
average song length, including the name and duration (in milliseconds) for each. The tracks 
should be ordered by length, starting with the longest, to identify trends and potential for 
listener engagement with extended tracks.
--All the track names that have a song length longer than the average song length
  Name and Milliseconds for each track
  Order by the song length with the longest songs listed first
*/

SELECT name,milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_track_length 
	FROM track )
ORDER BY milliseconds DESC;


/* 
Scenario 10: The company aims to strategically focus on promoting emerging artists or investing 
in high-demand artists to boost visibility and capitalize on market trends, ensuring 
sustained growth and audience engagement.
-- Customer's details Spending on Artists:
*/

WITH best_selling_artist AS (
	SELECT artist.artist_id AS artist_id, artist.name AS artist_name, SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
	FROM invoice_line
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN album ON album.album_id = track.album_id
	JOIN artist ON artist.artist_id = album.artist_id
	GROUP BY 1
	ORDER BY 3 DESC
	LIMIT 1
)
SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC;


/* 
Scenario 11: The company seeks to identify the most popular music genre in each country by 
analyzing purchase data. The most popular genre will be determined as the one with the 
highest sales in each country, allowing the company to tailor its offerings and marketing 
strategies to align with regional preferences.
-- Company finds out the most popular music Genre for each country
-- Determine the most popular genre as the genre with the highest amount of purchases
-- Determines each country along with the top Genre
*/

WITH popular_genre AS 
(
    SELECT COUNT(invoice_line.quantity) AS purchases, customer.country, genre.name, genre.genre_id, 
	ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC) AS RowNo 
    FROM invoice_line 
	JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
	JOIN customer ON customer.customer_id = invoice.customer_id
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN genre ON genre.genre_id = track.genre_id
	GROUP BY 2,3,4
	ORDER BY 2 ASC, 1 DESC
)
SELECT * FROM popular_genre WHERE RowNo <= 1


/* 
Scenario 12: The company prefers targeted promotions in specific countries over regular 
promotions to better cater to local market demands. High-value customers in these regions are 
offered VIP services to enhance loyalty and maximize revenue from their top spenders. 
-- Identifying the Highest-Spending Customer in Countries with Shared Top Expenditures:
*/

WITH Customer_with_country AS (
		SELECT customer.customer_id,first_name,last_name,billing_country,SUM(total) AS total_spending,
	    ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY SUM(total) DESC) AS RowNo 
		FROM invoice
		JOIN customer ON customer.customer_id = invoice.customer_id
		GROUP BY 1,2,3,4
		ORDER BY 4 ASC,5 DESC)
SELECT * FROM Customer_with_country WHERE RowNo <= 1


