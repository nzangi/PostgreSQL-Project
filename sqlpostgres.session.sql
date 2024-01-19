--@block
SELECT * FROM artist;

--@block
SELECT * FROM canvas_size;

--@block

SELECT * FROM image_link;

--@block
SELECT * FROM museum;

--@block
SELECT * FROM museum_hours;

--@block
SELECT * FROM product_size;

--@block
SELECT * FROM subject;

--@block
SELECT * FROM work;

--@block
/*How many paintings have an asking price of more than their regular price?*/
SELECT count(*) as total from product_size WHERE sale_price > regular_price;
--@block

select count(*) as total
from product_size
WHERE sale_price > regular_price;
--@block
/*Identify the paintings whose asking price is less than 50% of its regular price*/

SELECT * FROM product_size WHERE sale_price < (0.5 *regular_price)

--@block
/*Which canva size costs the most?
not working*/


SELECT c.label, p.sale_price from 
product_size p
JOIN canvas_size c ON p.size_id = c.size_id;
--@block

SELECT c.label, p.sale_price 
FROM product_size p
JOIN canvas_size c ON CAST(p.size_id AS bigint) = CAST(c.size_id AS bigint);

--@block
/*Fetch the top 10 most famous painting subject*/

SELECT DISTINCT  subject,count(*) FROM subject
s JOIN work w ON s.work_id = w.work_id GROUP BY
subject ORDER BY count(*) DESC LIMIT 5; 

--@block

SELECT * FROM museum;

--@block
/*Identify the museums which are open on both Sunday and Monday. Display museum name, city.*/

SELECT m.name,m.city FROM  
museum_hours  mh 
JOIN museum m ON mh.museum_id = m.museum_id
    WHERE day IN ('Sunday','Monday') GROUP BY m.name,m.city
    HAVING COUNT(day)=2 ;

 --@block
/*How many museums are open every single day?*/

SELECT count(*) FROM(
    SELECT museum_id,count(museum_id) FROM
    museum_hours GROUP BY museum_id 
    HAVING count(day)=7 
) x

--@block
/*A Which are the top 10 most popular museum? (Popularity is defined based on most no of paintings in a museum)*/

select m.museum_id,m.name,count(*) as number_of_paintings
FROM museum m JOIN
work w ON m.museum_id = w.museum_id
GROUP BY m.museum_id,m.name ORDER BY count(*) DESC LIMIT 10;

--@block
SELECT * FROM artist;

--@block
/* Who are the top 5 most popular artist? (Popularity is defined based on most no of paintings done by an artist)*/

SELECT  a.full_name,a.nationality,count(*) as number_of_paints
 FROM artist a JOIN work w ON a.artist_id=w.artist_id
 GROUP BY a.full_name,a.nationality ORDER BY
 count(*) DESC LIMIT 5;

 --@block
 /*Which museum is open for the longest during a day. Dispay museum name, state and hours open and which day?*/

SELECT m.name,m.state,mh.day
--,to_timestamp(open,'HH:MI: AM') as open_time
--, to_timestamp(close,'HH:MI: PM') as close_time
, to_timestamp(close,'HH:MI: PM') - to_timestamp(open,'HH:MI: AM') as duration
,rank() OVER (ORDER BY(to_timestamp(close,'HH:MI: PM') - to_timestamp(open,'HH:MI: AM')) DESC) rnk
FROM museum_hours mh JOIN museum m ON mh.museum_id=
m.museum_id
LIMIT 1;

--@block
/*A Which museum has the most no of most popular painting style?*/

SELECT m.name,w.style,count(*) as number_of_paints
FROM museum m JOIN work w ON m.museum_id = w.museum_id GROUP BY
m.name,w.style ORDER BY count(*) DESC LIMIT 1;

--@block
/*A Which country has the 5th highest no of paintings?*/

SELECT m.country ,count(*) as number_of_paints
FROM artist a JOIN work w ON a.artist_id = w.artist_id
JOIN museum m on m.museum_id = w.museum_id GROUP BY
m.country ORDER BY count(*) DESC LIMIT 5;

--@block
/*A Which are the 3 most popular and 3 least popular painting styles?*/

SELECT * FROM(
(SELECT style ,count(*) as no_of_paintings, 
'Most Popular' as remarks FROM work GROUP BY 
style ORDER BY count(*) DESC LIMIT 3
)
UNION ALL
(SELECT style , count(*) as no_of_paintings,
'Least Popular' as remarks FROM work GROUP BY style 
ORDER BY count(*) ASC LIMIT 3)
)
AS combined_results ORDER BY no_of_paintings DESC
;


--@block
/*A Which artist has the most no of Portraits paintings outside USA?. Display artist name, no of paintings and the artist nationality.*/

SELECT a.full_name,a.nationality,count(*) as number_of_paintings
FROM work w  JOIN artist a ON w.artist_id = a.artist_id
JOIN subject s ON s.work_id = w.work_id 
JOIN museum m ON m.museum_id = w.museum_id
WHERE m.country <> 'USA' AND s.subject = 'Portraits'
GROUP BY a.full_name,a.nationality ORDER BY count(*) DESC
LIMIT 5;


--@block
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'product_size';

--@block
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'canvas_size';









