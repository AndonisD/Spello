# Spello

An old project of mine indended to help my friend's mom who was an English as a Second Language teacher at my elementary school.

<img src="https://github.com/AndonisD/Spello/blob/main/images/Image%20E1_%20Client%20testing%20the%20product%20(1).jpg" width=50% height=50%>

## Intended use

Main Screen:

<img src="https://github.com/AndonisD/Spello/blob/main/images/main_screen.jpg" width=25% height=25%>

This app was made for an elementary school ESL (English Second Language) teacher. It was designed to replace spelling worksheets that her students hated. The app looks and functions more like a game, with the intention to increase student engagement. The app included 2 modes:

1. Word scramble - Shows an image plus a scrambled word and prompts the student to spell the corresponding vocabulary word:

<img src="https://github.com/AndonisD/Spello/blob/main/images/scramble.jpg" width=25% height=25%>

2. Word search game - Students have to drag-select the correct letters, spelling out whichever word the image cue is showing:

<img src="https://github.com/AndonisD/Spello/blob/main/images/word_search.jpg" width=25% height=25%>

## Tech

Flutter + Firebase

The app was made in Flutter so it could be run on both IOS and Android Devices (either school IPads or student owned devices). There was no backend. Instead, the teacher was be able to insert the vocab list along with url links to corresponding images into a SpreadSheet in her Google Drive. She could then press a "sync" button on the spreadsheet which would run a Google Apps script. The script sent the data to a firebase database. The students could then retrieve all the necessary data by launching the app, or pressing a "refresh" button. The functionality for generating the word scramble and the word search were on the front end, implemented in Dart. 


