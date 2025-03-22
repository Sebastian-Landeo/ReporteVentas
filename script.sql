use product_sales;
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

-- Traducciones al espa�ol

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

-- Categoria

UPDATE Product_data
SET category = 
    CASE 
        WHEN category = 'Audio Interface' THEN 'Interfaz de Audio'
        WHEN category = 'Condenser Microphone' THEN 'Micr�fono de Condensador'
        WHEN category = 'Dynamic Microphone' THEN 'Micr�fono Din�mico'
        WHEN category = 'Recording Bundle' THEN 'Paquete de Grabaci�n'
        WHEN category = 'Streaming Microphone' THEN 'Micr�fono para Streaming'
        WHEN category = 'Wireless Gaming Headset' THEN 'Auriculares Inal�mbricos para Gaming'
        ELSE category
    END;

SELECT DISTINCT(Discount_Band)
  FROM [product_sales].[dbo].[discount_data]

-- Tipo de descuento

UPDATE discount_data
SET discount_band = 
    CASE 
        WHEN discount_band = 'high' THEN 'alto'
        WHEN discount_band = 'medium' THEN 'medio'
        WHEN discount_band = 'low' THEN 'bajo'
        WHEN discount_band = 'none' THEN 'ninguno'
        ELSE discount_band
END;

SELECT DISTINCT(Category)
  FROM [product_sales].[dbo].[Product_data]


-- Descripci�n
ALTER TABLE Product_data 
ALTER COLUMN description NVARCHAR(500);


UPDATE Product_data
SET description = CASE 
    WHEN Product_ID = 'SR1001' THEN 
        'Un vers�til micr�fono din�mico USB/XLR ideal para podcasting, streaming y grabaci�n vocal. Cuenta con DSP incorporado para personalizaci�n del sonido y excelente aislamiento de la voz, inspirado en el legendario micr�fono SM7B.'
    WHEN Product_ID = 'RR10020' THEN 
        'Un popular micr�fono de condensador conocido por su bajo ruido propio y su calidad de sonido clara, perfecto para grabaciones vocales e instrumentales. Incluye un soporte antivibraci�n y un filtro antipop, ideal para estudios caseros.'
    WHEN Product_ID = 'FR10021' THEN 
        'Una interfaz de audio USB compacta con dos entradas, que permite conectar micr�fonos e instrumentos para grabaciones de alta calidad. Destacada por su facilidad de uso y rendimiento de baja latencia, es una opci�n esencial tanto para principiantes como para profesionales.'
    WHEN Product_ID = 'PS10022' THEN 
        'Un paquete de grabaci�n completo que incluye una interfaz de audio, un micr�fono de condensador M7, auriculares y software. Este paquete todo en uno est� dise�ado para m�sicos, podcasters y streamers que buscan una soluci�n port�til y asequible para grabaciones.'
    WHEN Product_ID = 'HY1004' THEN 
        'Un micr�fono de condensador USB con iluminaci�n RGB personalizable, funci�n de silencio con toque y cuatro patrones polares para opciones de grabaci�n vers�tiles. Ideal para gaming, streaming y creaci�n de contenido.'
    WHEN Product_ID = 'AR1200' THEN 
        'Un auricular inal�mbrico para gaming con excelente calidad de sonido y larga duraci�n de bater�a, dise�ado espec�ficamente para compatibilidad con PlayStation 5. Cuenta con un micr�fono retr�ctil, c�modas almohadillas y una construcci�n duradera.'
    ELSE description
END;

-- Tipo de cliente

UPDATE product_sales
SET customer_type = 
    CASE 
        WHEN customer_type = 'Education' THEN 'Educaci�n'
        WHEN customer_type = 'Creator' THEN 'Creador'
        WHEN customer_type = 'Government' THEN 'Gobierno'
        WHEN customer_type = 'Enterprise' THEN 'Empresa'
        WHEN customer_type = 'Small Business' THEN 'Peque�a Empresa'
        ELSE customer_type
    END;

SELECT DISTINCT(Customer_Type)
  FROM [product_sales].[dbo].[product_sales]

-- Pa�ses

UPDATE product_sales
SET Country = 
    CASE 
        WHEN Country = 'United States of America' THEN 'Estados Unidos'
        WHEN Country = 'Germany' THEN 'Alemania'
        WHEN Country = 'Mexico' THEN 'M�xico'
        WHEN Country = 'Canada' THEN 'Canad�'
        WHEN Country = 'France' THEN 'Francia'
        ELSE Country
    END;

	SELECT DISTINCT(Country)
  FROM [product_sales].[dbo].[product_sales]

  -- Descuentos en product sales
    UPDATE product_sales
SET Discount_Band = 
    CASE 
        WHEN Discount_Band = 'None' THEN 'ninguno'
        WHEN Discount_Band = 'Low' THEN 'bajo'
        WHEN Discount_Band = 'Medium' THEN 'medio'
        WHEN Discount_Band = 'High' THEN 'alto'
        ELSE Discount_Band
    END;
SELECT DISTINCT(Discount_Band)
  FROM [product_sales].[dbo].[product_sales]