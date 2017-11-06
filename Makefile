help:
	@echo "Usage:"
	@echo "    make help: prints this help."
	@echo "    make test: runs the tests."
	@echo "    make run: run the app"
	@echo "    make build: rebuild the Docker image"

test:
	python manage.py test cbv

run:
	docker run -p 80:8000 django-cbv-inspector

build:
	docker build -t django-cbv-inspector .
