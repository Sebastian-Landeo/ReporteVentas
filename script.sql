WITH cte as(
	SELECT
		a.Product,
		a.Category,
		a.Brand,
		a.Description,
		a.Sale_Price,
		a.Cost_Price,
		a.Image_url,
		b.Date,
		b.Customer_Type,
		b.Discount_Band,
		b.Units_Sold,
		(sale_price * Units_Sold) AS revenue,
		(cost_price * Units_Sold) AS total_cost,
		FORMAT(date, 'MMMM') AS month,
		FORMAT(date, 'yyyy') AS year
		FROM product_data a
		JOIN product_sales b
		ON a.Product_ID = b.Product
)

SELECT *,
(1-discount*1.0/100 )*revenue AS discount_revenue
FROM cte as a
JOIN discount_data as b
ON a.Discount_Band = b.Discount_Band AND a.month = b.Month;

UPDATE discount_data
SET Month = CASE Month
    WHEN 'January' THEN 'enero'
    WHEN 'February' THEN 'febrero'
    WHEN 'March' THEN 'marzo'
    WHEN 'April' THEN 'abril'
    WHEN 'May' THEN 'mayo'
    WHEN 'June' THEN 'junio'
    WHEN 'July' THEN 'julio'
    WHEN 'August' THEN 'agosto'
    WHEN 'September' THEN 'septiembre'
    WHEN 'October' THEN 'octubre'
    WHEN 'November' THEN 'noviembre'
    WHEN 'December' THEN 'diciembre'
END;

UPDATE product_sales
SET Date = CONVERT(DATE, FORMAT(Date, 'yyyy-MM-dd', 'en-US'));
