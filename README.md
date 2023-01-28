# Spello

An old project of mine indended to help my friend's mom who was a teacher at our school.

## Intended use

This app was made for an elementary school ESL (English Second Language) teacher. It was designed to replace spelling worksheets that the students hated. The app looks and functions more like a game, with the intention to increase student engagement. The app included 2 modes:

1. Word search game - Students have to drag-select the correct letters, spelling out whichever word the image cue is showing.

2. Word scramble - Shows an image plus a scrambled word and prompts the student to spell the corresponding vocabulary word. 

![alt text](https://github.com/AndonisD/Spello/blob/main/images/Image%20E1_%20Client%20testing%20the%20product%20(1).jpg?raw=true)

## Tech

Flutter + Firebase

The app was made in Flutter so it could be run on both IOS and Android Devices (either school IPads or student owned devices). There was no backend. Instead, the teacher was be able to insert the vocab list along with url links to corresponding images into a SpreadSheet in her Google Drive. She could then press a "sync" button on the spreadsheet which would run a Google Apps script. The script sent the data to a firebase database. The students could then retrieve all the necessary data by launching the app, or pressing a "refresh" button. The functionality for generating the word scramble and the word search were on the front end, implemented in Dart. 


