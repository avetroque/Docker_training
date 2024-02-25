FROM python:3.9.1


RUN apt-get install wget
RUN pip install pandas sqlalchemy 
RUN pip install psycopg2

WORKDIR /app

COPY ingest_data.py ingest_data.py
#COPY pipeline.py pipeline.py

#ENTRYPOINT [ "bash" ]

#ENTRYPOINT ["python", "pipeline.py"]

ENTRYPOINT ["python","ingest_data.py"]