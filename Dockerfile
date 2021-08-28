FROM python:3.7


RUN useradd apps && mkdir /app && chown apps:apps -R /app

COPY --chown=apps:apps . /app
COPY --chown=apps:apps pyproject.toml /app

WORKDIR /app

RUN pip install uvicorn fastapi 

RUN pip3 install poetry && poetry config virtualenvs.create false && poetry install --no-dev 

USER apps

EXPOSE 3000

ENTRYPOINT [ "uvicorn", "app:app" , "--host", "0.0.0.0", "--port", "3000" ]