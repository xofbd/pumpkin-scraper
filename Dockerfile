FROM python:3.9.2-slim

# Make sure song files created are owned by the host's account and not root
ARG USER_ID
ARG GROUP_ID

RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

# Install project
COPY . /project
WORKDIR project
USER root
RUN pip install -r requirements.txt

# Switch users and run scraper
USER user
ENTRYPOINT ["bin/download"]
CMD ["--help"]
