## TrebleMaker.ai 
hosted version: http://treblemaker.ai

---

## What is this?
TrebleMaker.ai is a distributed system that procedurally generates royalty free MIDI files.  The generated MIDI files are intended to be used by electronic musicians when composing new music.

---

#### The system is composed of five related components:
* **Data Parser**
    * This GoLang app converts the MusicXml dataset into a format consumable by the 'Model Trainers' https://github.com/shiehn/MusicXmlGoParser
     
* **Model Trainers**
    * These SpringBoot Java apps are responsible for consuming the dataset and producing prediction models to be used by TrebleMakerCore & TrebleMakerApi.  Currently there are two trainers, one dedicated to melodies and the other for chord progressions https://github.com/shiehn/chords-to-melody-generator

* **TrebleMakerApi**
    * this API is consumed by the TrebleMakerWeb app and TrebleMakerCore.  Its primary purpose is to provide contextual music 'predictions' for TrebleMakerCore https://github.com/shiehn/TrebleMakerApi

* **TrebleMakerCore**
    * as the name suggests this SpringBoot Java app is the core component that assembles the MIDI and audio files.  During the assembly of the files it will constantly call out to TrebleMakerApi with context asking for musical predictions https://github.com/shiehn/TrebleMaker.git
 
* **TrebleMakerRating**
    * this Angular web GUI offers a way to 'rate' the generated audio files and decide which of files will be uploaded to TrebleMakerWeb

* **TrebleMakerWeb**
    * this Angular web GUI offers a user a way to render, listen and download the generated midi https://github.com/shiehn/TrebleMakerClientSynths.git    
 

### Deploy Prerequisites:
* Install latest ‘Docker’: https://docs.docker.com/install/
* Install latest ‘Docker Compose’: https://docs.docker.com/compose/install/
* Create an S3 bucket in the *WEST-US-2* region: https://aws.amazon.com/s3/
* The bucket permissions will need to allow the app to push to it
* After creating the S3 bucket you will need the **AWS_SECRET_KEY** & **AWS_ACCESS_KEY**

---

### Configure Environment
**Edit: /deploy.sh**
* replace *[YOUR-BUCKET-NAME]* with the name of your bucket you created

**Edit: /TrebleMaker/Dockerfile**
* Replace *[YOUR-BUCKET]* with your s3 bucket name
* Replace *[YOUR-AWS-ACCESS-KEY]*  with your aws access key
* Replace *[YOUR-AWS-SECRET-KEY]* with your aws secret key

**Edit: /TrebleMakerApi/Dockerfile**
* Replace *[YOUR-BUCKET]* with your s3 bucket name
* Replace *[YOUR-AWS-ACCESS-KEY]*  with your aws access key
* Replace *[YOUR-AWS-SECRET-KEY]* with your aws secret key

---

## Deploy Instructions:
* **RUN:** git clone https://github.com/shiehn/TrebleMakerDocker.git
* **RUN:** cd TrebleMaker
* **Edit** the ‘deploy.sh’ script to use your S3 bucket credentials
* **RUN** ./deploy.sh

---

## Usage Instructions:
* After docker-compose has stood up all the services the app ‘TrebleMaker’ will immediately begin generating midi & audio files.  (Depending on the size of your database expect the generation of a track to take at least ~15min)
When a track has completed it be will be pushed to the ‘TrebleMakerApi’.  

* By visiting http://localhost :7777 You can listen to and ‘rate’ the completed track.  The deploy script pulls a database dump that I've populated.  Rating your own data is possible. However it is a significant amount of effort and will require that the you persist the mysql database.  If you want the track to become available to the GUI press ‘Publish Track’.

![ratingtool](https://user-images.githubusercontent.com/826261/40818411-f19bfbda-6524-11e8-9190-ff7a42edaaa6.png)

* After a track has been ‘published’ you can the visit http://localhost to listen & download the track.

![player](https://user-images.githubusercontent.com/826261/40818470-1dc3ae56-6525-11e8-8f2f-f78abf3a32f7.png)
