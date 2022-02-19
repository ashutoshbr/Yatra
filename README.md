<p align="center">
  <img src="./assets/yatra-logo.png" alt="Logo" height="110">
</p>

<p>

# Yatra
*The project was done for the fulfillment of COMP 207 (4th Semester Project).*
<br><br>

## About
As a result of COVID-19, tourism in Nepal has taken a severe hit, the Mega event Visit Nepal
2020 got canceled. Small businesses planned for the event are all on the verge of collapsing.
Realizing this, we have come up with a mobile application “Yatra”. “Yatra” is a tourism-based
application, from where users can view travel destinations, places of interest, experience of
visitors during their stay, places to stay and more. People can also share pictures within the
application promoting various places. The main objective of “Yatra” is to promote travel
destinations in Nepal and to discover places within Nepal that are yet to be well recognized.
For this project, we will be using Flutter for the frontend and FastAPI, PostgreSQL and Azure
for the backend.
Keywords: Yatra, Mobile Application

## :airplane: Hosting

Project will be hosted when development phase is over:
- [https://lorem-ipsum.azurewebsites.net/](https://lorem-ipsum.azurewebsites.net/)


## :toolbox: Tech Stack

- Flutter for mobile app
- FastAPI and PostgreSQL for Backend
- Azure for deployment

## :hammer: Dev Environment Setup

Running this project on your local machine.

### 1. Install Requirements

```bash
pip install -r requirements.txt
```

### 2. Use uvicorn to run the app

In the root directory of project run:

```bash
uvicorn app.main:app --reload
```

Visit `http://127.0.0.1:8000` to see the result.