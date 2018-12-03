import requests


SPOTIFY_API_ENDPOINT = 'https://api.spotify.com/v1/search'

KEYMAP = {'artist': 'artists',
          'track': 'tracks',
          'album': 'albums',
          'playlist': 'playlists'}
          
def get_track_url(song_title):
    spotify_url = 'https://api.spotify.com/v1/search'
    params = {'q': song_title, 'type': 'track'}

    spotify_response = requests.get(spotify_url, params=params).json()
    track_url = spotify_response['tracks']['items'][0]['preview_url']
    return track_url

def query(query_type, query_term, offset=0, limit=5):
    params = {'type': query_type, 'q': query_term, 'offset': offset, 'limit': limit}
    r = requests.get(SPOTIFY_API_ENDPOINT, params=params)
    response = r.json()
    return _format_response(response, query_type)


def _format_track(item):
    artist_names = ", ".join(artist['name'] for artist in item['artists'])
    simple_item = {
        'image': _get_64px_image_url(item['album']),
        'name': '{track} by {artist}'.format(track=item['name'], artist=artist_names)
    }
    return simple_item


def _format_item(item):
    simple_item = {
        'image': _get_64px_image_url(item),
        'name': item['name']
    }
    return simple_item


FORMATTING_FUNCTIONS = {
    'track': _format_track,
    'artist': _format_item,
    'playlist': _format_item,
    'album': _format_item
}


def _format_items(items, query_type):
    simple_items = []
    for item in items:
        simple_item = FORMATTING_FUNCTIONS[query_type](item)
        simple_items.append(simple_item)
    return simple_items


def _format_response(response, query_type):
    typed_response = _get_typed_response(response, query_type)
    items = typed_response['items']
    count = typed_response['total']
    simple_items = _format_items(items, query_type)
    return {'total_count': count, 'items': simple_items}


def _get_typed_response(response, query_type):
    typed_response = response[KEYMAP[query_type]]
    return typed_response


def _get_64px_image_url(item):
    images = item['images']
    for image in images:
        if image['width'] in [64, 60]:
            return image['url']
    return ''