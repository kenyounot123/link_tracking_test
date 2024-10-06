# Link Tracking Test

## Overview

My task was to implement a feature in Rails 8 that tracks every link click, both to internal pages and external websites. This data is stored in a database table called
`link_clicks` while considering any performance tradeoffs.

### Core Features
1. Track clicks on all links within the application
2. Store click data in the `link_clicks` table
3. Capture relevant details about each click
4. Implement the feature with minimal performance impact

## Implementation/Approach

### Tracking clicks
To track every link click I would need some sort of global event listener for all `<a>` tags in my application. I did this using stimulus controllers. Considering how the bulk of my application's html is rendered within the `<body>` tag, I decided to add a `data-link-data-controller` attribute to my body tag so that when this 
controller is connected I can get all the `<a>` tags and give them a `data-action` attribute set to `click->link-data#trackCick`. This tells our controller to invoke the `trackClick` action which would handle making a request to one of our rails routes endpoint and passing in the relevant data that I need.
### Capturing relevant details and Storing click data in `link_clicks`
I created a migration for `link_clicks` table with the required fields and also added appropriate indexes on `id` and `url` field for efficient querying. The stimulus controller action that would 
handle a link being clicked would do 2 things, handle internal/external links to get necessary data from the click and then send a post request to our backend that gets routed to `link_clicks#create` controller action, 
### Background jobs with solid_queue
To ensure minimal performance impact on the application when saving link clicks, I utilized background jobs with solid_queue. This allows the actual database save operation to happen asynchronously, without blocking the main request flow. In the `link_clicks#create` controller action, instead of directly saving the link click data, I enqueue a background job that performs the save operation. The perform_later method is used to schedule the job for later execution.
### Testing with Minitest
I implemented TDD (Test Driven Development) when building out the feature, where I wrote tests first before implementing the actual functionality. I wrote tests for `LinkClick` model methods,
background job functionality, and the click tracking functionality (integration test).
## Future Improvements
* Since there is no user authentication right now the admin dashboard is accessible by anyone. In the future there would be some sort of authentication that checks whether a user is an admin or not
* Real time tracking of link clicks data on admin page. Adding a realtime tracking system would give admins immediate insights to user behavior and we can do this by implementing Websockets and Actioncable
* UX improvement, currently the link clicks does not account for right-clicking the link or even using the mouse middle button to click the link. These events would not be considered because 
we are only listening for on click event (using left click)
* Data analytics. Maybe work on data aggregation to provide more valuable insights. Currently only have total clicks, most clicked url, and active links

## Scaling Considerations
* Consider what happens if we get a lot of traffic on our website
* Caching frequently accessed data 
* asynchronous batch inserting
