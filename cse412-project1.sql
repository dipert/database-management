CREATE TABLE Users(
yelping_since timestamp,
user_ID text,
name text,
PRIMARY KEY(user_ID)
);

CREATE TABLE TipInfo(
Tip_ID text,
tip_content text,
PRIMARY KEY(Tip_ID)
);

CREATE TABLE Category(
category_ID text,
Name text,
PRIMARY KEY (category_ID)
);

CREATE TABLE Business(
Business_ID text,
Title text,
PRIMARY KEY(Business_ID)
);

CREATE TABLE Photo(
Photo_ID text,
caption text,
PRIMARY KEY (Photo_ID)
);

CREATE TABLE Review(
rating numeric,
description text,
date timestamp,
FOREIGN KEY(user_ID) REFERENCES Users
FOREIGN KEY(Business_ID) REFERENCES Business
);

CREATE TABLE HasACategory(
FOREIGN KEY(Business_ID) REFERENCES Business,
FOREIGN KEY(category_ID) REFERENCES Category
);

CREATE TABLE hasAPhoto(
FOREIGN KEY(Photo_ID) REFERENCES Photo,
FOREIGN KEY(Business_ID) REFERENCES Business
);

CREATE TABLE TIP(
date timestamp,
FOREIGN KEY(user_ID) REFERENCES Users,
FOREIGN KEY(Tip_ID) REFERENCES TipInfo
);
