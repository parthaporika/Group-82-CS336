#create database auction;
use auction;
#show tables;
#create table endUser(email varchar(30), isBuyer boolean, isSeller boolean, login varchar(25), primary key (login));
#create table staff(email varchar(30), slogin varchar(25), sales_report varchar(100), isAdmin boolean, primary key (email));
#had to change year to yearMade and name to item_name
#create table electronics(current_price = float, brand varchar(10), lower_bound varchar(15), color varchar(10), model varchar(20), yearMade varchar(4), initial_price float, item_name varchar(25), price_sold float, isSold boolean, auction_number int, processing varchar(30), lens varchar(20), memory_size varchar(25), megapixels varchar(15), decibels varchar(10), frequency varchar(10), isCamera boolean, isLaptop boolean, isSpeaker boolean, primary key (auction_number));
#create table bidHistory(buyer varchar(25), seller varchar(25), auction_number int, isBuyer boolean, bidamount float, primary key (buyer, seller, auction_number), foreign key (auction_number) references electronics(auction_number));
#create table bids(upper_limit float, login varchar(25), auction_number int, isAutomatic boolean, bidamount float, primary key (login, auction_number), foreign key (auction_number) references electronics(auction_number), foreign key (login) references endUser(login));
#for end_time we can probably use the time type
#create table posts(end_date date, end_time varchar(10), min_price varchar(5), login varchar(25), auction_number int, primary key (login, auction_number), foreign key (auction_number) references electronics(auction_number), foreign key (login) references endUser(login));
#a few things are mixed up in the original version
#create table supports(staff_email varchar(30), slogin varchar(25), email varchar(30), primary key (slogin, staff_email), foreign key (email) references endUser(login), foreign key (slogin) references staff(slogin));
#create table searches(login varchar(30), auction_number int, foreign key (auction_number) references electronics(auction_number), foreign key (login) references endUser(login));
#insert into staff
#values ("admin@gmail.com", "admin", null, True);
insert into endUser
values ("post@gmail.com", false, true, "kirbysmash");
insert into Staff
values ("custrep1@gmail.com", "cusrep1", null, False);
insert into Staff
values ("custrep2@gmail.com", "cusrep2", null, False);
insert into posts 
values ('2020-11-04', "11:30 PM", "1500", "kirbysmash", 456789);
insert into electronics
values (1500f, "Apple", "20000", "rose gold", "X", "2020", "20000", "MacBook Air", "", false, 456789, "5000 gbs", "", "7000 GB", "1080x1980", "20 dB", "25 Hz", false, true, false);

