DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE DATABASE ecommerce;

\c ecommerce;

CREATE TABLE "users" (
  "id" SERIAL PRIMARY KEY,
  "is_superuser" boolean,
  "is_active" boolean,
  "is_staff" boolean,
  "date_joined" timestamp,
  "date_delete" timestamp,
  "username" varchar,
  "password" varchar,
  "email" varchar,
  "firstname" varchar,
  "lastname" varchar,
  "address" varchar,
  "phone" varchar
);

CREATE TABLE "auth_group" (
  "id" SERIAL PRIMARY KEY,
  "name_group" varchar
);

CREATE TABLE "user_group" (
  "id" SERIAL PRIMARY KEY,
  "user_id" int,
  "group_id" int
);

CREATE TABLE "category" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "description" varchar,
  "created_at" timestamp default current_timestamp,
  "updated_at" timestamp,
  "deleted_at" timestamp
);

CREATE TABLE "tag" (
  "id" SERIAL PRIMARY KEY,
  "product_id" int,
  "name" varchar,
  "description" varchar,
  "created_at" timestamp default current_timestamp,
  "updated_at" timestamp,
  "deleted_at" timestamp
);

CREATE TABLE "product" (
  "id" SERIAL PRIMARY KEY,
  "user_id" int,
  "category_id" int,
  "name" varchar,
  "description" varchar,
  "code" varchar,
  "price" int,
  "discount" int,
  "image" varchar,
  "created_at" timestamp default current_timestamp,
  "updated_at" timestamp,
  "deleted_at" timestamp
);

CREATE TABLE "stock" (
  "id" SERIAL PRIMARY KEY,
  "product_id" int,
  "stock" int,
  "created_at" timestamp default current_timestamp,
  "updated_at" timestamp,
  "deleted_at" timestamp
);

CREATE TABLE "order_state" (
  "id" SERIAL PRIMARY KEY,
  "state" varchar
);

CREATE TABLE "orders" (
  "id" SERIAL PRIMARY KEY,
  "payment_method_id" int,
  "user_id" int,
  "order_state_id" int,
  "tracking_code" varchar,
  "address" varchar,
  "phone" varchar
);

CREATE TABLE "order_items" (
  "id" SERIAL PRIMARY KEY,
  "order_id" int,
  "product_id" int,
  "quantity" int,
  "created_at" timestamp default current_timestamp,
  "updated_at" timestamp,
  "deleted_at" timestamp
);

CREATE TABLE "payment_method" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "wallet" (
  "id" SERIAL PRIMARY KEY,
  "user_id" int,
  "payment_method_id" int,
  "created_at" timestamp default current_timestamp,
  "updated_at" timestamp,
  "deleted_at" timestamp
);


alter table user_group
   add constraint fk_user
   foreign key (user_id)
   references users(id);

alter table tag
   add constraint fk_product
   foreign key (product_id)
   references product(id);

alter table product
   add constraint fk_user
   foreign key (user_id)
   references users(id);

alter table product
   add constraint fk_category
   foreign key (category_id)
   references category(id);

alter table stock
   add constraint fk_product
   foreign key (product_id)
   references product(id);

alter table orders
   add constraint fk_payment_method
   foreign key (payment_method_id)
   references payment_method(id);

alter table orders
   add constraint fk_user
   foreign key (user_id)
   references users(id);

alter table orders
   add constraint fk_order_state
   foreign key (order_state_id)
   references order_state(id); 

alter table order_items
   add constraint fk_order
   foreign key (order_id)
   references orders(id); 

alter table order_items
   add constraint fk_product
   foreign key (product_id)
   references product(id); 
   
alter table wallet
   add constraint fk_user
   foreign key (user_id)
   references users(id); 

alter table wallet
   add constraint fk_payment_method
   foreign key (payment_method_id)
   references payment_method(id); 



INSERT INTO users(is_superuser,is_active,is_staff,date_joined,date_delete,username,email,firstname,lastname,address,phone) 
VALUES ('true','false','true','9/2/2022','11/4/2022','hkanter0','hkanter0@cdbaby.com','Haydon','Kanter','8 Wayridge Center','939-310-1963');
INSERT INTO users(is_superuser,is_active,is_staff,date_joined,date_delete,username,email,firstname,lastname,address,phone) 
VALUES ('true','false','false','3/18/2023','5/17/2022','sgluyas1','sgluyas1@google.es','Saloma','Gluyas','338 Pearson Terrace','741-120-0900');
INSERT INTO users(is_superuser,is_active,is_staff,date_joined,date_delete,username,email,firstname,lastname,address,phone) 
VALUES ('false','true','false','2/23/2023','10/31/2022','cdamrel2','cdamrel2@reddit.com','Cindra','Damrel','402 Bellgrove Avenue','344-359-3853');
INSERT INTO users(is_superuser,is_active,is_staff,date_joined,date_delete,username,email,firstname,lastname,address,phone) 
VALUES ('true','true','false','9/22/2022','9/2/2022','bmarian3','bmarian3@lulu.com','Brennen','Marian','519 Sommers Circle','391-295-6334');
INSERT INTO users(is_superuser,is_active,is_staff,date_joined,date_delete,username,email,firstname,lastname,address,phone) 
VALUES ('true','false','false','3/30/2023','1/28/2023','myaknov4','myaknov4@reference.com','Madlin','Yaknov','5 Pennsylvania Road','805-999-9453');
INSERT INTO users(is_superuser,is_active,is_staff,date_joined,date_delete,username,email,firstname,lastname,address,phone) 
VALUES ('false','true','true','2/2/2023','6/17/2022','umeasures5','umeasures5@virginia.edu','Urbanus','Measures','39301 Surrey Alley','237-577-0410');
INSERT INTO users(is_superuser,is_active,is_staff,date_joined,date_delete,username,email,firstname,lastname,address,phone) 
VALUES ('false','true','false','1/10/2023','5/11/2022','mwhitchurch6','mwhitchurch6@g.co','Murray','Whitchurch','99 East Point','407-591-4048');
INSERT INTO users(is_superuser,is_active,is_staff,date_joined,date_delete,username,email,firstname,lastname,address,phone) 
VALUES ('false','true','true','9/8/2022','6/9/2022','hthewys7','hthewys7@sbwire.com','Harriott','Thewys','8800 Thackeray Place','655-554-8473');
INSERT INTO users(is_superuser,is_active,is_staff,date_joined,date_delete,username,email,firstname,lastname,address,phone) 
VALUES ('true','true','false','4/24/2023','12/31/2022','trevance8','trevance8@discovery.com','Trace','Revance','3133 Troy Way','934-598-8923');
INSERT INTO users(is_superuser,is_active,is_staff,date_joined,date_delete,username,email,firstname,lastname,address,phone) 
VALUES ('false','true','false','8/2/2022','11/1/2022','gjansik9','gjansik9@noaa.gov','Greg','Jansik','0168 Lindbergh Plaza','192-421-1214');
INSERT INTO users(is_superuser,is_active,is_staff,date_joined,date_delete,username,email,firstname,lastname,address,phone) 
VALUES ('true','false','true','9/20/2022','6/3/2022','lnormavilla','lnormavilla@digg.com','Luci','Normavill','1 Brentwood Junction','358-980-3559');
INSERT INTO users(is_superuser,is_active,is_staff,date_joined,date_delete,username,email,firstname,lastname,address,phone) 
VALUES ('true','true','true','6/24/2022','8/17/2022','mgrandisonb','mgrandisonb@webnode.com','Mitch','Grandison','3613 Victoria Trail','126-589-7170');
INSERT INTO users(is_superuser,is_active,is_staff,date_joined,date_delete,username,email,firstname,lastname,address,phone) 
VALUES ('false','true','false','4/30/2023','11/10/2022','tcleatherowc','tcleatherowc@yandex.ru','Travus','Cleatherow','21 Holmberg Way','904-225-2440');


INSERT INTO category(name, description) VALUES ('Gaming', 'Gaming accessories');
INSERT INTO category(name, description) VALUES ('Video Games', 'Video Games');
INSERT INTO category(name, description) VALUES ('Baby', 'Baby toys and close');
INSERT INTO category(name, description) VALUES ('Toys', 'Toys and games');
INSERT INTO category(name, description) VALUES ('Electronics', 'Electronics and hardware');
INSERT INTO category(name, description) VALUES ('Kitchen', 'Kitchen');


INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (13,3,'Doors, Frames & Hardware','Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.','36800-020',6,1,'http://dummyimage.com/211x100.png/5fa2dd/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (4,1,'Masonry & Precast','Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.','76354-106',5,4,'http://dummyimage.com/210x100.png/5fa2dd/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (8,6,'Elevator','Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.','48433-347',3,1,'http://dummyimage.com/243x100.png/5fa2dd/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (5,2,'Site Furnishings','Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.','0904-5791',1,4,'http://dummyimage.com/102x100.png/cc0000/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (6,3,'RF Shielding','Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.','36987-2162',1,2,'http://dummyimage.com/126x100.png/dddddd/000000');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (3,3,'Rebar & Wire Mesh Install','Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti.','63722-001',6,2,'http://dummyimage.com/164x100.png/5fa2dd/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (6,3,'Drywall & Acoustical (MOB)','Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius.','41167-1602',6,4,'http://dummyimage.com/187x100.png/cc0000/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (4,2,'Curb & Gutter','Pellentesque ultrices mattis odio. Donec vitae nisi.','47682-114',6,1,'http://dummyimage.com/239x100.png/ff4444/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (6,5,'Sitework & Site Utilities','Maecenas rhoncus aliquam lacus.','68788-9919',5,5,'http://dummyimage.com/246x100.png/ff4444/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (13,3,'Ornamental Railings','Maecenas pulvinar lobortis est.','66116-352',6,5,'http://dummyimage.com/216x100.png/5fa2dd/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (5,2,'Masonry & Precast','Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.','17630-2008',4,4,'http://dummyimage.com/239x100.png/5fa2dd/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (10,2,'Fire Protection','Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.','66582-322',6,4,'http://dummyimage.com/248x100.png/dddddd/000000');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (9,6,'Curb & Gutter','Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.','37012-977',4,4,'http://dummyimage.com/115x100.png/cc0000/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (6,1,'Construction Clean and Final Clean','Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo.','63645-161',1,5,'http://dummyimage.com/130x100.png/5fa2dd/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (10,2,'Glass & Glazing','Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.','66129-110',1,1,'http://dummyimage.com/190x100.png/5fa2dd/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (6,6,'Roofing (Metal)','Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo.','57337-016',1,3,'http://dummyimage.com/146x100.png/5fa2dd/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (3,1,'Asphalt Paving','Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.','49738-536',4,2,'http://dummyimage.com/188x100.png/dddddd/000000');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (5,1,'RF Shielding','Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.','50436-6523',6,6,'http://dummyimage.com/197x100.png/5fa2dd/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (4,6,'Landscaping & Irrigation','Quisque id justo sit amet sapien dignissim vestibulum.','54569-3259',5,3,'http://dummyimage.com/221x100.png/cc0000/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (6,2,'Electrical','Proin at turpis a pede posuere nonummy.','49884-836',4,2,'http://dummyimage.com/231x100.png/5fa2dd/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (13,2,'Retaining Wall and Brick Pavers','Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui.','42254-250',1,5,'http://dummyimage.com/210x100.png/5fa2dd/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (9,5,'Glass & Glazing','Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.','0054-0235',6,4,'http://dummyimage.com/140x100.png/cc0000/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (3,6,'Overhead Doors','In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.','50153-110',5,1,'http://dummyimage.com/120x100.png/dddddd/000000');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (11,3,'RF Shielding','Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.','43269-632',6,2,'http://dummyimage.com/148x100.png/5fa2dd/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (8,6,'Framing (Wood)','In congue. Etiam justo.','49288-0222',1,4,'http://dummyimage.com/227x100.png/dddddd/000000');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (4,2,'Doors, Frames & Hardware','Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.','52268-100',2,5,'http://dummyimage.com/179x100.png/cc0000/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (7,1,'EIFS','In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.','50458-554',2,6,'http://dummyimage.com/103x100.png/cc0000/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (6,5,'Hard Tile & Stone','Sed accumsan felis.','50021-242',6,5,'http://dummyimage.com/247x100.png/dddddd/000000');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (1,4,'Drilled Shafts','Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.','16590-254',3,2,'http://dummyimage.com/195x100.png/ff4444/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (13,2,'Wall Protection','Etiam vel augue. Vestibulum rutrum rutrum neque.','36987-1634',3,1,'http://dummyimage.com/118x100.png/dddddd/000000');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (12,3,'Prefabricated Aluminum Metal Canopies','Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.','54973-0614',1,4,'http://dummyimage.com/114x100.png/cc0000/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (4,1,'Soft Flooring and Base','Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.','58466-016',6,2,'http://dummyimage.com/113x100.png/dddddd/000000');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (7,6,'Rebar & Wire Mesh Install','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum.','37000-322',5,1,'http://dummyimage.com/110x100.png/dddddd/000000');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (6,2,'Electrical and Fire Alarm','Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.','61715-104',2,6,'http://dummyimage.com/101x100.png/ff4444/ffffff');
INSERT INTO product(user_id,category_id,name,description,code,price,discount,image) VALUES (2,1,'Roofing (Asphalt)','Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.','36987-1380',5,6,'http://dummyimage.com/170x100.png/cc0000/ffffff');


INSERT INTO tag(product_id,name,description) VALUES (17,'Job','Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.');
INSERT INTO tag(product_id,name,description) VALUES (26,'Zontrax','Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.');
INSERT INTO tag(product_id,name,description) VALUES (33,'Vagram','In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.');
INSERT INTO tag(product_id,name,description) VALUES (16,'Flexidy','Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.');
INSERT INTO tag(product_id,name,description) VALUES (14,'Gembucket','Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.');
INSERT INTO tag(product_id,name,description) VALUES (14,'Fintone','Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.');
INSERT INTO tag(product_id,name,description) VALUES (14,'Gembucket','Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.');
INSERT INTO tag(product_id,name,description) VALUES (19,'Trippledex','Nullam varius.');
INSERT INTO tag(product_id,name,description) VALUES (25,'Temp','Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.');
INSERT INTO tag(product_id,name,description) VALUES (20,'Sonsing','Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo.');
INSERT INTO tag(product_id,name,description) VALUES (35,'Fix San','Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros.');
INSERT INTO tag(product_id,name,description) VALUES (27,'Tin','In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.');
INSERT INTO tag(product_id,name,description) VALUES (11,'Treeflex','Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.');
INSERT INTO tag(product_id,name,description) VALUES (34,'Namfix','Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
INSERT INTO tag(product_id,name,description) VALUES (13,'Voyatouch','Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
INSERT INTO tag(product_id,name,description) VALUES (15,'Overhold','Sed accumsan felis. Ut at dolor quis odio consequat varius.');
INSERT INTO tag(product_id,name,description) VALUES (8,'Sonair','Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.');
INSERT INTO tag(product_id,name,description) VALUES (27,'Tampflex','Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.');
INSERT INTO tag(product_id,name,description) VALUES (27,'Konklux','Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.');
INSERT INTO tag(product_id,name,description) VALUES (25,'Otcom','Morbi non quam nec dui luctus rutrum. Nulla tellus.');
INSERT INTO tag(product_id,name,description) VALUES (20,'Andalax','Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet.');
INSERT INTO tag(product_id,name,description) VALUES (26,'Hatity','Duis ac nibh.');
INSERT INTO tag(product_id,name,description) VALUES (27,'Sub-Ex','Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim.');
INSERT INTO tag(product_id,name,description) VALUES (23,'Flowdesk','Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui.');
INSERT INTO tag(product_id,name,description) VALUES (15,'Daltfresh','Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim.');
INSERT INTO tag(product_id,name,description) VALUES (16,'Holdlamis','Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.');
INSERT INTO tag(product_id,name,description) VALUES (9,'Fintone','Nullam molestie nibh in lectus. Pellentesque at nulla.');

INSERT INTO stock(product_id,stock) VALUES (1,65);
INSERT INTO stock(product_id,stock) VALUES (2,87);
INSERT INTO stock(product_id,stock) VALUES (3,248);
INSERT INTO stock(product_id,stock) VALUES (4,141);
INSERT INTO stock(product_id,stock) VALUES (5,246);
INSERT INTO stock(product_id,stock) VALUES (6,241);
INSERT INTO stock(product_id,stock) VALUES (7,275);
INSERT INTO stock(product_id,stock) VALUES (8,277);
INSERT INTO stock(product_id,stock) VALUES (9,72);
INSERT INTO stock(product_id,stock) VALUES (10,155);
INSERT INTO stock(product_id,stock) VALUES (11,237);
INSERT INTO stock(product_id,stock) VALUES (12,69);
INSERT INTO stock(product_id,stock) VALUES (13,167);
INSERT INTO stock(product_id,stock) VALUES (14,280);
INSERT INTO stock(product_id,stock) VALUES (15,286);
INSERT INTO stock(product_id,stock) VALUES (16,185);
INSERT INTO stock(product_id,stock) VALUES (17,74);
INSERT INTO stock(product_id,stock) VALUES (18,130);
INSERT INTO stock(product_id,stock) VALUES (19,44);
INSERT INTO stock(product_id,stock) VALUES (20,89);
INSERT INTO stock(product_id,stock) VALUES (21,241);
INSERT INTO stock(product_id,stock) VALUES (22,263);
INSERT INTO stock(product_id,stock) VALUES (23,159);
INSERT INTO stock(product_id,stock) VALUES (24,266);
INSERT INTO stock(product_id,stock) VALUES (25,258);
INSERT INTO stock(product_id,stock) VALUES (26,91);
INSERT INTO stock(product_id,stock) VALUES (27,193);
INSERT INTO stock(product_id,stock) VALUES (28,186);
INSERT INTO stock(product_id,stock) VALUES (29,59);
INSERT INTO stock(product_id,stock) VALUES (30,248);
INSERT INTO stock(product_id,stock) VALUES (31,272);
INSERT INTO stock(product_id,stock) VALUES (32,298);
INSERT INTO stock(product_id,stock) VALUES (33,189);
INSERT INTO stock(product_id,stock) VALUES (34,114);
INSERT INTO stock(product_id,stock) VALUES (35,245);


INSERT INTO order_state(state) VALUES ('new');
INSERT INTO order_state(state) VALUES ('pending');
INSERT INTO order_state(state) VALUES ('cancelled');
INSERT INTO order_state(state) VALUES ('delivered');
INSERT INTO order_state(state) VALUES ('staged');


INSERT INTO payment_method(name) VALUES ('cash');
INSERT INTO payment_method(name) VALUES ('credit card');
INSERT INTO payment_method(name) VALUES ('debit card');


INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,13,1,'49404-109','596 Elgar Junction','688-971-6663');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,3,1,'63029-401','26244 Claremont Junction','544-686-4335');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,13,4,'36987-1756','4616 Shelley Center','822-782-4018');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,9,3,'67345-0785','88 Fairfield Alley','684-155-9418');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,8,2,'76472-1134','16156 Erie Parkway','931-696-8725');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,9,4,'67938-2023','63 Declaration Alley','486-758-8905');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,4,4,'66184-151','66219 Dryden Alley','472-256-6897');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,12,5,'37000-412','1 Butternut Way','472-562-4967');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,13,1,'0615-7831','478 Monica Junction','390-385-1422');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,9,2,'67767-133','71059 Cody Drive','713-782-7497');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,12,4,'13537-531','2 Mandrake Place','812-676-5874');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,12,2,'13537-404','22981 Di Loreto Point','254-765-6915');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,8,3,'54868-5268','71988 Carpenter Court','970-469-1461');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,12,4,'68258-6056','0531 Debs Crossing','357-484-0527');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,8,2,'68999-984','23 Mariners Cove Road','935-923-9742');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,12,4,'49738-746','858 Bayside Circle','273-653-3469');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,9,4,'17089-259','67288 Fulton Alley','391-918-2785');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,13,3,'43598-221','372 Shoshone Pass','499-197-7704');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,11,1,'36987-3437','624 Orin Place','461-653-5458');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,6,3,'42002-200','5 Bluestem Circle','278-406-4886');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,12,3,'49967-090','8 Gale Park','247-439-0098');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,2,5,'60681-2106','820 Sutherland Crossing','460-637-5401');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,6,5,'53808-0354','626 Mosinee Street','260-389-2420');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,11,5,'49035-452','03853 Marquette Plaza','174-409-0507');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,7,4,'60793-411','046 American Avenue','506-654-1235');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,9,4,'35356-428','363 Eagan Lane','678-709-3946');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,1,2,'0406-8725','085 Mccormick Lane','675-812-5629');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,2,5,'67767-201','2 Doe Crossing Pass','345-510-4851');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,12,3,'0071-2012','2341 Stone Corner Circle','541-523-4480');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,6,2,'62191-004','69 Hovde Terrace','792-438-5120');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,11,5,'55910-371','07 Kenwood Lane','333-672-3854');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,13,3,'56104-006','1349 Dawn Center','337-481-0487');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,1,1,'37000-260','2 Mallard Parkway','681-449-7035');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,12,1,'68645-151','431 Anderson Park','313-827-7795');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,11,5,'55289-402','6 Marquette Drive','216-904-7539');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,11,3,'63629-1447','0798 Pleasure Point','317-512-8740');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,2,2,'36987-2619','4005 Emmet Point','603-866-9607');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,13,5,'50436-0098','9965 Grasskamp Parkway','267-475-0203');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,4,4,'17630-2038','76 Hoard Terrace','249-504-1664');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,8,2,'41520-950','2 Kingsford Hill','477-443-0561');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,8,3,'24208-313','9252 Pearson Park','689-413-0017');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,6,4,'55154-3914','993 Delaware Lane','157-517-0077');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,8,3,'0093-5510','789 Reinke Drive','824-421-2919');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,6,1,'27281-002','638 Fair Oaks Lane','776-860-2776');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,1,2,'63629-1242','7 Arizona Circle','228-807-6699');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,12,2,'62742-4046','1265 Pierstorff Way','406-402-2237');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,4,2,'0615-7676','10113 Jay Way','345-547-0590');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,8,3,'68788-9794','88 Hollow Ridge Trail','512-299-7095');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,13,1,'59115-055','9329 Vahlen Parkway','281-649-7703');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,7,2,'0591-5619','354 Stone Corner Plaza','864-562-7257');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,3,1,'10893-083','04 Ridgeview Street','430-334-4478');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,10,1,'50593-008','29 Forest Junction','441-669-4466');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,10,4,'54866-000','61 Packers Court','984-189-5076');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,11,3,'42002-516','8433 Browning Point','912-983-7693');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,10,1,'53135-925','0 Forest Run Crossing','481-948-5619');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,5,5,'54868-5144','46057 Main Parkway','214-846-1162');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,8,3,'48951-9009','54502 Grasskamp Circle','764-831-2969');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,12,5,'0517-4050','7 Upham Junction','546-108-1550');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,13,2,'55253-801','556 Vermont Hill','100-173-4442');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,4,3,'50332-0132','49218 Charing Cross Avenue','602-845-8452');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,11,2,'0054-0108','31223 Declaration Drive','931-420-9038');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,5,4,'37000-272','36 Merchant Pass','147-683-3958');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,9,4,'53645-1031','95991 Fuller Way','480-842-5791');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,3,3,'49643-358','505 Surrey Center','924-951-4919');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,7,1,'60429-066','299 Havey Crossing','876-601-8769');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,13,3,'55926-0025','95678 Grim Circle','674-631-7501');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,10,4,'0268-1339','90 Northridge Court','520-932-2697');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,6,1,'0615-7740','1 Eastwood Crossing','497-241-0475');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,2,1,'62750-025','48 Elgar Avenue','668-856-6084');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,1,4,'62932-144','7649 Sunbrook Alley','489-217-7088');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,13,1,'54569-0909','18 Portage Road','586-440-3599');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,11,3,'63940-803','6 Loftsgordon Court','530-708-1876');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,8,3,'41250-431','82 Dexter Way','998-478-0615');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,8,5,'55111-172','1791 New Castle Park','795-211-4063');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,4,4,'60429-932','0 Kropf Drive','235-212-2892');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,12,3,'66993-663','0403 Northview Trail','415-774-0701');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,8,4,'67938-0830','168 Sloan Crossing','415-347-1562');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,2,3,'41520-897','81512 West Point','172-162-1364');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,6,1,'59762-0542','1471 Old Shore Alley','484-646-1163');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,9,5,'49715-003','42 Melvin Parkway','266-711-0410');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,12,3,'0172-4280','75 Atwood Drive','932-623-7892');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,2,3,'54868-5240','364 Muir Lane','168-967-4771');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,4,5,'49035-043','1 Thompson Way','298-619-3778');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,12,2,'51660-490','786 Oneill Hill','775-867-2523');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,13,4,'0832-1121','8899 Delaware Plaza','875-276-3856');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,9,5,'50544-301','908 Thompson Parkway','370-759-1697');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,4,5,'68788-9916','269 Arizona Drive','804-992-2311');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (3,5,2,'0395-0431','52805 Granby Park','829-382-3466');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (1,2,1,'16729-023','410 Ramsey Point','215-573-9985');
INSERT INTO orders(payment_method_id,user_id,order_state_id,tracking_code,address,phone) VALUES (2,10,5,'56104-024','2 Loftsgordon Hill','881-331-8954');


INSERT INTO order_items(order_id,product_id,quantity) VALUES (15,16,13);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (79,27,2);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (29,9,20);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (22,32,2);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (43,25,3);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (87,6,5);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (50,27,4);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (4,6,5);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (42,19,7);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (24,28,14);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (49,26,5);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (3,10,20);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (25,2,8);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (81,15,1);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (16,34,4);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (23,23,6);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (9,28,10);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (60,4,18);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (81,11,10);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (54,8,2);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (41,21,19);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (30,16,13);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (63,3,3);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (10,14,11);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (13,32,1);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (17,13,11);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (6,27,1);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (76,28,1);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (40,19,2);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (14,18,20);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (56,25,20);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (64,24,20);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (83,30,15);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (33,20,7);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (5,7,4);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (67,35,11);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (66,15,10);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (39,34,8);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (61,18,16);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (38,4,6);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (52,12,9);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (56,28,5);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (75,32,13);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (62,23,11);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (12,12,3);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (79,33,17);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (58,2,9);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (70,7,18);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (90,34,17);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (14,14,13);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (40,18,6);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (19,28,19);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (33,13,12);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (32,15,20);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (19,6,14);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (18,35,2);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (67,23,6);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (3,13,12);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (32,21,4);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (18,1,2);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (22,12,11);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (25,23,8);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (58,12,19);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (60,29,14);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (50,6,14);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (3,30,9);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (39,33,11);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (7,20,15);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (53,31,5);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (67,31,2);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (77,8,9);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (10,23,4);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (25,22,18);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (35,12,14);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (67,29,15);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (71,4,4);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (31,33,15);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (49,5,9);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (1,18,4);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (46,10,15);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (23,20,4);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (16,3,16);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (58,4,17);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (50,16,3);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (12,34,4);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (86,22,2);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (71,19,11);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (77,21,11);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (2,14,5);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (45,18,6);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (1,5,14);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (78,17,8);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (90,20,8);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (57,10,11);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (2,16,14);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (26,9,20);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (47,32,20);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (7,2,12);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (56,1,18);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (45,2,19);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (9,11,17);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (64,22,6);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (34,23,19);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (36,12,10);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (33,26,15);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (73,33,19);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (72,32,18);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (81,23,3);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (48,19,8);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (7,21,19);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (19,22,5);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (4,16,14);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (17,30,5);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (50,31,14);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (55,29,18);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (26,34,16);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (75,23,19);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (51,17,11);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (43,7,19);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (19,20,10);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (56,14,5);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (74,3,3);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (14,8,5);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (32,9,15);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (10,18,13);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (44,33,3);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (48,32,3);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (62,26,15);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (35,32,19);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (72,9,3);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (71,27,5);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (15,21,11);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (37,5,14);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (68,5,20);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (41,6,11);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (12,7,12);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (21,26,1);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (76,15,16);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (87,29,1);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (70,27,15);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (23,23,13);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (45,33,8);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (55,18,15);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (26,1,13);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (16,35,19);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (85,27,5);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (30,32,16);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (25,10,18);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (74,11,16);
INSERT INTO order_items(order_id,product_id,quantity) VALUES (16,26,6);

INSERT INTO wallet(user_id,payment_method_id) VALUES (1,3);
INSERT INTO wallet(user_id,payment_method_id) VALUES (2,2);
INSERT INTO wallet(user_id,payment_method_id) VALUES (3,2);
INSERT INTO wallet(user_id,payment_method_id) VALUES (4,3);
INSERT INTO wallet(user_id,payment_method_id) VALUES (5,2);
INSERT INTO wallet(user_id,payment_method_id) VALUES (6,3);
INSERT INTO wallet(user_id,payment_method_id) VALUES (7,3);
INSERT INTO wallet(user_id,payment_method_id) VALUES (8,2);
INSERT INTO wallet(user_id,payment_method_id) VALUES (9,3);
INSERT INTO wallet(user_id,payment_method_id) VALUES (10,1);
INSERT INTO wallet(user_id,payment_method_id) VALUES (11,3);
INSERT INTO wallet(user_id,payment_method_id) VALUES (12,1);
INSERT INTO wallet(user_id,payment_method_id) VALUES (13,3);

