import os, sys
import json
import config
from db import db, User, Playlist
db_filename = "todo.db"
import base64
import os
from flask import Flask, request, redirect, jsonify, current_app as app, render_template, request
import requests
from urllib.parse import urlencode
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.sql import select
from flask import Flask, current_app as app, render_template, request, redirect, session, make_response
from spotify.search import query, get_track_url
app = Flask(__name__)

import spotipy
import sys
from spotipy.oauth2 import SpotifyClientCredentials

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///%s' % db_filename
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = True

db.init_app(app)
with app.app_context():
    db.create_all()


CLIENT_ID = "8a6d9e9f02eb44029490a5eee354f752"
CLIENT_SECRET = "9ac8f1f959bc4a9488f45d1a881acb0c"
# export URI='localhost:5000'
REDIRECT_URI = "http://" + os.environ['URI'] + "/auth/callback" 
SPOTIFY_API_ENDPOINT = "https://api.spotify.com/v1/search"
SPOTIFY_AUTH_URL = "https://accounts.spotify.com/authorize"
SPOTIFY_TOKEN_URL = "https://accounts.spotify.com/api/token"
SPOTIFY_API_URL = "https://api.spotify.com/v1"
SPOTIFY_USERS_URL = "https://api.spotify.com/v1/users/"
SPOTIFY_PUBLIC_URL = "https://open.spotify.com/user/"
SCOPES = "user-read-private user-read-email playlist-read-private playlist-modify-public playlist-modify-private playlist-read-collaborative"

auth_query_parameters = [
    ("client_id", CLIENT_ID),
    ("response_type", "code"),
    ("redirect_uri", REDIRECT_URI),
    ("scope", SCOPES),
]

@app.route("/")
def index():
    spotify_auth_url_query_strings = urlencode(auth_query_parameters)
    spotify_auth_url = "{auth_url}/?{query_strings}".format(auth_url=SPOTIFY_AUTH_URL,
                                                            query_strings=spotify_auth_url_query_strings)

    return redirect(spotify_auth_url)


@app.route("/auth/callback")
def spotify_auth_callback():

    auth_token = request.args['code']

    request_token_payload = {
        "client_id": CLIENT_ID,
        "client_secret": CLIENT_SECRET,
        "grant_type": "authorization_code",
        "code": auth_token,
        "redirect_uri": REDIRECT_URI
    }

    request_auth_token = requests.post(SPOTIFY_TOKEN_URL, data=request_token_payload)

    if request_auth_token.status_code != 200:
        return jsonify(request_auth_token.json()), request_auth_token.status_code

    access_token = request_auth_token.json().get("access_token")
    headers = {"Authorization": "Bearer {}".format(access_token)}

    # get user Spotify profile
    spotify_user_url = "{}/me".format(SPOTIFY_API_URL)
    request_spofify_user = requests.get(spotify_user_url, headers=headers)
    user_data = json.loads(request_spofify_user.text)

    # items to put into database
    id = user_data['id']
    email = user_data['email']
    display_name = user_data['display_name']
    

    #add to database 
    user= User(id =id, 
    display_name =display_name,
    email = email)
 
    db.session.add(user)
    db.session.commit()

    #Fetch user's playlist
    #playlist
    user_id = request_spofify_user.json().get("id")
    spotify_user_playlist_url = "{}/users/{}/playlists".format(SPOTIFY_API_URL, user_id)
    request_spofify_user_playlist = requests.get(spotify_user_playlist_url, headers=headers)
    playlist_data = json.loads(request_spofify_user_playlist.text)
    numOfPlaylists = playlist_data
    # Add to database to playlists
    for i in range(len(playlist_data['items'])): 
        name = playlist_data['items'][i]['name']
        playlist= Playlist(id = i, user_id = user_id ,name= name)

        db.session.add(playlist)
        db.session.commit()

    response = {"user_details": request_spofify_user.json(),
               "user_playlist": request_spofify_user_playlist.json()}
   
    #return json.dumps({'success': True, 'data': playlist.serialize()}), 200

    #return json.dumps({'success': True, 'data': user.serialize()}), 200

    # to check if email and user id and etc display correctly, uncoment 
    #return email
    return jsonify(response), request_spofify_user.status_code

@app.route('/users/')
def get_initial_users():
    users = User.query.all()
    res = {'success': True, 'data': [user.serialize() for user in users]}
    return json.dumps(res), 200

@app.route('/playlists/')
def get_initial_playlists():
   
    playlists = Playlist.query.all()
    res = {'success': True, 'data': [playlist.serialize() for playlist in playlists]}
    return json.dumps(res), 200

@app.route('/playlist/<mood>/<genre>/<activity>', methods = ['POST', 'GET'])
def playlist(mood, genre, activity):
    sp = spotipy.Spotify()
    client_credentials_manager = SpotifyClientCredentials(client_id="8a6d9e9f02eb44029490a5eee354f752",
                                                      client_secret="9ac8f1f959bc4a9488f45d1a881acb0c")
    spotify = spotipy.Spotify(client_credentials_manager=client_credentials_manager)

    mood = mood
    genre = genre
    activity = activity
    results = spotify.search(q= mood+ " " + genre+ " " +activity, type='playlist' )
    items = results['playlists']['items'][0]['external_urls']['spotify']
   
  
    name = results['playlists']['items'][0]['name']
    playlist= Playlist(name= name)
    
    #response = {"user_details": request_spofify_user.json(),
    #           "user_playlist": request_spofify_user_playlist.json()}
   
    #add to database 
    db.session.add(playlist)
    db.session.commit()
    #return json.dumps({'success': True, 'data': playlist.serialize()}), 200

    return (json.dumps(items))
    #return json.dumps({'success': True, 'data': items}), 200



if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)





