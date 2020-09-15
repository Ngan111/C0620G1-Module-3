select productCode,productName, quantityInStock,buyPrice from products
where buyPrice > 56.76 and quantityInStock > 10;

select productCode,productName,buyPrice,textDescription from products
inner join productlines
where buyPrice > 56.76 and buyPrice < 95.59;

select productName, productLine, productVendor, buyPrice from products
where productLine = 'Classic Cars' or  productVendor = 'Min Lin Diecast';