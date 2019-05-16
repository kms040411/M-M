# host: 'localhost'
# port: 3306
# user: mnmuser
# password: mnmpass
# database: mnm

# sign up
# INSERT INTO User(uid, passwd) VALUES('id', 'pw');

# check id
# SELECT * FROM User WHERE uid = 'id';

# sign in
# SELECT * FROM User WHERE uid = 'id' AND passwd = 'pw';

# add movie (need to fix - insert same movie twice)
# INSERT INTO Movie(name, genre, director, actor, date) VALUES('name', 'genre', 'director', 'actor', '2018-01-01');

# add music (need to fix - insert same music twice)
# INSERT INTO Music(name, genre, artist, album, date) VALUES('name', 'genre', 'artist', 'album', '2018-01-01');

# search movie by genre
# SELECT * FROM Movie WHERE genre LIKE '%genre%';

# search movie by director
# SELECT * FROM Movie WHERE director LIKE '%director%';

# search music by genre
# SELECT * FROM Music WHERE genre LIKE '%genre%';

# search music by artist
# SELECT * FROM Music WHERE artist LIKE '%artist%';

# rate movie (need to fix - rate same movie by same user twice)
# INSERT INTO ORating(rating, user, movie) VALUES(5, 'id', 1); 

# rate music (need to fix - rate same music by same user twice)
# INSERT INTO URating(rating, user, music) VALUES(5, 'id', 1);

# recommend movie genre
# 

# recommend movie director
# 

# recommend music genre
# 

# recommend music artist
# 

CREATE DATABASE IF NOT EXISTS mnm;
USE mnm;

CREATE TABLE IF NOT EXISTS User (
	uid VARCHAR(32) NOT NULL,
	passwd VARCHAR(32) NOT NULL,
	PRIMARY KEY (uid)
);

CREATE TABLE IF NOT EXISTS Movie (
	tid bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	name VARCHAR(32) NOT NULL,
	genre VARCHAR(32) NOT NULL,
	director VARCHAR(32) NOT NULL,
    actor VARCHAR(32) NOT NULL,
    date DATE NOT NULL,
	PRIMARY KEY (tid)
);

CREATE TABLE IF NOT EXISTS Music (
	tid bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	name VARCHAR(32) NOT NULL,
	genre VARCHAR(32) NOT NULL,
	artist VARCHAR(32) NOT NULL,
	album VARCHAR(32) NOT NULL,
    date DATE NOT NULL,
	PRIMARY KEY (tid)
);

CREATE TABLE IF NOT EXISTS ORating (
	tid bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	rating int(32) unsigned NOT NULL,
	user VARCHAR(32) NOT NULL,
    movie bigint(20) unsigned NOT NULL,
	PRIMARY KEY (tid),
    FOREIGN KEY (user) REFERENCES User(uid),
    FOREIGN KEY (movie) REFERENCES Movie(tid)
);

CREATE TABLE IF NOT EXISTS URating (
	tid bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	rating int unsigned NOT NULL,
    user VARCHAR(32) NOT NULL,
    music bigint(20) unsigned NOT NULL,
	PRIMARY KEY (tid),
    FOREIGN KEY (user) REFERENCES User(uid),
    FOREIGN KEY (music) REFERENCES Music(tid)
);

CREATE USER IF NOT EXISTS 'mnmuser'@'localhost' IDENTIFIED BY 'mnmpass';
GRANT ALL PRIVILEGES ON mnm.* TO 'mnmuser'@'localhost';