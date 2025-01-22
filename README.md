# Little Esty Shop - Final Solo Project

This is a collaborative Ruby on Rails project that allows users and admins to manage items, invoices, and discounts in a simplified e-commerce platform. The application demonstrates key Rails features such as MVC architecture, RESTful routing, Active Record, and thorough test coverage.

## Features

### User-Facing Features
<li>Browse Items: Users can explore available items with details like price and stock.</li>
<li>Invoice Management: Users can view their invoices, with detailed information on purchased items, quantities, and discounts.</li>
<li> Discounts: Discounted prices are automatically applied based on item quantity thresholds.</li>

### Admin Features
<li>Dashboard Overview: Admins can access a dashboard summarizing key business metrics.</li>
<li>Manage Items: Admins can create, update, and deactivate items in the store.</li>
<li>Invoice Management: Admins can view and update the status of invoices.</li>
<li>Discount Management: Admins can define quantity-based discounts for items.</li>

### Technology Stack
<li>Backend: Ruby on Rails</li>
<li>Database: PostgreSQL</li>
<li>Testing: RSpec, Capybara</li>
<li>Other Tools: Active Record, Heroku (deployment)</li>

## ER Diagram
<img width="1253" alt="Screenshot 2024-06-06 at 3 35 04 PM" src="https://github.com/clydeautin/little-shop-completed-as-group/assets/15273149/1385d3d8-d896-4b8f-9b75-53f5ab2320eb">


<hr>

## Setup

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)

## Testing

This project follows Test-Driven Development (TDD) principles, achieving 100% test coverage with over 125 tests. The test suite uses RSpec and Capybara to ensure reliability.

Run the test suite:
`rspec`

## Authors

- Chee Lee [GitHub](https://github.com/cheeleertr)
- Clyde Autin [GitHub](https://github.com/clydeautin)
- James McHugh [GitHub](https://github.com/jdmchugh111)
[Bulk Discounts Project Eval](https://backend.turing.edu/module2/projects/bulk_discounts/)
