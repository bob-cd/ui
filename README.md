# bob-cd/ui
> An opinionated GUI for Bob

### Requirements 
- docker

### Running
1. `docker-compose up` 
2. To query bob's `/pipelines` endpoint from the browser, visit `localhost:7887/pipelines`
3. 2. To view the Elm Reactor page, visit `localhost:7979`

### Development
The code lives in the `src` folder and tests in the `tests` folder 
- to transpire the code to JavaScript: `elm reactor`
- to run the tests, run `./run.sh elm-test`

