# [WHEW](https://www.youtube.com/watch?v=iy-LQH8N6Ug)S - We Have Enough Web Servers (So Here's Another One)

An HTTP server modeled on Ruby on Rails built on WEBrick using Ruby metaprogramming.

Built to gain a deeper understanding of Rails.

## Features included:
* Sessions using cookies
* ERB Templating for Views
* RESTful routing
* Params (parses request body and query string)

## TODO
* Add `Flash` class which includes a `#now` method
* "Strong Parameters"
* Add Route Helpers (`link_to`, `button_to`)
* Add CSRF Tokens
* Add View partials
* Nested Routing
* User-defined helpers

## How to use:
* Initialize new router and server objects (example in: bin/router_server.rb)
* Router#run sets the HTTP response body and content-type according to its inputs
* Router#draw takes a pattern, controller_class, and action_name to create a route for an HTTP request.