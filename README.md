# SWA-ROR Readme File

This readme is a template overview of the app

## Areas Covered

### 1.Configuration

- The app configs are located on environments development. Two env variables are enlisted.

```bash
  ENV["API_URL"] = ***
  ENV["API_KEY"] = ***
```

These two are used to pull json data from a remote Google API endpoint and store the data in an sqlite3 database.If the API key fails , generate a new one from Google cloud console

## 2. Run Locally (Without docker)

Clone the project

```bash
  git clone https://github.com/ongubo/swa_ror.git
```

Go to the project directory

```bash
  cd swa_ror
```

Install dependencies

```bash
  gem install bundler
```

Next, migrate the database:

```bash
  rails db:migrate
```

Start the server

```bash
  rails s
```

## 3. Run Locally (With docker)

Ensure you have docker locally installed then build the app

```bash
  docker-compose up --build -d
```

- To build docker image and run container as a service **_i.e. in detached mode_**, for testing purposes you can leave out the **_-d_** switch to see logs.

```bash
  docker-compose up
```

- To run the docker image that has already been built
