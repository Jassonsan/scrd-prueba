FROM python:3.9
WORKDIR /usr/src/app
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY api/ ./
EXPOSE 8000
CMD python manage.py runserver 0.0.0.0:8000
