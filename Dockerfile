FROM python:2.7-alpine

ADD . /app
WORKDIR /app

# install requirements
RUN pip install -r requirements.txt

# build the database structure
RUN python manage.py makemigrations
RUN python manage.py migrate

# load data for Django versions
RUN python manage.py loaddata cbv/fixtures/project.json \
    cbv/fixtures/1.3.json \
    cbv/fixtures/1.4.json \
    cbv/fixtures/1.5.json \
    cbv/fixtures/1.6.json \
    cbv/fixtures/1.7.json \
    cbv/fixtures/1.8.json \
    cbv/fixtures/1.9.json \
    cbv/fixtures/1.10.json \
    cbv/fixtures/1.11.json

# build static assets for web frontend
RUN python manage.py collectstatic --noinput

EXPOSE 8000
CMD ["gunicorn", "inspector.wsgi", "-b", ":8000"]