FROM jlrigau/maven-git 

RUN git clone https://github.com/shiehn/TrebleMaker.git 

RUN apt-get -y update

RUN apt-get -y install software-properties-common

RUN apt-get -y update

RUN apt-get -y install sox libsox-fmt-all

RUN apt-get -y install fluidsynth

WORKDIR /TrebleMaker

RUN ./scripts/fetch-deps.sh

ENV TM_ROOT_DIR="/TrebleMaker" \
    TM_CACHE_CONN="hazelcast:5701" \
    TM_DB_CONN="jdbc:mysql://treblemakerdb:3306/hivecomposedb?useSSL=false&autoReconnect=true&maxReconnects=360&initialTimeout=2" \
    TM_DB_USER="treble" \
    TM_DB_PASS="maker" \
    TM_API_USER="treble" \
    TM_API_PASS="maker" \
    TM_API_URL="http://treblemakerapi:7777" \
    TM_API_UPLOAD_URL="http://treblemakerapi:7777/filesync" \
    TM_BYPASS_RHYTHM_RATING="true" \
    TM_BYPASS_BASSLINE_RATING="true" \
    TM_BYPASS_ARPEGGIO_RATING="true" \
    TM_BYPASS_HARMONIC_LOOP_RATING="true" \
    TM_BYPASS_BEAT_LOOP_RATING="true" \
    TM_BYPASS_SEQUENCE_RATING="true" \
    TM_BYPASS_EQ_RATING="true" \
    TM_BYPASS_ANALYTICS="false" \
    TM_BYPASS_EQ_ANALYTICS="true" \
    TM_NUM_OF_MIXES=1 \
    TM_NUM_OF_MIX_VARIATIONS=1 \
    TM_CORE_LOG_DIR="logs" \
    TM_QUEUE_POLL_INTERVAL=60000 \
    AWS_BUCKET_NAME="[YOUR-BUCKET]" \
    AWS_ACCESS_KEY_ID="[YOUR-AWS-ACCESS-KEY]" \
    AWS_SECRET_ACCESS_KEY="[YOUR-AWS-SECRET-KEY]"

WORKDIR /TrebleMaker

RUN ./create_aws_credentials.sh 

CMD ./wait_on_api.sh
 
