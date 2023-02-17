Create Database Users;

Create table users(
user_id int identity NOT NULL PRIMARY KEY,
first_name varchar(50) NOT NULL,
last_name varchar(50),
user_password varchar(50) NOT NULL,
rol_id int NOT NULL,
location_id int NOT NULL,
enable_profile char(1),
order_date varchar(50) NOT NULL,
rating tinyint 
);

Create table rol(
rol_id int identity NOT NULL PRIMARY KEY,
rol_name varchar(50) NOT NULL
);

Create table state(
state_id int identity NOT NULL PRIMARY KEY,
state_name varchar(50) NOT NULL,
);
Create table city(
city_id int identity NOT NULL PRIMARY KEY,
city_name varchar(50) NOT NULL,
state_id int NOT NULL
);

Create table user_location(
location_id int identity NOT NULL PRIMARY KEY,
city_id int NOT NULL,
state_id int NOT NULL
);


Create table contact(
contact_id int identity NOT NULL PRIMARY KEY,
user_id int NOT NULL,
address varchar(50) NOT NULL,
phone_number varchar(50) NOT NULL,
email varchar(50) NOT NULL
);

Create table lendingCompany(
lending_company_id int identity NOT NULL PRIMARY KEY,
user_id int NOT NULL,
order_date varchar(50) NOT NULL
);

Create table lender(
lender_id int identity NOT NULL PRIMARY KEY,
user_id int NOT NULL,
lending_company_id int NOT NULL
);

--RELACIONES ENTRE TABLAS

--Foraneas de usuarios
alter table users add constraint fk_rol_id foreign key  (rol_id) references  rol (rol_id); 
alter table users add constraint fk_location_id foreign key  (location_id) references  user_location (location_id); 

--Foraneas de Contacto
alter table contact add constraint fk_user_id foreign key  (user_id) references  users (user_id); 
create unique index user_id_idx on contact(user_id);

--Foraneas de Compañia prestamista
alter table lendingCompany add constraint fk_user_id_lc foreign key  (user_id) references  users (user_id); 
create unique index user_id_idx_lc on lendingCompany(user_id);


--Foraneas prestamista
alter table lender add constraint fk_user_id_l foreign key  (user_id) references  users (user_id);
create unique index user_id_idx_l on lender(user_id);
alter table lender add constraint fk_lendingCompany_id foreign key  (lending_company_id) references  lendingCompany (lending_company_id);

--Foraneas ubicacion
alter table user_location add constraint fk_city_id foreign key  (city_id) references  city (city_id); 
alter table user_location add constraint fk_state_id foreign key  (state_id) references  state (state_id); 
create unique index location_id_idx on user_location(city_id,state_id);

--Foraneas de ciudad
alter table city add constraint fk_state_id_st foreign key  (state_id) references  state (state_id); 