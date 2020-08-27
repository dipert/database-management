-- Group Members: John Oper, Josh Dipert

-- QUERY 1
CREATE TABLE query1 AS 
	SELECT
		c.category_id
		, c.name
		, COUNT(hc.business_id) AS count
	FROM category c, hascategory hc
	WHERE c.category_id = hc.category_id
	GROUP BY 1, 2;


-- QUERY 2

CREATE TABLE query2 AS 
	SELECT
		c.category_id
		, c.name
		, AVG(r.rating) AS rating
	FROM category c, hascategory hc, review r
	WHERE c.category_id = hc.category_id
		AND hc.business_id = r.business_id
	GROUP BY 1, 2;


-- QUERY 3

CREATE TABLE query3 AS 
	SELECT
		b.business_id
		, b.title
		, r.CountOfRatings
	FROM business b
		 , (SELECT
				r.business_id
				, COUNT(r.rating) AS CountOfRatings
			FROM review r
			GROUP BY 1
			HAVING COUNT(r.rating) >= 4000) r
	WHERE b.business_id = r.business_id;
	

-- QUERY 4

CREATE TABLE query4 AS 
	SELECT DISTINCT
		b.business_id
		, b.title
	FROM business b
	WHERE b.business_id IN (
			SELECT
				hc.business_id
			FROM hascategory hc, category c
			WHERE hc.category_id = c.category_id
			AND c.name = 'Chinese'
			);


-- QUERY 5

CREATE TABLE query5 AS 
	SELECT DISTINCT
		b.business_id
		, b.title
		, AVG(r.rating) AS average
	FROM review r, business b
	WHERE r.business_id = b.business_id
	GROUP BY 1, 2;

-- QUERY 6

CREATE TABLE query6 AS 
	SELECT
		AVG(r.rating) AS average
	FROM review r
	WHERE r.business_id IN (
			SELECT
				hc.business_id
			FROM hascategory hc, category c
			WHERE hc.category_id = c.category_id
				AND c.name = 'Chinese'
			);


-- QUERY 7

CREATE TABLE query7 AS 
	SELECT
		AVG(r.rating) AS average
	FROM review r
	WHERE r.business_id IN (
			SELECT
				hc.business_id
			FROM hascategory hc, category c
			WHERE hc.category_id = c.category_id
				AND c.name = 'Chinese'
				AND hc.business_id IN (
						SELECT
							hc.business_id
						FROM hascategory hc, category c
						WHERE hc.category_id = c.category_id
						AND c.name = 'Japanese'
					)
			);


-- QUERY 8

CREATE TABLE query8 AS 
	SELECT
		AVG(r.rating) AS average
	FROM review r
	WHERE r.business_id IN (
			SELECT
				hc.business_id
			FROM hascategory hc, category c
			WHERE hc.category_id = c.category_id
				AND c.name = 'Chinese'
				AND hc.business_id NOT IN (
						SELECT
							hc.business_id
						FROM hascategory hc, category c
						WHERE hc.category_id = c.category_id
						AND c.name = 'Japanese'
					)
			);


-- QUERY 9

CREATE TABLE query9 AS 
	SELECT DISTINCT
		r.business_id
		, AVG(r.rating) AS average
	FROM review r
	WHERE r.user_id = 'CxDOIDnH8gp9KXzpBHJYXw'
	GROUP BY 1;


-- QUERY 10
CREATE TABLE query10 AS 
SELECT DISTINCT 
	b.business_id
	, b.title
FROM (
		SELECT
			business_id1
			, business_id2
			, avg_rating1
			, avg_rating2
			, 1-(ABS(avg_rating2-avg_rating1))/5 AS sim
		FROM (	SELECT
					r.business_id AS business_id1
					, AVG(r.rating) AS avg_rating1
				FROM review r
				WHERE r.user_id = 'ogAjjUdQWzE_zlAGZWMd0g'	
				GROUP BY 1
			) b_L 
			, (	SELECT
					r.business_id AS business_id2
					, AVG(r.rating) AS avg_rating2
				FROM review r
				GROUP BY 1
			) b_i
		WHERE business_id1 <> business_id2
	) s
	, business b
WHERE b.business_id = s.business_id2
	AND (s.sim*s.avg_rating1)/s.sim > 4.33;





