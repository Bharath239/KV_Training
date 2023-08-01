create table "user_details"(
"created_at" TIMESTAMP not null default now(),
"updated_at" TIMESTAMP not null default now(),
"deleted_at" TIMESTAMP,
"userid" uuid not null primary key default  uuid_generate_v4(),
"name" char varying not null,
"address" char varying not null,
"phone_number" char varying not null,
"email" char varying not null,
"password" char varying not null
);

create table "product_details"(
"created_at" TIMESTAMP not null default now(),
"updated_at" TIMESTAMP not null default now(),
"deleted_at" TIMESTAMP,
"productid" uuid not null primary key default  uuid_generate_v4(),
"name" char varying not null,
"description" char varying not null,
"price" float not null,
"sku" int not null
);

create table "order_details"(
"created_at" TIMESTAMP not null default now(),
"updated_at" TIMESTAMP not null default now(),
"deleted_at" TIMESTAMP,
"order_id" uuid not null primary key default  uuid_generate_v4(),
"ordered_user_id" uuid not null,
"order_address" char varying not null,	
"total_price" float not null
);

insert into "user_details"
(name,address,phone_number,email,password)
values
('John','House1','9876','John@gmail.com','johnpass'),
('Jack','House2','5432','Jack@gmail.com','jackpass'),
('Job','House3','6578','Job@gmail.com','jobpass');

insert into "product_details" 
(name,description,price,sku)
values
('Laptop','PC','50000','123'),
('Shirt','Cotton','1200','456'),
('Mobile','Smart','35000','678'),
('Skirt','Dress','3000','342'),
('Watch','Rado','5000','12');

insert into "order_details"
(ordered_user_id,order_address,total_price)
values
('e3e70287-1235-4d1a-a0aa-bf885e5e647d','House3',50000),
('284b95eb-25b2-41ea-8332-c06106b552e7','House1',45000),
('e3e70287-1235-4d1a-a0aa-bf885e5e647d','House2',3000),
('74f38bc3-9db1-46a5-a4c6-2623bc1c6ee0','House4',450),
('74f38bc3-9db1-46a5-a4c6-2623bc1c6ee0','House3',30000);

create table "order-product"(
"order_id" uuid not null,
"product_id" uuid not null,
"quantity" int not null,
"price" float not null
);

insert into "order-product" 
(order_id,product_id,quantity,price)
values
('d716a04c-fd74-4a06-a7af-e440c6b7e3d9','012cb33d-341a-4fad-b8e1-3f1942bba4c5',1,45000),
('d716a04c-fd74-4a06-a7af-e440c6b7e3d9','b6e934b1-8384-4a02-8eb3-d72d5e65b30a',5,1000),
('71c57ec8-e30c-42d1-9ae9-6b3d6dadf48e','012cb33d-341a-4fad-b8e1-3f1942bba4c5',1,45000),
('6c53f014-b462-49c2-a6b4-1f57454f299a','c605e9ff-4d24-499c-8b8a-877be95a4b3e',1,3000),
('2483ceb0-36e0-4bb6-a814-9ccb61f4e6a0','172f0ea2-fd66-43e9-b011-b8584f71d974',10,45),
('5379d447-ce03-4be7-a83e-10133b382fd6','f1f1f704-de82-47bb-b6fe-ffbe26367a3a',1,30000);

create table categories(
"created_at" TIMESTAMP not null default now(),
"updated_at" TIMESTAMP not null default now(),
"deleted_at" TIMESTAMP,
"id" uuid primary key not null default uuid_generate_v4(),
"name" char varying not null
);

/*insert into categories
(name)
select distinct 
	"product_category" as "name"
from product_details ;*/

insert into categories 
(name)
values
('Electronics'),
('Clothing'),
('Wearable');

create table "product-categories"(
"productid" uuid,
"categoryid" uuid
);

insert into "product-categories"
(productid,categoryid)
values
((select productid from product_details where name='Laptop'),(select id from categories where name='Electronics')),
((select productid from product_details where name='Mobile'),(select id from categories where name='Electronics')),
((select productid from product_details where name='Shirt'),(select id from categories where name='Clothing')),
((select productid from product_details where name='Skirt'),(select id from categories where name='Clothing')),
((select productid from product_details where name='Watch'),(select id from categories where name='Wearable')),
((select productid from product_details where name='Watch'),(select id from categories where name='Electronics'));


/*if a product belongs to only one category ,ie, one to many
alter table product_details add "category_id" uuid;
  
update product_details pd set category_id=(select id from product_categories pc where pc."name"=pd.product_category);

alter table product_details drop column product_category;
*/

create index product_name on product_details ("name");
create index category_name on categories ("name");





