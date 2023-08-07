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
  - [RESTCountries](https://restcountries.com/#api-endpoints-v3-all) - ability to get a random country name to input into Edamam's search query for the `/api/v1/recipes` endpoint. Additionally there is an endpoint to allow you to fetch that country's capital to utilize for the `/api/v1/air_quality` endpoint. You do not need an API from this site, however documentation is available above about the API.
  - [Youtube](https://developers.google.com/youtube/v3/getting-started) - ability to receive video data to appear on the `api/v1/learning_resources` endpoint. You will need to have a google account in order to create an api_key.
  - [Unsplash](https://unsplash.com/developers) - ability to get random photos to appear on the `api/v1/learning_resources` endpoint
  - [API NINJA](https://api-ninjas.com/api/airquality) - ability to get airquality data for an inputted city, utilized in the `/api/v1/air_quality` endpoint

Once you have your key for each site, add them to the `config/application.yml` file generated when you configure Figaro (see Step 5, above). Please ensure you include the exact variable names below:

 - `EDAMAM_ID: <add your key here>`
 - `EDAMAM_KEY: <add your key here>`
 - `GOOGLE_TOKEN: <add your key here>`
 - `UNSPLASH_TOKEN: <add your key here>`
 - `API_NINJAS: <add your key here>`

<h2>Testing</h2>

To run the full test suite: `bundle exec rspec`

CreativeCuisines uses `Simplecov` to monitor test coverage. At the time of writing, test coverage was at 100% with all tests passing. `VCR` with `Webmock` is used to mock calls to external APIs.

<h2>EndPoints</h2>
<details>
<summary>route: GET /api/v1/recipes?country=""</summary>
Get Recipes For A Particular Country -- searching for cuisines by country. Example data:

    {
    "data": [
        {
            "id": null,
            "type": "recipe",
            "attributes": {
                "title": "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)",
                "url": "https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html",
                "country": "thailand",
                "image": "https://edamam-product-images.s3.amazonaws.com..."
            }
        },
        {etc...},
      ]
    }

If the country parameter is either an empty string, or a value that doesn’t return any recipes, return an empty array:

    {
      "data": []
    }

</details>

<details>
<summary>route: GET /api/v1/learning_resources?country=""</summary>
Get Learning Resources for a Particular Country -- include videos about that country's culture and images. Example data:

    {
    "data": {
        "id": null,
        "type": "learning_resource",
        "attributes": {
            "country": "laos",
            "video": {
                "title": "A Super Quick History of Laos",
                "youtube_video_id": "uw8hjVqxMXw"
            },
            "images": [
                {
                    "alt_tag": "standing statue and temples",
                    "url": "https://images.unsplash.com/photo-1528181304..."
                },
                {etc...},
              ]
        }
      }
    }

If no videos or images are found, those keys should point to an empty object:

    {
      "data": {
          "id": null,
          "type": "learning_resource",
          "attributes": {
              "country": "laos",
              "video": {},
              "images": []
          }
      }
    }

</details>

<details>
<summary>route: POST /api/v1/users </summary>
User Registration. Example data:

Example Request:

    POST /api/v1/users
    Content-Type: application/json
    Accept: application/json

    {
      "name": "Odell",
      "email": "goodboy@ruffruff.com",
      "password": "treats4lyf",
      "password_confirmation": "treats4lyf"
    }

Example Response:

    {
      "data": {
        "type": "user",
        "id": "1",
        "attributes": {
          "name": "Odell",
          "email": "goodboy@ruffruff.com",
          "api_key": "jgn983hy48thw9begh98h4539h4"
        }
      }
    }

Email addresses must be unique. If a unique email address is not used for registration, an appropriate error message is returned in the response. If passwords do not match, an appropriate error message is returned in the response. Example:

    {
      "errors": [
        {
            "status": "400",
            "title": "Email has already been taken and Password confirmation doesn't match Password"
        }
      ]
    }


</details>

<details>
<summary>route: POST /api/v1/sessions </summary>
Log In USer. Example data:

Example Request:

    POST /api/v1/sessions
    Content-Type: application/json
    Accept: application/json

    {
      "email": "goodboy@ruffruff.com",
      "password": "treats4lyf"
    }

Example Response:

    {
      "data": {
        "type": "user",
        "id": "1",
        "attributes": {
          "name": "Odell",
          "email": "goodboy@ruffruff.com",
          "api_key": "jgn983hy48thw9begh98h4539h4"
        }
      }
    }

An unsuccessful request returns an appropriate 400-level status code and body with a description of why the request wasn’t successful. Example:

    {
      "errors": [
          {
              "status": "401",
              "title": "Unauthorized user"
          }
      ]
    }

</details>

<details>
<summary>route: POST /api/v1/favorites </summary>
Add Favorites Functionality to add recipes to a favorited list for a particular user can be done with the following request. Example data:

Example Request:

    POST /api/v1/favorites
    Content-Type: application/json
    Accept: application/json

    {
        "api_key": "jgn983hy48thw9begh98h4539h4",
        "country": "thailand",
        "recipe_link": "https://www.tastingtable.com/.....",
        "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
    }

Example Response:

    {
        "success": "Favorite added successfully"
    }

If the api_key is invalid (no user with that api key), an appropriate 400-level status code is returned, as well as a message explaining what went wrong.

    {
      "errors": [
        {
            "status": "401",
            "title": "Unauthorized user"
        }
      ]
    }

</details>

<details>
<summary>route: GET /api/v1/favorites?api_key="" </summary>
Get a User’s Favorites -- ability for a user to see all their favorite recipes. Example data:

Response:

    {
      "data": [
        {
            "id": "1",
            "type": "favorite",
            "attributes": {
                "recipe_title": "Recipe: Egyptian Tomato Soup",
                "recipe_link": "http://www.thekitchn.com/recipe-egyptian-tomato-soup-weeknight....",
                "country": "egypt",
                "created_at": "2022-11-02T02:17:54.111Z"
            }
        },
        {
            "id": "2",
            "type": "favorite",
            "attributes": {
                "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)",
                "recipe_link": "https://www.tastingtable.com/.....",
                "country": "thailand",
                "created_at": "2022-11-07T03:44:08.917Z"
            }
        }
      ]
    }

If the api_key is invalid (no user with that api key), an appropriate 400-level status code is returned, as well as a message explaining what went wrong.

    {
      "errors": [
        {
            "status": "401",
            "title": "Unauthorized user"
        }
      ]
    }


If the user does not have any favorite recipes saved, it returns empty []

    {
       "data": []
    }

</details>

<details>
<summary>route: DELETE /api/v1/favorites?api_key="" </summary>
Delete a User’s Favorites -- ability for a user delete a favorited recipe. Example data:

    no data is rendered for this

</details>