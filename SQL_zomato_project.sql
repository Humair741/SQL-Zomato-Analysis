-- What is the total amount each customer spent on zomato?

SELECT 
    sales.userid, SUM(product.price) AS total_spent
FROM
    sales
        JOIN
    product ON product.product_id = sales.product_id
GROUP BY sales.userid;



-- How many days each customer visited zomato

SELECT 
    userid, COUNT(DISTINCT created_date) AS visits
FROM
    sales
GROUP BY userid;



-- What as the first product purchased by each customer?

SELECT 
	* 
FROM
	(SELECT *,
			RANK() OVER(PARTITION BY userid ORDER BY created_date) AS rnk 
		FROM sales ) a WHERE rnk = 1;



-- What is the most purchased item on the menu and how many times it was purchased by all customers?

SELECT userid, count(product_id) AS times_bought 
FROM sales
WHERE 
product_id = (SELECT 
					product_id
				FROM
					sales
				GROUP BY product_id
				ORDER BY COUNT(product_id) DESC
				LIMIT 1)
GROUP BY userid
ORDER BY userid ASC;



-- Which item was the most popular for each customer?

SELECT 
	* 
FROM
	(SELECT *, 
			RANK() OVER(PARTITION BY userid ORDER BY popular DESC) AS rnk
		FROM 
			(SELECT 
					userid, 
                    product_id, 
                    COUNT(product_id) AS popular
				FROM sales
				GROUP BY userid, product_id) a) b WHERE rnk = 1;
                


-- Which item was purchased first by the customer after they became a member

SELECT * 
FROM (
    SELECT c.*, 
           RANK() OVER (PARTITION BY userid ORDER BY created_date) AS rnk 
    FROM (
        SELECT a.userid, a.created_date, a.product_id, b.gold_signup_date 
        FROM sales a 
        INNER JOIN goldusers_signup b ON a.userid = b.userid 
        WHERE a.created_date >= b.gold_signup_date
    ) c
) d 
WHERE rnk = 1;



-- which item was purchased just before the customer became a member

SELECT * 
FROM (
    SELECT c.*, 
           RANK() OVER (PARTITION BY userid ORDER BY created_date) AS rnk 
    FROM (
        SELECT a.userid, a.created_date, a.product_id, b.gold_signup_date 
        FROM sales a 
        INNER JOIN goldusers_signup b ON a.userid = b.userid 
        WHERE a.created_date <= b.gold_signup_date
    ) c
) d 
WHERE rnk = 1;



-- what is te total orders and amount spent for each member before they became member

SELECT userid, COUNT(created_date) AS order_purchased, SUM(price) AS total_amt_spent FROM
(SELECT c.*, d.price FROM
(SELECT a.userid, a.created_date, a.product_id, b.gold_signup_date 
        FROM sales a 
        INNER JOIN goldusers_signup b ON a.userid = b.userid 
        WHERE a.created_date <= b.gold_signup_date
		) c INNER JOIN 
product d on c.product_id = d.product_id) e GROUP BY userid;



-- If buying each product generates points for eg 5rs=2 zomato points and each product has different purchasing points
-- for eg for p1 5rs=1 zomato point, p2 10rs=2 zomato points and p3 5rs=1 zomato point
-- calculate the pints collected by each customer and for which product most points have been given till now

SELECT 
    userid, 
    SUM(total_points) * 2.5 AS total_points_earned 
FROM
(
    SELECT 
        e.*, 
        amount / points AS total_points 
    FROM
    (
        SELECT 
            d.*, 
            CASE 
                WHEN product_id = 1 THEN 5 
                WHEN product_id = 2 THEN 2 
                WHEN product_id = 3 THEN 5 
                ELSE 0 
            END AS points 
        FROM
        (
            SELECT 
                c.userid, 
                c.product_id, 
                SUM(price) AS amount 
            FROM 
            (
                SELECT 
                    a.*, 
                    b.price 
                FROM 
                    sales a 
                INNER JOIN 
                    product b ON a.product_id = b.product_id
            ) c 
            GROUP BY 
                userid, product_id
        ) d
    ) e
) f 
GROUP BY 
    userid;


SELECT * 
FROM
(
    SELECT 
        *, 
        RANK() OVER (ORDER BY total_points_earned DESC) AS rnk 
    FROM
    (
        SELECT 
            product_id, 
            SUM(total_points) AS total_points_earned 
        FROM
        (
            SELECT 
                e.*, 
                amount / points AS total_points 
            FROM
            (
                SELECT 
                    d.*, 
                    CASE 
                        WHEN product_id = 1 THEN 5 
                        WHEN product_id = 2 THEN 2 
                        WHEN product_id = 3 THEN 5 
                        ELSE 0 
                    END AS points 
                FROM
                (
                    SELECT 
                        c.userid, 
                        c.product_id, 
                        SUM(price) AS amount 
                    FROM 
                    (
                        SELECT 
                            a.*, 
                            b.price 
                        FROM 
                            sales a 
                        INNER JOIN 
                            product b ON a.product_id = b.product_id
                    ) c 
                    GROUP BY 
                        userid, product_id
                ) d
            ) e
        ) f 
        GROUP BY 
            product_id
    ) g
) h 
WHERE rnk = 1;


