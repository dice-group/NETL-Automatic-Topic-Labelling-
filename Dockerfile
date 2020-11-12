FROM python:3.7

WORKDIR /usr/src/app

COPY model_run/pre_trained_models model_run/pre_trained_models
COPY model_run/support_files model_run/support_files

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY model_run/*.py model_run/

WORKDIR /usr/src/app/model_run

ENTRYPOINT [ "python", "./get_labels.py" ]
CMD [ "-cg", "-us", "-s", "--data", "/data/topics.csv" ]
