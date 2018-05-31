## TrebleMaker.ai 
hosted version: http://treblemaker.ai

---

## What is this?
TrebleMaker.ai is a system that procedurally generates royalty free MIDI files.  The generated MIDI files are intended to be used by electronic musicians when composing new music.

---

#### The system is composed of five main components:
* **Data Parser**
    * This GoLang app converts the MusicXml dataset into a format consumable by the 'Model Trainers' https://github.com/shiehn/MusicXmlGoParser
     
* **Model Trainers**
    * These SpringBoot Java apps are responsible for consuming thae dataset and producing prediction models to be used by TrebleMakerCore & TrebleMakerApi.  Currently there are two trainers, one dedicated to melodies and the other for chord progressions https://github.com/shiehn/chords-to-melody-generator

* **TrebleMakerApi**
    * this API is consumed by the TrebleMakerWeb app and TrebleMakerCore.  Its primary purpose is to provide contentual music 'predictions' for TrebleMakerCore https://github.com/shiehn/TrebleMakerApi

* **TrebleMakerCore**
    * as the name suggests this SpringBoot Java app is the core component that assembles the MIDI and audio files.  During the assembly of the files it will constantly call out to TrebleMakerApi with context asking for musical predictions
 
* **TrebleMakerRating**
    * this Angular web GUI offers a way to 'rate' the generated audio files and decide which of files will be uploaded to TrebleMakerWeb

* **TrebleMakerWeb**
    * this Angular web GUI offers a user a way to listen and download the generated audio from the CDN (currently S3) https://github.com/shiehn/TrebleMakerWeb    

### Deploy Prerequisites:
* Install latest ‘Docker’: https://docs.docker.com/install/
* Install latest ‘Docker Compose’: https://docs.docker.com/compose/install/
* Create an S3 bucket: https://aws.amazon.com/s3/ (the AWS .pem key will be required in the following deploy instructions)

---

### Set Environment Variables
// **********************************
export TMW_NEXT_TRACK_URL="http:\/\/localhost:7777\/api\/track"
export TMW_S3_BUCKET="https:\/\/s3-us-west-2.amazonaws.com\/tmtesting\/" 
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
// **********************************

---

## Deploy Instructions:
* **RUN:** git clone https://github.com/shiehn/TrebleMakerDocker.git
* **RUN:** cd TrebleMaker
* Edit the ‘deploy.sh’ script to use your S3 bucket credentials
* //////pem key stuff
* **RUN** ./deploy.sh

---

## How to use:
* After docker-compose has stood up all the services the app ‘TrebleMaker’ will immediately begin generating midi & audio files.  (Expect the generation of a track to take at least ~10min)
When a track has completed it be will be pushed to the ‘TrebleMakerApi’.  

* By visiting http://localhost :7777 You can listen to and ‘rate’ the completed track.  If you want the track to become available to the GUI press ‘Publish Track’.
After a track has been ‘published’ you can the visit http://localhost to listen & download the track.