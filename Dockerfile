FROM python:3.10.2-slim

ARG BUILD_ENV

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV POETRY_VERSION=1.1.12
ENV PIP_DISABLE_PIP_VERSION_CHECK=on

# System deps:
RUN pip install "poetry==$POETRY_VERSION"

WORKDIR /app
COPY poetry.lock pyproject.toml ./
#
## Project initialization:
RUN poetry config virtualenvs.create false \
  && poetry install $(test "$BUILD_ENV" == production && echo "--no-dev") --no-interaction --no-ansi

COPY . .

