# README

**This is a take-home test I was given by a company called ListenField, which wanted to evaluate me.**

Here was the message:

    Hello Yasuhiro,

    Thank you for taking time to have the interview with Rassarin and Honda!

    I would like to give you a small exercise just to see how you are architecting things. It should be fairly easy and not take too long.
    Ideally I would prefer if you can make this in Ruby on Rails (in API Mode). But I'm also okay with node / typescript if you prefer.
    The project definition is voluntarily abstract, feel free to ask questions if there is something unclear.


    Project:
    Build an Ice Cream Truck!

    Definition:
    I want an ice cream truck. The ice cream truck is selling many Foods. They sell Ice Creams, they sell Shaved Ice, and also snack bars!
    Each one of these foods has a price and a name.  An ice cream has many flavors. Chocolate, Pistachio, Strawberry and Mint.
    The ice cream truck has a limited amount of ice creams, shaved ice and chocolate bars of course. The ice cream truck has many customers. They come and buy a specific amount of Foods. Each time they buy something, the truck owner should say "ENJOY!".
    If they try to buy more than what the ice cream truck has, then the ice cream truck owner should respond with "SO SORRY!".

    You'll build that ice cream truck as an API.
    The API should have a simple endpoint to buy a specific food from the ice cream truck.
    And another endpoint that gives me the inventory of the ice cream truck, and the total amount of money the ice cream truck made.
    Feel free to add more endpoints you consider necessary.
    The quantity and price of each food in the ice cream truck is your choice.
    You'll make a simple test, so I can confirm it works easily.
    Try to build it so it's  scalable, it should be able to support the future, so when the ice cream truck gets famous they can open a franchise and have many ice cream trucks!


    Thanks,
    David

So, I went on to build a Rails API. And this was the outcome.

In order to run it in your environment, you will need the following:
- Ruby 3.0.1
- PostgreSQL
- Running the usual initialization commands such as:

   ```ruby
   bundle install
   rails db:setup
   ```

There are 3 endpoints you can send requests to. Check `/app/controllers/api/v1/products_controller.rb` and `/config/routes.rb` for parameters required, paths, and other details.

Over 100 test examples were written. Run `bundle exec rspec` and look for files under `/spec` for details.
