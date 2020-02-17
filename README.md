# Adopt Don't Shop: Part Two

## Background and Description

"Adopt Don't Shop: Part Two" is a fictitious pet adoption platform where visitors can leave shelter reviews, favorite pets and apply to adopt their newest furry friend. The basic CRUD functionality for pets and shelters was completed as a solo project. The paired extension adds shelter reviews, favorite pets, and adoption functionalities.

This project was completed to achieve the following learning goals:
* Use MVC architecture to organize code effectively and according to standard convention
* Use flash messages to alert users of their actions for adding, updating and deleting resources
* Incorporate POROs to organize code for objects not stored in the database 
* Utilize one-to-many and many-to-many relationships
* Use ActiveRecord for querying the database to calculate, select, filter and order data 
* Implement to RESTful routing
* Use cookies/sessions to create and maintain state

## Use Adopt Don't Shop

### Implementation
#### Access Locally
* Clone this repo with: `git clone git@github.com:mintona/adopt_dont_shop_part_two.git`
* Install Ruby 2.4.1
* Install Rails 5.1.7
* Run `$ bundle install`
* Run `$ bundle update`
* Run `$ rails db:setup`
* Seeds are provided but feel free to add your own!
* Note: This application uses the following gems for testing, which are included in the gemfile:
   * `rspec-rails`
   * `capybara`
   * `shoulda-matchers`
   * `launchy`
   
   
#### Via the Web
[Click Here to Use Adopt Don't Shop](https://ali-and-jordan-adopt-dont-shop.herokuapp.com/)

## Shelter Reviews

Users can share their experiences with a shelter by providing a review. Each review has a title, a rating (out of 5) and a content box, where the visitor inputs their feedback. A user can optionally upload one picture per review. A default photo is used if there is not one uploaded. Reviews can be updated at a later date, however, they are deleted if the shelter they reference is removed from the application. Flash messages are used to alert a user if their review cannot be saved due to an incomplete form and when the review has been successfully saved.

## Favorite a Pet

As users browse the pets available for adoption, they can add a pet to their favorites list. Favorite pets are stored in a session and the number of favorites is tallied in the navigation bar. The full favorites list can be accessed via `/favorites`. Pets can be un-favorited one at a time, or the list can be emptied completely with the click of a button. Flash messages alert the user when a pet has been added or removed from their favorites list.

## Apply for a Pet

After a user has added at least one pet to their favorites, they can apply to adopt one or more pets from their list. When an application has been approved, the pet's status changes from "Available" to "Pending" and no other application can be approved for them unless the approved application is revoked. Users are notified via flash message if they have not filled out the application properly and when their application has been successfully saved.

Application details can be found on an application's show page.

## Testing

Adopt Don't Shop was built using TDD and is fulling tested on both the model and feature level using an [RSpec](https://github.com/rspec/rspec) testing suite with [Capybara](https://github.com/teamcapybara/capybara) for feature testing and [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers) for model testing. Specific emphasis was placed on sad path testing at the feature level. 

## Built With
* Ruby on Rails - web framework
* PostgresQL - database manager
* Heorku - cloud platform for app hosting

## Contributors:
* [Alison Vermeil](https://github.com/mintona)
* [Jordan Holtkamp](https://github.com/jordanholtkamp)
