# moodify
Moodify:
Custom Spotify playlist recommendations based on your mood.

Moodify takes the user through a brief quiz where they select a mood, activity and genre of music. The app uses their custom input and links them to a Spotify playlist that best matches their input. Once the user has completed the quiz, they can either open the Spotify playlist in a browser window or restart the quiz. The app also implements user authentication by automatically opening a Spotify login window when the app is opened by a new user for the first time.

Link to github repos:
https://github.com/crencricca/moodify
https://github.com/annashats/moodify <- has backend portion under src

A list of how your app addresses each of the requirements (iOS / Backend)
iOS:
AutoLayout using NSLayoutConstraint.
UICollectionView organizes buttons for user input selection
Uses navigation (UINavigationController) to navigate between four View Controller screens.
Integrates the Spotify API.

Backend: 

Databases for both Users who have logged in and Playlists of users (that also adds the current_user into the database with the spotify playlist name that resulted from going through the inputs of mood, genre, and activities. Deployed -API spec: https://paper.dropbox.com/doc/Moodify-API-Spec--AS_o~fveGb_fOjeVi3tvCgpBAQ-9rLTcRNgDuBGrEcOVdtlr

![Welcome Screen](https://github.com/crencricca/moodify/blob/master/screenshots/main.png)

![Mood Selection Screen](https://github.com/crencricca/moodify/blob/master/screenshots/playlist.png)

![Playlist Result](https://github.com/crencricca/moodify/blob/master/screenshots/result.png)

![Playlist in Browser](https://github.com/crencricca/moodify/blob/master/screenshots/selection.png)
