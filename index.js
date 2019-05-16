const express = require('express')
const session = require('express-session')
const app = express()
const bodyParser = require('body-parser')
const ejs = require('ejs')
const fs = require('fs')
var mysql = require('mysql')
var MySQLStore = require('express-mysql-session')(session)
var connection = mysql.createConnection({
	host : 'localhost',
	user : 'mnmuser',
	password : 'mnmpass',
	port : '3306',
	database : 'mnm'
})

//DB PART///////////////////////////////////////////////////////
connection.connect((err) => {
	if (err) throw err
	console.log("Connected")
})

////////////////////////////////////////////////////////////////

//ROUTE PART////////////////////////////////////////////////////
app.set('views', __dirname + '/views')
app.set('view engine', 'ejs')
app.engine('html', require('ejs').renderFile)
app.use(bodyParser.urlencoded({extended: true}))

app.get('/', (req, res) => {
	res.render("login.html")
})

app.get('/login.html', (req, res) => {
	res.render("login.html")
})

//LOGIN PART////////////////////////////////////////////////////
app.use(session({
	secret: 'qwerrewqqwer',
	resave: false,
	saveUninitialized: true
}))

const options = {
	host : 'localhost',
	user : 'mnmuser',
	password : 'mnmpass',
	port : '3306',
	database : 'mnm'
}

const sessionStore = new MySQLStore(options);

app.post('/login_attempt', (req, res) => {
	const id = req.body.id
	const pw = req.body.pw

	connection.query("SELECT passwd FROM user WHERE uid = '" + id + "'", (err, rows, fields) => {
		if (err) throw err
		if (rows.length != 0 && pw == rows[0].passwd){
			req.session.authId = id
			req.session.save(() => {
				res.redirect('/main.html')
			})
		} else {
			res.send('<script type="text/javascript">alert("Login Failed: Please check your id & password, again.");window.location.href = "login.html"; </script>')
		}
	})

})

app.post('/logout', (req, res) => {
	delete req.session.authId;
	req.session.save(() =>{
		res.redirect('/')
	})
})

////////////////////////////////////////////////////////////////

var main = fs.readFileSync('./views/main.ejs', 'utf8')
var mlist = fs.readFileSync('./views/musiclist.ejs', 'utf8')
app.get('/main.html', (req, res) => {
	if(req.session.authId){
		connection.query("SELECT tid, name, genre, date, artist, album FROM music", (err, rows, fields) => {
			connection.query("SELECT tid, name, genre, date, director, actor FROM movie", (err2, rows2, fileds2) => {
				if (err) throw err

				var arr = new Array();
				arr[0] = "number, name, genre, artist, album, date"
				for(var i=0; i<rows.length; i++){
					arr[i+1] = rows[i].tid + ") " + rows[i].name + ", " + rows[i].genre + ", " + rows[i].artist + ", " + rows[i].album + ", " + rows[i].date
				}
				
				var arr2 = new Array();
				arr2[0] = "number, name, genre, director, actor, date"
				for(var i=0; i<rows2.length; i++){
					arr2[i+1] = rows2[i].tid + ") " + rows2[i].name + ", " + rows2[i].genre + ", " + rows2[i].director + ", " + rows2[i].actor + ", " + rows2[i].date
				}

				var main2 = ejs.render(main, {
					mcontent: ejs.render(mlist, {
						data: arr
					}),
					moviecontent: ejs.render(mlist, {
						data: arr2
					})
				})

				res.writeHead(200, {'Content-Type': 'text/html'})
				res.write(main2)
				res.end()
			})
		})	
	} else
		res.send('<script type="text/javascript">alert("You need to login to use this page");window.location.href = "login.html"; </script>')
})

//SEARCH PART///////////////////////////////////////////////////

var searchpage = fs.readFileSync('./views/search.ejs', 'utf8')
app.post('/search', (req, res) => {
	if(req.session.authId)
		connection.query("SELECT tid, name, genre, date, artist, album FROM music", (err, rows, fields) => {
			connection.query("SELECT tid, name, genre, date, director, actor FROM movie", (err2, rows2, fileds2) => {
				if (err) throw err

				var arr = new Array();
				arr[0] = "number, name, genre, artist, album, date"
				for(var i=0; i<rows.length; i++){
					arr[i+1] = rows[i].tid + ") " + rows[i].name + ", " + rows[i].genre + ", " + rows[i].artist + ", " + rows[i].album + ", " + rows[i].date
				}
				
				var arr2 = new Array();
				arr2[0] = "number, name, genre, director, actor, date"
				for(var i=0; i<rows2.length; i++){
					arr2[i+1] = rows2[i].tid + ") " + rows2[i].name + ", " + rows2[i].genre + ", " + rows2[i].director + ", " + rows2[i].actor + ", " + rows2[i].date
				}

				var searchpage2 = ejs.render(searchpage, {
					mcontent: ejs.render(mlist, {
						data: arr
					}),
					moviecontent: ejs.render(mlist, {
						data: arr2
					})
				})

				res.writeHead(200, {'Content-Type': 'text/html'})
				res.write(searchpage2)
				res.end()
			})
		})
	else
		res.send('<script type="text/javascript">alert("You need to login to use this page");window.location.href = "login.html"; </script>')
})

var searchresult = fs.readFileSync('./views/searchresult.ejs', 'utf8')
app.post('/dosearch', (req, res) => {
	if(req.session.authId){
		var option1 = req.body.MoM
		var option2 = req.body.filter
		var filter = req.body.text
		if(option2 == "genre"){
			if(option1 == "music"){
				connection.query("SELECT tid, name, genre, date, artist, album FROM music WHERE genre = '" + filter + "'", (err, rows, fields) =>{
					var arr = new Array();
					arr[0] = "number, name, genre, artist, album, date"
					for(var i=0; i<rows.length; i++){
						arr[i+1] = rows[i].tid + ") " + rows[i].name + ", " + rows[i].genre + ", " + rows[i].artist + ", " + rows[i].album + ", " + rows[i].date
					}

					var searchresult2 = ejs.render(searchresult, {
						content: ejs.render(mlist, {
							data: arr
						})
					})
					res.writeHead(200, {'Content-Type': 'text/html'})
					res.write(searchresult2)
					res.end()
				})
			} else {
				connection.query("SELECT tid, name, genre, date, director, actor FROM movie WHERE genre = '" + filter + "'", (err, rows, fields) =>{
					var arr = new Array();
					arr[0] = "number, name, genre, director, actor, date"
					for(var i=0; i<rows.length; i++){
						arr[i+1] = rows[i].tid + ") " + rows[i].name + ", " + rows[i].genre + ", " + rows[i].director + ", " + rows[i].actor + ", " + rows[i].date
					}
					
					var searchresult2 = ejs.render(searchresult, {
						content: ejs.render(mlist, {
							data: arr
						})
					})
					res.writeHead(200, {'Content-Type': 'text/html'})
					res.write(searchresult2)
					res.end()
				})
			}
		} else if(option2 == "producer"){
			if(option1 == "music"){
				connection.query("SELECT tid, name, genre, date, artist, album FROM music WHERE artist = '" + filter + "'", (err, rows, fields) =>{
					var arr = new Array();
					arr[0] = "number, name, genre, artist, album, date"
					for(var i=0; i<rows.length; i++){
						arr[i+1] = rows[i].tid + ") " + rows[i].name + ", " + rows[i].genre + ", " + rows[i].artist + ", " + rows[i].album + ", " + rows[i].date
					}
					
					var searchresult2 = ejs.render(searchresult, {
						content: ejs.render(mlist, {
							data: arr
						})
					})
					res.writeHead(200, {'Content-Type': 'text/html'})
					res.write(searchresult2)
					res.end()
				})
			} else {
				connection.query("SELECT tid, name, genre, date, director, actor FROM movie WHERE director = '" + filter + "'", (err, rows, fields) =>{
					var arr = new Array();
					arr[0] = "number, name, genre, director, actor, date"
					for(var i=0; i<rows.length; i++){
						arr[i+1] = rows[i].tid + ") " + rows[i].name + ", " + rows[i].genre + ", " + rows[i].director + ", " + rows[i].actor + ", " + rows[i].date
					}
					
					var searchresult2 = ejs.render(searchresult, {
						content: ejs.render(mlist, {
							data: arr
						})
					})
					res.writeHead(200, {'Content-Type': 'text/html'})
					res.write(searchresult2)
					res.end()
				})
			}
		} else if(option2 == "name"){
			if(option1 == "music"){
				connection.query("SELECT tid, name, genre, date, artist, album FROM music WHERE name = '" + filter + "'", (err, rows, fields) =>{
					var arr = new Array();
					arr[0] = "number, name, genre, artist, album, date"
					for(var i=0; i<rows.length; i++){
						arr[i+1] = rows[i].tid + ") " + rows[i].name + ", " + rows[i].genre + ", " + rows[i].artist + ", " + rows[i].album + ", " + rows[i].date
					}
					
					var searchresult2 = ejs.render(searchresult, {
						content: ejs.render(mlist, {
							data: arr
						})
					})
					res.writeHead(200, {'Content-Type': 'text/html'})
					res.write(searchresult2)
					res.end()
				})
			} else {
				connection.query("SELECT tid, name, genre, date, director, actor FROM movie WHERE name = '" + filter + "'", (err, rows, fields) =>{
					var arr = new Array();
					arr[0] = "number, name, genre, director, actor, date"
					for(var i=0; i<rows.length; i++){
						arr[i+1] = rows[i].tid + ") " + rows[i].name + ", " + rows[i].genre + ", " + rows[i].director + ", " + rows[i].actor + ", " + rows[i].date
					}
					
					var searchresult2 = ejs.render(searchresult, {
						content: ejs.render(mlist, {
							data: arr
						})
					})
					res.writeHead(200, {'Content-Type': 'text/html'})
					res.write(searchresult2)
					res.end()
				})
			}
		}
	} else {
		res.send('<script type="text/javascript">alert("You need to login to use this page");window.location.href = "login.html"; </script>')
	}
})

////////////////////////////////////////////////////////////////

//MUSIC RECOMMENDATION PART/////////////////////////////////////

var recopage = fs.readFileSync('./views/recommend.ejs', 'utf8')
app.get('/recommend', (req, res) => {
	if(req.session.authId)
		connection.query("SELECT tid, name, genre, date, artist, album FROM music", (err, rows, fields) => {
			connection.query("SELECT music.tid, music.name FROM music WHERE music.tid IN (SELECT urating.music FROM urating WHERE user = '" + req.session.authId + "')", (err2, rows2, fields2) => {
				if (err) throw err
				if (err2) throw err2

				var arr = new Array();
				arr[0] = "number, name, genre, artist, album, date"
				for(var i=0; i<rows.length; i++){
					arr[i+1] = rows[i].tid + ") " + rows[i].name + ", " + rows[i].genre + ", " + rows[i].artist + ", " + rows[i].album + ", " + rows[i].date
				}

				var arr2 = new Array();
				arr2[0] = "number, name"
				for(var i=0; i<rows2.length; i++){
					arr2[i+1] = rows2[i].tid + ") " + rows2[i].name
				}

				var recopage2 = ejs.render(recopage, {
					fcontent: ejs.render(mlist, {
						data: arr2
					}),
					mcontent: ejs.render(mlist, {
						data: arr
					})
				})

				res.writeHead(200, {'Content-Type': 'text/html'})
				res.write(recopage2)
				res.end()
			})
		})
	else
		res.send('<script type="text/javascript">alert("You need to login to use this page");window.location.href = "login.html"; </script>')
})

app.post("/addrecommendmusic", (req, res) => {
	const name = req.body.name
	const user = req.session.authId
	if(req.session.authId){
		connection.query("SELECT tid FROM music WHERE name = '" + name + "'", (err, rows, fields) =>{
			if (rows.length != 0){
				var musictid = rows[0].tid
				connection.query("SELECT tid FROM urating WHERE music = '" + musictid + "' AND user = '" + user + "'", (err, rows, fields) =>{
					if(rows.length == 0)
						connection.query("INSERT INTO urating(music, user) VALUES('" + musictid + "', '" + user +"')", (err, rows, fields) => {
							if(err) throw err
							res.redirect('/recommend')
						})
					else
						res.send('<script type="text/javascript">alert("This music already exists in your list");window.location.href = "/recommend"; </script>')
				})	
			} else {
				res.send('<script type="text/javascript">alert("Cannot find music. Please check music name.");window.location.href = "/recommend"; </script>')
			}
		})
	} else {
		res.send('<script type="text/javascript">alert("You need to login to use this page");window.location.href = "login.html"; </script>')
	}
})

app.post("/delrecommendmusic", (req, res) => {
	const name = req.body.name
	const user = req.session.authId
	if(req.session.authId){
		connection.query("SELECT tid FROM music WHERE name = '" + name + "'", (err, rows, fields) =>{
			if (rows.length != 0){
				var musictid = rows[0].tid
				connection.query("SELECT tid FROM urating WHERE music = '" + musictid + "' AND user = '" + user + "'", (err, rows, fields) =>{
					if(rows.length != 0){
						connection.query("DELETE FROM urating WHERE music = '" + musictid + "' AND user = '" + user + "'", (err, rows, fields) =>{
							if(err) throw err
							res.redirect('/recommend')
						})
					} else {
						res.send('<script type="text/javascript">alert("This music does not exist in your list");window.location.href = "/recommend"; </script>')
					}
				})
			} else {
				res.send('<script type="text/javascript">alert("Cannot find music. Please check music name.");window.location.href = "/recommend"; </script>')
			}
		})
	} else {
		res.send('<script type="text/javascript">alert("You need to login to use this page");window.location.href = "login.html"; </script>')
	}
})

var rec_result = fs.readFileSync('./views/recommendresult.ejs', 'utf8')
app.post("/domusicrecommend", (req, res) => {
	if(req.session.authId){
		const user = req.session.authId
		connection.query("SELECT tid, name, genre, date, artist, album FROM music", (err, rows, fields) => {
			connection.query("SELECT tid, genre, artist, album FROM music WHERE music.tid IN (SELECT urating.music FROM urating WHERE urating.user = '" + user + "')", (err2, rows2, fields2) => {
				var fav_genre = new Array()
				var fav_artist = new Array()
				var fav_album = new Array()
				var fav_tid = new Array()
				if(rows2.length != 0){
					for (var i=0; i<rows2.legnth; i++){
						fav_genre[i] = rows2[i].genre
						fav_artist[i] = rows2[i].artist
						fav_album[i] = rows2[i].album
						fav_tid[i] = row2[i].tid
					}
					
					var score = new Array()
					for(var i=0; i<rows.length; i++){
						score[i] = [0, i]
						var current_genre = rows[i].genre
						var current_artist = rows[i].artist
						var current_album = rows[i].album
						var current_tid = rows[i].tid
						for (var j=0; j<rows2.length; j++){
							if (current_genre == rows2[j].genre) score[i][0]++
							if (current_artist == rows2[j].artist) score[i][0]++
							if (current_album == rows2[j].album) score[i][0]++
							if (current_tid == rows[j].tid) score[i][0] = 0;
						}
					}
					score.sort((a, b) => {
						return b[0] - a[0]
					})
					var recommended = score.slice(0, 5)

					var result = new Array();
					result[0] = "number, name, genre, artist, album, date"
					for(var i=0; i<recommended.length; i++){
						var rtid = recommended[i][1]
						result[i+1] = rows[rtid].tid + ") " + rows[rtid].name + ", " + rows[rtid].genre + ", " + rows[rtid].artist + ", " + rows[rtid].album + ", " + rows[rtid].date
					}

					var rec_result2 = ejs.render(rec_result, {
						content: ejs.render(mlist, {
							data: result
						})
					})

					res.writeHead(200, {'Content-Type': 'text/html'})
					res.write(rec_result2)
					res.end()
				} else {
					res.send('<script type="text/javascript">alert("You need to select your favorite musics to be recommended.");window.location.href = "/recommend"; </script>')
				}
			})
		})
	} else {
		res.send('<script type="text/javascript">alert("You need to login to use this page");window.location.href = "login.html"; </script>')
	}
})

app.post('/back', (req, res) => {
	res.redirect('/main.html')
})

var reco2page = fs.readFileSync('./views/recommend2.ejs', 'utf8')
app.get('/morecommend', (req, res) => {
	if(req.session.authId)
		connection.query("SELECT tid, name, genre, date, director, actor FROM movie", (err, rows, fields) => {
			connection.query("SELECT movie.tid, movie.name FROM movie WHERE movie.tid IN (SELECT orating.movie FROM orating WHERE user = '" + req.session.authId + "')", (err2, rows2, fields2) => {
				if (err) throw err
				if (err2) throw err2

				var arr = new Array();
				arr[0] = "number, name, genre, director, actor, date"
				for(var i=0; i<rows.length; i++){
					arr[i+1] = rows[i].tid + ") " + rows[i].name + ", " + rows[i].genre + ", " + rows[i].director + ", " + rows[i].actor + ", " + rows[i].date
				}

				var arr2 = new Array();
				arr2[0] = "number, name"
				for(var i=0; i<rows2.length; i++){
					arr2[i+1] = rows2[i].tid + ") " + rows2[i].name
				}

				var reco2page2 = ejs.render(reco2page, {
					fcontent: ejs.render(mlist, {
						data: arr2
					}),
					mcontent: ejs.render(mlist, {
						data: arr
					})
				})

				res.writeHead(200, {'Content-Type': 'text/html'})
				res.write(reco2page2)
				res.end()
			})
		})
	else
		res.send('<script type="text/javascript">alert("You need to login to use this page");window.location.href = "login.html"; </script>')
})

app.post("/addrecommendmovie", (req, res) => {
	const name = req.body.name
	const user = req.session.authId
	if(req.session.authId){
		connection.query("SELECT tid FROM movie WHERE name = '" + name + "'", (err, rows, fields) =>{
			if (rows.length != 0){
				var movietid = rows[0].tid
				connection.query("SELECT tid FROM orating WHERE movie = '" + movietid + "' AND user = '" + user + "'", (err, rows, fields) =>{
					if(rows.length == 0)
						connection.query("INSERT INTO orating(movie, user) VALUES('" + movietid + "', '" + user +"')", (err, rows, fields) => {
							if(err) throw err
							res.redirect('/morecommend')
						})
					else
						res.send('<script type="text/javascript">alert("This movie already exists in your list");window.location.href = "/morecommend"; </script>')
				})	
			} else {
				res.send('<script type="text/javascript">alert("Cannot find movie. Please check movie name.");window.location.href = "/morecommend"; </script>')
			}
		})
	} else {
		res.send('<script type="text/javascript">alert("You need to login to use this page");window.location.href = "login.html"; </script>')
	}
})

app.post("/delrecommendmovie", (req, res) => {
	const name = req.body.name
	const user = req.session.authId
	if(req.session.authId){
		connection.query("SELECT tid FROM movie WHERE name = '" + name + "'", (err, rows, fields) =>{
			if (rows.length != 0){
				var movietid = rows[0].tid
				connection.query("SELECT tid FROM orating WHERE movie = '" + movietid + "' AND user = '" + user + "'", (err, rows, fields) =>{
					if(rows.length != 0){
						connection.query("DELETE FROM orating WHERE movie = '" + movietid + "' AND user = '" + user + "'", (err, rows, fields) =>{
							if(err) throw err
							res.redirect('/morecommend')
						})
					} else {
						res.send('<script type="text/javascript">alert("This movie does not exist in your list");window.location.href = "/morecommend"; </script>')
					}
				})
			} else {
				res.send('<script type="text/javascript">alert("Cannot find movie. Please check movie name.");window.location.href = "/morecommend"; </script>')
			}
		})
	} else {
		res.send('<script type="text/javascript">alert("You need to login to use this page");window.location.href = "login.html"; </script>')
	}
})

app.post("/domovierecommend", (req, res) => {
	if(req.session.authId){
		const user = req.session.authId
		connection.query("SELECT tid, name, genre, date, director, actor FROM movie", (err, rows, fields) => {
			connection.query("SELECT tid, genre, director, actor FROM movie WHERE movie.tid IN (SELECT orating.movie FROM orating WHERE orating.user = '" + user + "')", (err2, rows2, fields2) => {
				var fav_genre = new Array()
				var fav_director = new Array()
				var fav_actor = new Array()
				var fav_tid = new Array()
				if(rows2.length != 0){
					for (var i=0; i<rows2.legnth; i++){
						fav_genre[i] = rows2[i].genre
						fav_director[i] = rows2[i].director
						fav_actor[i] = rows2[i].actor 
						fav_tid[i] = rows[i].tid
					}
					
					var score = new Array()
					for(var i=0; i<rows.length; i++){
						score[i] = [0, i]
						var current_genre = rows[i].genre
						var current_director = rows[i].director
						var current_actor = rows[i].actor
						var current_tid = rows[i].tid
						for (var j=0; j<rows2.length; j++){
							if (current_genre == rows2[j].genre) score[i][0]++
							if (current_director == rows2[j].director) score[i][0]++
							if (current_actor == rows2[j].actor) score[i][0]++
							if (current_tid == rows2[j].tid) score[i][0] = 0
						}

					}
					score.sort((a, b) => {
						return b[0] - a[0]
					})
					var recommended = score.slice(0, 5)

					var result = new Array();
					result[0] = "number, name, genre, director, actor, date"
					for(var i=0; i<recommended.length; i++){
						var rtid = recommended[i][1]
						result[i+1] = rows[rtid].tid + ") " + rows[rtid].name + ", " + rows[rtid].genre + ", " + rows[rtid].director + ", " + rows[rtid].actor + ", " + rows[rtid].date
					}

					var rec_result2 = ejs.render(rec_result, {
						content: ejs.render(mlist, {
							data: result
						})
					})

					res.writeHead(200, {'Content-Type': 'text/html'})
					res.write(rec_result2)
					res.end()
				} else {
					res.send('<script type="text/javascript">alert("You need to select your favorite movies to be recommended.");window.location.href = "/morecommend"; </script>')
				}
			})
		})
	} else {
		res.send('<script type="text/javascript">alert("You need to login to use this page");window.location.href = "login.html"; </script>')
	}
})

////////////////////////////////////////////////////////////////

//SIGNUP PART///////////////////////////////////////////////////

app.get('/signUp.html', (req, res) => {
	res.render("signUp.html")
})

app.post('/signUp_attempt', (req, res) => {
	const id = req.body.id
	const pw = req.body.pw
	const pwc = req.body.pwc
	const name = req.body.name
	if (id != "" && pw != "" && pwc != "" && name != "" && pw == pwc){
		console.log("id : " + id + "\npw : " + pw + "\nname : " + name + " signed up")
		connection.query("SELECT uid FROM user WHERE uid = '" + id + "'", (err, rows, fields) => {
			if(rows.length == 0){
				connection.query("INSERT INTO User(uid, passwd, name) VALUES('"+ id + "', '" + pw + "', '" + name + "')", (err, rows, fields) => {
					if(err) throw err
					res.send('<script type="text/javascript">alert("Signup Succeed");window.location.href = "login.html"; </script>')
				})
			} else {
				res.send('<script type="text/javascript">alert("Signup Failed: This idd is being used by someone. Try another id");window.location.href = "signUp.html"; </script>')
			}
		})	
	} else {
		if (id == "") res.send('<script type="text/javascript">alert("Signup Failed: Please check your ID, again.");window.location.href = "signUp.html"; </script>')
		else if (name == "") res.send('<script type="text/javascript">alert("Signup Failed: Please check your name, again.");window.location.href = "signUp.html"; </script>')
		else res.send('<script type="text/javascript">alert("Signup Failed: Please check your password, again.");window.location.href = "signUp.html"; </script>')
	}
})

///////////////////////////////////////////////////////////////////

const port8001 = app.listen(8001, () => {
	console.log('server is running at 8001')
})