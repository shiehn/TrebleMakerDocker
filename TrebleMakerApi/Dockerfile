FROM jlrigau/maven-git 

WORKDIR / 

RUN git clone https://github.com/shiehn/TrebleMakerApi.git

WORKDIR /TrebleMakerApi

ENV TM_API_ROOT_DIR="/TrebleMakerApi" \
    TM_API_USER="treble" \
    TM_API_PASS="maker" \
    TM_DB_CONN="jdbc:mysql://treblemakerdb:3306/hivecomposedb?useSSL=false&autoReconnect=true&maxReconnects=360&initialTimeout=2" \
    TM_DB_USER="treble" \
    TM_DB_PASS="maker" \
    TM_API_PORT="7777" \
    TM_API_LOG_DIR="logs" \
    TM_API_S3_BUCKET="https://s3-us-west-2.amazonaws.com/[YOUR-BUCKET-NAME]" \
    AWS_BUCKET_NAME="[YOUR-BUCKET-NAME]" \
    AWS_ACCESS_KEY_ID="[YOUR-ACCESS-KEY]" \
    AWS_SECRET_ACCESS_KEY="[YOUR-SECRET-KEY]"

EXPOSE 7777

CMD "./wait_on_database.sh" 