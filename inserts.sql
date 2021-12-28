-- Script name: inserts.sql
-- Author:      Alekhya Gandu
-- Purpose:     To populate the database 

 USE OnlineREtailDB2; 

#Inserting into General User table
INSERT INTO general_user(user_id, first_name, last_name, email, is_registered)
VALUES (1, 'Alex', 'Baggins', 'alexbaggins@gmail.com', 0);

INSERT INTO general_user(user_id, first_name, last_name, email, is_registered)
VALUES (2, 'John', 'Doe', 'johndoe@gmail.com', 1);

INSERT INTO general_user(user_id, first_name, last_name, email, is_registered)
VALUES (3, 'Macy', 'Marios', 'macymarios@gmail.com', 0);

#Inserting into Mailing List table
INSERT INTO mailing_list(mailing_list_id, mailing_list_name, mailing_list_category)
VALUES (1,'new in fashion', 'fashion'); 

INSERT INTO mailing_list(mailing_list_id, mailing_list_name, mailing_list_category)
VALUES (2, 'upcoming sales', 'sales');

INSERT INTO mailing_list(mailing_list_id, mailing_list_name, mailing_list_category)
VALUES (3, 'womens trending fashion', 'fashion');

#Inserting into Devices
INSERT INTO device(device_id, device_type, device_ip)
VALUES (1,'phone', '123.07.221');

INSERT INTO device(device_id, device_type, device_ip)
VALUES (2,'tab', '121.07.221');

INSERT INTO device(device_id, device_type, device_ip)
VALUES (3,'phone', '132.43.112');

#Inserting into Region table
INSERT INTO region(region_id, state, zip_code)
VALUES (1, 'california', 94001);

INSERT INTO region(region_id, state, zip_code)
VALUES (2, 'New Mexico', 87121);

INSERT INTO region(region_id, state, zip_code)
VALUES (3, 'washington', 98115);

#Inserting into Promotion
INSERT INTO promotion(promotion_id, promotion_type, promotion_limit)
VALUES (1, 'fashion promotion', 100); 

INSERT INTO promotion(promotion_id, promotion_type, promotion_limit)
VALUES (2, 'tech promotion', 320); 

INSERT INTO promotion(promotion_id, promotion_type, promotion_limit)
VALUES (3, 'furniture promotion', 200); 

#Inserting into Deliverers table
INSERT INTO deliverers(deliverer_id, package_weight,package_height, service_area)
VALUES (1,30,20,94002);

INSERT INTO deliverers(deliverer_id, package_weight,package_height, service_area)
VALUES (2,20,30,94001);

INSERT INTO deliverers(deliverer_id, package_weight,package_height, service_area)
VALUES (3,10,40,87123); 

#Inserting into products 
INSERT INTO products(product_id, product_name,product_price)
VALUES (1,'v-line t-shirt',100); 

INSERT INTO products(product_id, product_name,product_price)
VALUES (2,'google home',400); 

INSERT INTO products(product_id, product_name,product_price)
VALUES (3,'fancy color pencils',30); 

#Inserting into Assemblers 
INSERT INTO assemblers(assembler_id, first_name, last_name, assembly_line)
VALUES (1,'mohan','satyanarayana', 3);

INSERT INTO assemblers(assembler_id, first_name, last_name, assembly_line)
VALUES (2,'kevin','gochez', 2);

INSERT INTO assemblers(assembler_id, first_name, last_name, assembly_line)
VALUES (3,'ben','wang', 3);

#Inserting into categories 
INSERT INTO categories(category_id, category_name, description)
VALUES (1,'tech','the products belong to technology');

INSERT INTO categories(category_id, category_name, description)
VALUES (2,'fashion','the products belong to fashion related');

INSERT INTO categories(category_id, category_name, description)
VALUES (3,'furniture','the products belong to house');

#Inserting into Utility Suppliers
INSERT INTO utilities_supplier(utilities_supplier_id, supplier_name,utility_type)
VALUES (1, 'PG&E', 'power');

INSERT INTO utilities_supplier(utilities_supplier_id, supplier_name,utility_type)
VALUES (2, 'compB', 'water');

INSERT INTO utilities_supplier(utilities_supplier_id, supplier_name,utility_type)
VALUES (3, 'compC', 'gas');

#Inserting into supplier
INSERT INTO supplier(supplier_id, supplier_name,supplier_email)
VALUES (1,'Qcify', 'qcifycontact@qcify.com');

INSERT INTO supplier(supplier_id, supplier_name,supplier_email)
VALUES (2,'Menco', 'menco@inquires.com');

INSERT INTO supplier(supplier_id, supplier_name,supplier_email)
VALUES (3,'Epic Loften', 'epicinc@epicenquire.com');

#Inserting into stock
INSERT INTO stock(stock_id, quantity, description)
VALUES (1, 12, 'This stock is almost running out');

INSERT INTO stock(stock_id, quantity, description)
VALUES (2, 120, 'Good status of stock');

INSERT INTO stock(stock_id, quantity, description)
VALUES (3, 500, 'Good');

#Inserting into Payment Method 
INSERT INTO payment_method(payment_id, billing_address, payment_type, billing_amount)
VALUES (2541,'1205 Geraldine Way California 94002', 'credit', 120);

INSERT INTO payment_method(payment_id, billing_address, payment_type, billing_amount)
VALUES (12345,'1254 Costner Street California 94563', 'googlepay', 120);

INSERT INTO payment_method(payment_id, billing_address, payment_type, billing_amount)
VALUES (87135,'1201 Bank Lee Way Texas 75216', 'debit', 120);

#Inserting into FinancesDept
INSERT INTO finance_dept(finance_dept_id,payment_date,pay_to)
VALUES(1,'2020-06-18 10:34:09','companyInc');

INSERT INTO finance_dept(finance_dept_id,payment_date,pay_to)
VALUES(2,'2021-06-18 10:34:09','MacInc');

INSERT INTO finance_dept(finance_dept_id,payment_date,pay_to)
VALUES(3,'2020-12-18 9:34:09','IncsyCorp');

#Inserting into CompanyPayables
INSERT INTO company_payables(company_payables_id,amount_owed,description)
VALUES (1,5000,'company is owed $3210 for service repairs');

INSERT INTO company_payables(company_payables_id,amount_owed,description)
VALUES (2,3210,'company is owed $5000 for employee management');

INSERT INTO company_payables(company_payables_id,amount_owed,description)
VALUES (3,10000,'company is owed $10000 for consultancy services');

#Inserting into account 
INSERT INTO account(account_id, general_user, account_type, region, date_created,default_payment_method_id)
VALUES(1,1,0,2,'2019-06-18 10:34:09',2541); 

INSERT INTO account(account_id, general_user, account_type, region, date_created,default_payment_method_id)
VALUES(2,2,0,1,'2020-03-28 8:34:09',null); 

INSERT INTO account(account_id, general_user, account_type, region, date_created,default_payment_method_id)
VALUES(3,3,0,2,'2021-06-18 10:34:09',87135); 

#Inserting into orders 1-initiated, 2-pending, 3-ontheway
INSERT INTO orders(order_number,general_user,order_date,order_status,address_line1,address_line2,state,city,zip_code,phone,payment_method)
VALUES (1,2,'2020-06-18',1,'1207 Belmont Way','Calwort Street','California','San Francisco',94001,673829567,12345); 

INSERT INTO orders(order_number,general_user,order_date,order_status,address_line1,address_line2,state,city,zip_code,phone,payment_method)
VALUES (2,1,'2020-07-18',2,'120 Eddel Drive','Carson Way','Texas','Austin',75216,897468714,2541); 

INSERT INTO orders(order_number,general_user,order_date,order_status,address_line1,address_line2,state,city,zip_code,phone,payment_method)
VALUES (3,3,'2020-06-30',2,'12201 Bellevue','Edward Drive','California','Chico',93925,974140257,87135); 


#Inserting into Order_details
INSERT INTO order_details(order_details_id,products,orders,quantity_ordered,price_each)
VALUES (1,2,1,2,400);

INSERT INTO order_details(order_details_id,products,orders,quantity_ordered,price_each)
VALUES (2,2,2,1,400);

INSERT INTO order_details(order_details_id,products,orders,quantity_ordered,price_each)
VALUES (3,1,3,4,100);

#Inserting into categories_products
INSERT INTO categories_products(products,categories)
VALUES (1,2);

INSERT INTO categories_products(products,categories)
VALUES (2,1);

INSERT INTO categories_products(products,categories)
VALUES (3,3);

#Inserting into financedept_paymentmethod
INSERT INTO financedept_paymentmethod(finance_dept,payment_method)
VALUES (1,2541);

INSERT INTO financedept_paymentmethod(finance_dept,payment_method)
VALUES (2,12345);

INSERT INTO financedept_paymentmethod(finance_dept,payment_method)
VALUES (3,87135);

#Inserting into orders_delivery
INSERT INTO orders_delivery(deliverers, orders)
VALUES (1,2);

INSERT INTO orders_delivery(deliverers, orders)
VALUES (2,2);

INSERT INTO orders_delivery(deliverers, orders)
VALUES (3,1);

#Inserting into product_assembly
INSERT INTO product_assembly(products, assemblers)
VALUES (1,1);

INSERT INTO product_assembly(products, assemblers)
VALUES (2,2);

INSERT INTO product_assembly(products, assemblers)
VALUES (3,3);

#Inserting into product_promotion_info
INSERT INTO product_promotion_info(products, promotion, description)
Values (1,1,"Fashion Promotion");

INSERT INTO product_promotion_info(products, promotion, description)
Values (2,2,"Tech Promotion");

INSERT INTO product_promotion_info(products, promotion, description)
Values (3,3,"House Related Promotion");


#Inserting into promotion_account
INSERT INTO promotion_account(promotion, account)
VALUES (1,2);

INSERT INTO promotion_account(promotion, account)
VALUES (2,3);

INSERT INTO promotion_account(promotion, account)
VALUES (3,1);

#Inserting into receipt
INSERT INTO receipt(receipt_id, orders, general_user,description)
VALUES (1,1,2,"Order has been initiated");

INSERT INTO receipt(receipt_id, orders, general_user,description)
VALUES (2,2,1,"Order has been initiated");

INSERT INTO receipt(receipt_id, orders, general_user,description)
VALUES (3,3,3,"Order has been initiated");

#Inserting into session
INSERT INTO session(session_id, general_user, expiration, device_id)
VALUES (1,1,'2019-06-18 12:34:09',3);

INSERT INTO session(session_id, general_user, expiration, device_id)
VALUES (2,2,'2020-03-28 12:34:09',1);

INSERT INTO session(session_id, general_user, expiration, device_id)
VALUES (3,3,'2021-06-18 15:34:09',2);

#Inserting into stock_products
INSERT INTO stock_products(stock, products)
VALUES (1,1);

INSERT INTO stock_products(stock, products)
VALUES (2,2);

INSERT INTO stock_products(stock, products)
VALUES (3,3);

#Inserting into supplier_stock
INSERT INTO supplier_stock(supplier, stock, supplier_stock_id)
VALUES (1,2,1);

INSERT INTO supplier_stock(supplier, stock, supplier_stock_id)
VALUES (2,3,2);

INSERT INTO supplier_stock(supplier, stock, supplier_stock_id)
VALUES (3,1,3);

#Inserting into user_register_mail
INSERT INTO user_register_mail(user,mailing_list)
VALUES (1,1);

INSERT INTO user_register_mail(user,mailing_list)
VALUES (1,2);

INSERT INTO user_register_mail(user,mailing_list)
VALUES (3,1);

#Inserting into warehouse
INSERT INTO warehouse(warehouse_id, region, utilities)
VALUES (1,2,1);

INSERT INTO warehouse(warehouse_id, region, utilities)
VALUES (2,1,2);

INSERT INTO warehouse(warehouse_id, region, utilities)
VALUES (3,3,3);

#Inserting into warehouse_request
INSERT INTO warehouse_request(request_id, warehouse, supplier, stock)
VALUES (1,1,1,1);

INSERT INTO warehouse_request(request_id, warehouse, supplier, stock)
VALUES (2,2,2,2);

INSERT INTO warehouse_request(request_id, warehouse, supplier, stock)
VALUES (3,3,3,3);

#Inserting into rewardPoints 
INSERT INTO rewardPoints(rewardType, dollarAmount)
VALUES ('Spending over $100', 50);

INSERT INTO rewardPoints(rewardType, dollarAmount)
VALUES ('Spending over $200', 100);

INSERT INTO rewardPoints(rewardType, dollarAmount)
VALUES ('Buying three tech items at once', 100);

#Inserting into regUser_rewardPoints
INSERT INTO regUser_rewardPoints(user, rewardPoint)
VALUES (1,2); 

INSERT INTO regUser_rewardPoints(user, rewardPoint)
VALUES (2,1); 

INSERT INTO regUser_rewardPoints(user, rewardPoint)
VALUES (3,1); 

UPDATE stock SET description = "Tech Stock"
WHERE stock_id=1;
UPDATE stock SET description = "HouseRelated Stock"
WHERE stock_id=2;
UPDATE stock SET description = "Fashion Stock"
WHERE stock_id=3;

INSERT INTO orders (order_number, general_user, order_date, order_status, address_line1, address_line2, state, city, zip_code, phone, payment_method) 
VALUES (4, 1, '2020-08-18', 1, '1209 Great street Way', 'Ed Dr.', 'California', 'Chico', 93925, 123456789, 2541);
INSERT INTO order_details (order_details_id, products, orders, quantity_ordered, price_each)
VALUES (4,2,4,2,100); 
INSERT INTO payment_method (payment_id, billing_address, payment_type, billing_amount)
VALUES (1111, 'Billed to Company - Used Reward Points', 'rewardpoints', 100);
INSERT INTO orders (order_number, general_user, order_date, order_status, address_line1, address_line2, state, city, zip_code, phone, payment_method)
VALUES (5,1,"2020-09-18", 1, "1209 Great Street Way", "Ed Dr.", "California", "Chico", 93925, 123456789, 1111); 


UPDATE account 
SET account_type = 1
WHERE account_id = 3; 

DELETE FROM regUser_rewardPoints WHERE user = 1;
DELETE FROM regUser_rewardPoints WHERE user = 2;
DELETE FROM regUser_rewardPoints WHERE user = 3;

INSERT INTO regUser_rewardPoints (user, rewardPoint) 
VALUES (2,2); 















