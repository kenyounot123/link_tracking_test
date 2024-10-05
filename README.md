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
I first thought about how I can handle a global event listener for all `<a>` tags in my application. That way we can react to whenever a user clicks on a link. I did this using stimulus controllers. Considering how the bulk of my application's html is rendered within the `<body>` tag, I decided to add a `data-link-data-controller` attribute to my body tag so that when this 
controller is connected we can get all the `<a>` tags and give them a `data-action` attribute set to `click->link-data#trackCick`. This tells our controller to invoke the `trackClick` action which would handle making a request to one of our rails routes endpoint and passing in the relevant data that we need.

## Future Improvements


## Scaling Considerations


