CREATE DATABASE IF NOT EXISTS mnm;
USE mnm;

CREATE USER IF NOT EXISTS 'mnmuser'@'localhost' IDENTIFIED BY 'mnmpass';
GRANT ALL PRIVILEGES ON mnm.* TO 'mnmuser'@'localhost';
ALTER USER 'mnmuser'@'localhost' IDENTIFIED WITH mysql_native_password BY 'mnmpass';

DROP TABLE ORating CASCADE;
DROP TABLE URating CASCADE;
DROP TABLE User CASCADE;
DROP TABLE Movie CASCADE;
DROP TABLE Music CASCADE;

CREATE TABLE IF NOT EXISTS User (
	uid VARCHAR(32) NOT NULL,
	passwd VARCHAR(32) NOT NULL,
    name VARCHAR(32) NOT NULL,
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
	user VARCHAR(32) NOT NULL,
    movie bigint(20) unsigned NOT NULL,
	PRIMARY KEY (tid),
    FOREIGN KEY (user) REFERENCES User(uid),
    FOREIGN KEY (movie) REFERENCES Movie(tid)
);

CREATE TABLE IF NOT EXISTS URating (
	tid bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    user VARCHAR(32) NOT NULL,
    music bigint(20) unsigned NOT NULL,
	PRIMARY KEY (tid),
    FOREIGN KEY (user) REFERENCES User(uid),
    FOREIGN KEY (music) REFERENCES Music(tid)
);

#################################################################

INSERT INTO Movie(name, genre, director, actor, date) VALUES('Black Panther', 'action', 'Ryan Coogler', 'Chadwick Boseman',  '2018-02-16');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Avengers: Infinity War', 'action', 'Joe Russo', 'Robert Downey, Jr.',  '2018-04-27');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Jurassic World: Fallen Kingdom', 'action', 'J.A. Bayona', 'Chris Pratt',  '2018-06-22');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Deadpool 2', 'action', 'David Leitch', 'Ryan Reynolds',  '2018-05-18');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Mission: Impossible - Fallout', 'action', 'Christopher McQuarrie', 'Tom Cruise',  '2018-07-27');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Ant-Man and the Wasp', 'action', 'Peyton Reed', 'Paul Rudd',  '2018-07-06');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Solo: A Star Wars Story', 'action', 'Ron Howard', 'Alden Ehrenreich',  '2018-05-25');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Venom', 'action', 'Ruben Fleischer', 'Matthew Libatique',  '2018-10-05');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Ocean\'s 8', 'action', 'Gary Ross', 'Sandra Bullock',  '2018-06-08');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Ready Player One', 'action', 'Steven Spielberg', 'Tye Sheridan',  '2018-03-29');

INSERT INTO Movie(name, genre, director, actor, date) VALUES('The First Purge', 'thriller', 'Gerard McMurray', 'James DeMonaco',  '2018-07-04');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('A Simple Favor', 'thriller', 'Paul Feig', 'Anna Kendrick',  '2018-09-14');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('The Meg', 'thriller', 'Jon Turteltaub', 'Jason Statham',  '2018-08-10');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('The Equalizer 2', 'thriller', 'Antoine Fuqua', 'Denzel Washington',  '2018-07-20');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Alpha', 'thriller', 'Albert Hughes', 'Kodi Smit-McPhee',  '2018-08-17');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Red Sparrow', 'thriller', 'Francis Lawrence', 'Jennifer Lawrence',  '2018-03-02');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Breaking In', 'thriller', 'James McTeigue', 'Gabrielle Union',  '2018-05-11');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Tyler Perry\'s Acrimony', 'thriller', 'Tyler Perry', 'Taraji P. Henson',  '2018-03-30');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Peppermint', 'thriller', 'Pierre Morel', 'Jennifer Garner',  '2018-09-07');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Widows', 'thriller', 'Steve McQueen', 'Viola Davis',  '2018-11-16');

INSERT INTO Movie(name, genre, director, actor, date) VALUES('Suspiria', 'horror', 'Luca Guadagnino', 'Dakota Johnson',  '2018-10-26');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Bad Samaritan', 'horror', 'Dean Devlin', 'David Tennant',  '2018-05-04');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Strangers: Prey at Night', 'horror', 'Johannes Roberts', 'Christina Hendricks',  '2018-03-09');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Hereditary', 'horror', 'Ari Astor', 'Toni Collette',  '2018-06-08');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Insidious: The Last Key', 'horror', 'Adam Robitel', 'Leigh Whannell',  '2018-01-05');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Halloween', 'horror', 'David Gordon Green', 'Jamie Lee Curtis',  '2018-10-19');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('The Nun', 'horror', 'Corin Hardy', 'Demian Bichir',  '2018-09-07');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('A Quiet Place', 'horror', 'John Krasinski', 'Emily Blunt',  '2018-04-06');

INSERT INTO Movie(name, genre, director, actor, date) VALUES('Crazy Rich Asians', 'comedy', 'Jon Chu', 'Constance Wu',  '2018-08-15');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Night School', 'comedy', 'Malcolm D. Lee', 'Kevin Hart',  '2018-09-28');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Game Night', 'comedy', 'John Francis Daley', 'Rachel McAdams',  '2018-02-23');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Book Club', 'comedy', 'Bill Holderman', 'Jane Fonda',  '2018-05-18');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Blockers', 'comedy', 'Kay Cannon', 'Leslie Mann',  '2018-04-06');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Life of the Party', 'comedy', 'Ben Falcone', 'Melissa McCarthy',  '2018-05-11');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('I Feel Pretty', 'comedy', 'Abby Kohn', 'Amy Schumer',  '2018-04-20');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Instant Family', 'comedy', 'Sean Anders', 'Rose Byrne',  '2018-11-16');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Uncle Drew', 'comedy', 'Charles Stone III', 'Shaquille O\'Neal',  '2018-06-29');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Love, Simon', 'comedy', 'Greg Berlanti', 'Nick Robinson',  '2018-03-16');

INSERT INTO Movie(name, genre, director, actor, date) VALUES('Bohemian Rhapsody', 'drama', 'Bryan Singer', 'Rami Malek',  '2018-11-02');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('A Star is Born', 'drama', 'Bradley Cooper', 'Lady Gaga',  '2018-10-05');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('First Man', 'drama', 'Damien Chazelle', 'Ryan Gosling',  '2018-10-12');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('The 15:17 to Paris', 'drama', 'Clint Eastwood', 'Jenna Fischer',  '2018-02-09');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Adrift', 'drama', 'Baltasar Kormakur', 'Shailene Woodley',  '2018-06-01');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('The Hate U Give', 'drama', 'George Tillman, Jr.', 'Amandla Stenberg',  '2018-10-05');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('Green Book', 'drama', 'Peter Farrelly', 'Viggo Mortensen',  '2018-11-16');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('The Old Man & the Gun', 'drama', 'David Lowery', 'Robert Redfordn',  '2018-09-28');
INSERT INTO Movie(name, genre, director, actor, date) VALUES('The Miracle Season', 'drama', 'Sean McNamara', 'Helen Hunt',  '2018-04-06');


INSERT INTO Music(name, genre, artist, album, date) VALUES('42', 'pop/rock', 'Mumford & Sons', 'Delta', '2018-11-16');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Guiding Light', 'pop/rock', 'Mumford & Sons', 'Delta', '2018-11-16');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Woman', 'pop/rock', 'Mumford & Sons', 'Delta', '2018-11-16');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Beloved', 'pop/rock', 'Mumford & Sons', 'Delta', '2018-11-16');
INSERT INTO Music(name, genre, artist, album, date) VALUES('The Wild', 'pop/rock', 'Mumford & Sons', 'Delta', '2018-11-16');
INSERT INTO Music(name, genre, artist, album, date) VALUES('October Skies', 'pop/rock', 'Mumford & Sons', 'Delta', '2018-11-16');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Slip Away', 'pop/rock', 'Mumford & Sons', 'Delta', '2018-11-16');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Rose Of Sharon', 'pop/rock', 'Mumford & Sons', 'Delta', '2018-11-16');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Picture You', 'pop/rock', 'Mumford & Sons', 'Delta', '2018-11-16');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Darkness Visible', 'pop/rock', 'Mumford & Sons', 'Delta', '2018-11-16');

INSERT INTO Music(name, genre, artist, album, date) VALUES('When I Fall in Love', 'jazz', 'Michael Buble', 'Love', '2018-11-16');
INSERT INTO Music(name, genre, artist, album, date) VALUES('I Only Have Eyes for You', 'jazz', 'Michael Buble', 'Love', '2018-11-16');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Love You Anymore', 'jazz', 'Michael Buble', 'Love', '2018-11-16');
INSERT INTO Music(name, genre, artist, album, date) VALUES('La Vie en Rose', 'jazz', 'Michael Buble', 'Love', '2018-11-16');
INSERT INTO Music(name, genre, artist, album, date) VALUES('My Funny Valentine', 'jazz', 'Michael Buble', 'Love', '2018-11-16');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Such a Night', 'jazz', 'Michael Buble', 'Love', '2018-11-16');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Forever Now', 'jazz', 'Michael Buble', 'Love', '2018-11-16');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Where or When', 'jazz', 'Michael Buble', 'Love', '2018-11-16');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Unforgettable', 'jazz', 'Michael Buble', 'Love', '2018-11-16');
INSERT INTO Music(name, genre, artist, album, date) VALUES('When You\'re Smiling', 'jazz', 'Michael Buble', 'Love', '2018-11-16');

INSERT INTO Music(name, genre, artist, album, date) VALUES('Black Eyes', 'country', 'Bradley Cooper / Lady Gaga', 'A Star is Born', '2018-10-05');
INSERT INTO Music(name, genre, artist, album, date) VALUES('La Vie en Rose', 'country', 'Bradley Cooper / Lady Gaga', 'A Star is Born', '2018-10-05');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Maybe It\'s Time', 'country', 'Bradley Cooper / Lady Gaga', 'A Star is Born', '2018-10-05');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Out of Time', 'country', 'Bradley Cooper / Lady Gaga', 'A Star is Born', '2018-10-05');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Alibi', 'country', 'Bradley Cooper / Lady Gaga', 'A Star is Born', '2018-10-05');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Shallow', 'country', 'Bradley Cooper / Lady Gaga', 'A Star is Born', '2018-10-05');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Music to My Eyes', 'country', 'Bradley Cooper / Lady Gaga', 'A Star is Born', '2018-10-05');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Diggin\' My Grave', 'country', 'Bradley Cooper / Lady Gaga', 'A Star is Born', '2018-10-05');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Look What I Found', 'country', 'Bradley Cooper / Lady Gaga', 'A Star is Born', '2018-10-05');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Heal Me', 'country', 'Bradley Cooper / Lady Gaga', 'A Star is Born', '2018-10-05');

INSERT INTO Music(name, genre, artist, album, date) VALUES('Somebody to Love', 'pop/rock', 'Queen', 'Bohemian Rhapsody', '2018-10-19');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Killer Queen', 'pop/rock', 'Queen', 'Bohemian Rhapsody', '2018-10-19');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Bohemian Rhapsody', 'pop/rock', 'Queen', 'Bohemian Rhapsody', '2018-10-19');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Crazy Little Thing Called Love', 'pop/rock', 'Queen', 'Bohemian Rhapsody', '2018-10-19');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Another One Bites the Dust', 'pop/rock', 'Queen', 'Bohemian Rhapsody', '2018-10-19');
INSERT INTO Music(name, genre, artist, album, date) VALUES('I Want to Break Free', 'pop/rock', 'Queen', 'Bohemian Rhapsody', '2018-10-19');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Under Pressure', 'pop/rock', 'Queen', 'Bohemian Rhapsody', '2018-10-19');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Who Wants to Live Forever', 'pop/rock', 'Queen', 'Bohemian Rhapsody', '2018-10-19');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Don\'t Stop Me Now... Revisited', 'pop/rock', 'Queen', 'Bohemian Rhapsody', '2018-10-19');
INSERT INTO Music(name, genre, artist, album, date) VALUES('The Show Must Go on', 'pop/rock', 'Queen', 'Bohemian Rhapsody', '2018-10-19');

INSERT INTO Music(name, genre, artist, album, date) VALUES('On My Own', 'jazz', 'Madeleine Peyroux', 'Anthem', '2018-08-31');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Down on Me', 'jazz', 'Madeleine Peyroux', 'Anthem', '2018-08-31');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Party Tyme', 'jazz', 'Madeleine Peyroux', 'Anthem', '2018-08-31');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Anthem', 'jazz', 'Madeleine Peyroux', 'Anthem', '2018-08-31');
INSERT INTO Music(name, genre, artist, album, date) VALUES('All My Heroes', 'jazz', 'Madeleine Peyroux', 'Anthem', '2018-08-31');
INSERT INTO Music(name, genre, artist, album, date) VALUES('On a Sunday Afternoon', 'jazz', 'Madeleine Peyroux', 'Anthem', '2018-08-31');
INSERT INTO Music(name, genre, artist, album, date) VALUES('The Brand New Deal', 'jazz', 'Madeleine Peyroux', 'Anthem', '2018-08-31');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Lullaby', 'jazz', 'Madeleine Peyroux', 'Anthem', '2018-08-31');
INSERT INTO Music(name, genre, artist, album, date) VALUES('The Ghosts of Tomorrow', 'jazz', 'Madeleine Peyroux', 'Anthem', '2018-08-31');
INSERT INTO Music(name, genre, artist, album, date) VALUES('We Might as Well Dance', 'jazz', 'Madeleine Peyroux', 'Anthem', '2018-08-31');

INSERT INTO Music(name, genre, artist, album, date) VALUES('Baby Come Back to Me', 'country', 'Kane Brown', 'Experiment', '2018-11-09');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Good as You', 'country', 'Kane Brown', 'Experiment', '2018-11-09');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Lose It', 'country', 'Kane Brown', 'Experiment', '2018-11-09');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Short Skirt Weather', 'country', 'Kane Brown', 'Experiment', '2018-11-09');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Homesick', 'country', 'Kane Brown', 'Experiment', '2018-11-09');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Weekend', 'country', 'Kane Brown', 'Experiment', '2018-11-09');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Work', 'country', 'Kane Brown', 'Experiment', '2018-11-09');
INSERT INTO Music(name, genre, artist, album, date) VALUES('My Where I Come From', 'country', 'Kane Brown', 'Experiment', '2018-11-09');
INSERT INTO Music(name, genre, artist, album, date) VALUES('American Bad Dream', 'country', 'Kane Brown', 'Experiment', '2018-11-09');
INSERT INTO Music(name, genre, artist, album, date) VALUES('Live Forever', 'country', 'Kane Brown', 'Experiment', '2018-11-09');
