FROM python:2.7-alpine

ADD requirements.txt requirements.txt
RUN pip install -r requirements.txt
ADD . /app
# install requirements

WORKDIR /app

EXPOSE 8000

# Set the default command to run when starting the container
RUN python manage.py makemigrations
RUN python manage.py migrate

RUN python manage.py loaddata cbv/fixtures/project.json \
    cbv/fixtures/1.3.json \
    cbv/fixtures/1.4.json \
    cbv/fixtures/1.5.json \
    cbv/fixtures/1.6.json \
    cbv/fixtures/1.7.json \
    cbv/fixtures/1.8.json \
    cbv/fixtures/1.9.json \
    cbv/fixtures/1.10.json \
    cbv/fixtures/1.11.json \

RUN python manage.py collectstatic --noinput
CMD ["gunicorn", "inspector.wsgi", "-b", ":8000"]