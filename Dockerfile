FROM python:3.7

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

WORKDIR /usr/src/app/model_run

ENTRYPOINT [ "python", "./get_labels.py" ]
CMD [ "-cg", "-us", "-s", "--data", "/data/topics.csv" ]
