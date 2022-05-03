<p align="center">
  <img src="./assets/logo.png" alt="Logo" height="110">
</p>

<p>

# Homestay
*The project was done for the fulfillment of COMP 207 (4th Semester Project).*
<br><br>

## About
A minimal mobile application to make information about homestay available to the seekers.


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