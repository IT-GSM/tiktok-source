# Use an official Python runtime as a parent image
#FROM mcr.microsoft.com/playwright/python:v1.42.0-jammy
FROM apify/actor-python-playwright:3.9
#FROM mcr.microsoft.com/playwright:focal
#python:3.9-alpine mcr.microsoft.com/playwright:focal
# Install necessary dependencies for Chrome
RUN apt-get update && apt-get install -y python3-pip\
    wget \
    gnupg \
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgdk-pixbuf2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libx11-6 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxrandr2 \
    xdg-utils \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Set up Chrome repository and install Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /app
COPY . .

#RUN python -m playwright install
# Install any needed dependencies specified in requirements.txt
RUN pip3 install -r requirements.txt

#RUN pip3 install TikTokApi

#RUN python -m playwright install
# Run source.py script
#RUN python3 app.py
#COPY app.py /app

# Command to run your application
CMD ["python3", "source.py"]


