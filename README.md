<h1>Creative Cuisines</h1>
<h3>A Lunch and Learn Experience</h3>

Creative Cuisines is a back-end application built with Ruby on Rails that exposes an API to provide data on cuisines by countries searched and as well as additional information about that country's culture. This app will allow users to search for recipes by country, favorite recipes, and learn more about a particular country. It aggregates data from multiple external API endpoints and handles user registration, log-in with authentication, and token authentication to access requests. This application presumes the team is working in a service-oriented architecture pattern and follows RESTful API conventions.

<h2>Learning Goals</h2>
This project is part of the Turing School of Software + Design's Back-End Engineering track, and is the final solo project for Module 3. See more details about the project requirements <a href= "https://backend.turing.edu/module3/projects/lunch_and_learn/index">here</a>. Completing this application demonstrates:

- Exposing an API that aggregates data from multiple external APIs
- Exposing an API that requires an authentication token
- Exposing an API for CRUD functionality
- Implementation of Basic Authentication
- Ability to determine completion criteria based on the needs of other developers
- Ability to test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).

<h2>Installation</h2>
<h3>Running the Application Locally</h3>

1. Clone this repository from the command line: `git clone git@github.com:aplasket/creative_cuisines.git`
1. Navigate to your local repository: `cd creative_cuisines`
1. Install dependencies and gems: `bundle install`
1. Set up the database and run migrations: `rails db:{create, migrate}`
1. Configure Figaro to hide environment secret variables (see below): `bundle exec figaro install`
1. Start the Rails server: `rails s`

`With your local server running, you can use a tool like [Postman](https://www.postman.com/) or the [ThunderClient](https://marketplace.visualstudio.com/items?itemName=rangav.vscode-thunder-client) extension for VS Code to make sample requests and view responses.

<h3>External APIs</h3>
Creative Cuisine's endpoints expose data from Edamam, RESTCountries, Youtube and UnSplash. You can sign up for free access to these APIs here:

  - [Edamam](https://developer.edamam.com/edamam-recipe-api) - ability to search for recipes via query word for the `/api/v1/recipes` endpoint
  - [RESTCountries](https://restcountries.com/#api-endpoints-v3-all) - ability to get a random country name to input into Edamam's search query for the `/api/v1/recipes` endpoint. You do not need an API from this site, however documentation is available above about the API.
  - [Youtube](https://developers.google.com/youtube/v3/getting-started) - ability to receive video data to appear on the `api/v1/learning_resources` endpoint
  - [Unsplash](https://unsplash.com/) - ability to get random photos to appear on the `api/v1/learning_resources` endpoint

Once you have your key for each site, add them to the `config/application.yml` file generated when you configure Figaro (see Step 5, above). Please ensure you include the exact variable names below:

 - `EDAMAM_ID: <add your key here>`
 - `EDAMAM_KEY: <add your key here>`
 - `YOUTUBE_KEY: <add your key here>`
 - `UNSPLASH_KEY: <add your key here>`

<h2>Testing</h2>

To run the full test suite: `bundle exec rspec`

CreativeCuisines uses `Simplecov` to monitor test coverage. At the time of writing, test coverage was at 100% with all tests passing. `VCR` with `Webmock` is used to mock calls to external APIs.

<h2>EndPoints</h2>