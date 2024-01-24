CREATE TABLE parent_table(
    parent_id INT NOT NULL,
    child_id INT NOT NULL,
    status VARCHAR(50) NOT NULL

)
--@block
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'parent_table' AND table_schema = 'public';

--@block

INSERT INTO parent_table (parent_id,child_id,status)
VALUES (1,3,'Active'),
(1,4,'InActive'),
(1,5,'Active'),
(1,6,'InActive'),
(2,7,'Active'),
(2,8,'InActive'),
(3,9,'InActive'),
(4,10,'InActive'),
(4,11,'Active'),
(5,11,'Active'),
(5,13,'InActive');

--@block
SELECT * FROM parent_table
--@block
WITH active as(
    SELECT parent_id,status from 
    parent_table WHERE status = 'Active'
    GROUP BY parent_id,status
),
    inactive as(
        SELECT parent_id,status FROM parent_table 
        a WHERE a.parent_id not in (
            SELECT parent_id from active
        )
    )
SELECT * FROM inactive
UNION
SELECT * FROM active ORDER BY parent_id
;

--@block
with cte as (
    SELECT *,
    row_number() OVER (partition by parent_id ORDER by
    status) as rn
    FROM parent_table ORDER BY parent_id,status
)
SELECT parent_id,status FROM cte WHERE rn=1;

--@block
SELECT parent_id,status FROM (
    SELECT *,
    row_number() OVER (partition by parent_id 
    ORDER by status) as rn
    FROM parent_table ORDER BY parent_id,
    status
) x
WHERE x.rn=1;
--@block
SELECT a.parent_id,
    CASE WHEN b.status IS NULL THEN 'InActive'
    ELSE b.status END as status

FROM (
    SELECT DISTINCT parent_id FROM parent_table
) a
LEFT JOIN (
    SELECT DISTINCT parent_id,status FROM parent_table
    WHERE status = 'Active')
b ON b.parent_id=a.parent_id
ORDER BY a.parent_id;


;
--@block
UPDATE parent_table SET status = 'InActive'
WHERE parent_id = 5 AND child_id = 11;


