# Dockerfile
# Uses multi-stage builds requiring Docker 17.05 or higher
# See https://docs.docker.com/develop/develop-images/multistage-build/

# Creating a python base with shared environment variables
FROM python:3.10.2-alpine3.15 as python-base
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_NO_INTERACTION=1 \
    PYSETUP_PATH="/opt/pysetup" \
    VENV_PATH="/opt/pysetup/.venv"

ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"


# builder-base is used to build dependencies
FROM python-base as builder-base
RUN apk add --no-cache \
        curl \
        gcc \
        g++ \
        libressl-dev \
        musl-dev \
        notmuch \
        notmuch-dev \
        libffi-dev 
    #curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile=minimal && \
    #source $HOME/.cargo/env 

# Install Poetry - respects $POETRY_VERSION & $POETRY_HOME
ENV POETRY_VERSION=1.1.7
RUN curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/install-poetry.py | python -

#    pip install --no-cache-dir poetry==${POETRY_VERSION} && \
#RUN apk del \
        #curl \
        #gcc \
        #libressl-dev \
        #musl-dev \
        #libffi-dev

# We copy our Python requirements here to cache them
# and install only runtime deps using poetry
WORKDIR $PYSETUP_PATH
COPY ./poetry.lock ./pyproject.toml ./
RUN poetry install --no-dev # respects 


# 'development' stage installs all dev deps and can be used to develop code.
# For example using docker-compose to mount local volume under /app
FROM python-base as development
#ENV FASTAPI_ENV=development
RUN apk add notmuch 

# Copying poetry and venv into image
COPY --from=builder-base $POETRY_HOME $POETRY_HOME
COPY --from=builder-base $PYSETUP_PATH $PYSETUP_PATH

# venv already has runtime deps installed we get a quicker install
#RUN addgroup -S appgroup && adduser -S appuser -u 1000 -G appgroup
#USER appuser

WORKDIR $PYSETUP_PATH
RUN poetry install --no-dev

WORKDIR /app
COPY . .

CMD ["python", "trackpenses/main.py"]
