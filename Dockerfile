FROM python:3.8
WORKDIR /fastapi-app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY ./src ./src
COPY ./tests ./tests
CMD ["python", "./src/main.py"]
