# Adopt Don't Shop
BE Mod 2 Week 1 Solo Project

## Learning Goals

### Rails

* Implement CRUD functionality for a resource using forms (form_tag), buttons, and links
* Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Create routes for
  - standalone resources
  - nested resources
* Template a view in Rails using a templating language (eg, `erb`)
* Implement CRUD functionality for nested resources

### ActiveRecord

* Create instance methods on a Rails model that use ActiveRecord associations
* Use built-in ActiveRecord methods to:
* create, read, update, and destroy records in a database
* create records with relationships to other records in a database

### Databases

* Describe Database Relationships, including the following terms:
* Primary Key
* Foreign Key
* One to Many
* Write migrations to create tables and relationships between tables
* Describe ORMs and their advantages and use cases

### Testing and Debugging

* Write feature tests utilizing:
* RSpec and Capybara
* CSS selectors to target specific areas of a page
* Use Pry or Byebug in Rails files to get more information about an error
* Use `save_and_open_page` to view the HTML generated when visiting a path in a feature test
* Utilize the Rails console as a tool to get more information about the current state of a development database
* Use `rails routes` to get additional information about the routes that exist in a Rails application

### Styling

* Create basic Web Pages using the following tags
* `<h1>`, `<h2>`, etc.
* `<p>`
* `<body>`
* `<a>` and the `href` attribute
* `<img>` and the `src` attribute
* `<div>`
* `<section>`
* `<ul>`, `<ol>`, and `<li>`
* `<form>`
* `<input>`
* Select HTML elements using classes and ids

### Web Applications

* Describe the HTTP request/response cycle
* Describe the different parts of HTTP requests and responses

## Requirements

- must use Rails 5.1.x
- must use PostgreSQL
- must "handroll" all routes (no use of `resources` syntax)
- must use `form_tag` for all forms (no use of `form_for`)

## Permitted

- use FactoryBot to speed up your test development
- use "rails generators" to speed up your app development

## Not Permitted

- do not use JavaScript for pagination or sorting controls

## Permission

- if there is a specific gem you'd like to use in the project, please get permission from your instructors firs

## Rubric


| | **Feature Completeness** | **Rails** | **ActiveRecord** | **Testing and Debugging** | **Styling, UI/UX** |
| --- | --- | --- | --- | --- | --- |
| **4: Exceptional**  | All User Stories 100% complete including edge cases, and at least one extension story completed | Students implement strategies not discussed in class to effectively organize code using POROs and adhere to MVC | Highly effective and efficient use of ActiveRecord beyond what we've taught in class. Even `.each` calls will not cause additional database lookups. | Very clear Test Driven Development. Test files are extremely well organized and nested. Students utilize `before :each` blocks. 100% coverage for features and models | Extremely well styled and purposeful layout. Excellent color scheme and font usage. All other rubric categories score 3 or 4. |
| **3: Passing** | Students complete all User Stories. No more than 2 Stories fail to correctly implement functionality. | Students use the principles of MVC to effectively organize code. Students can defend any of their design decisions. | ActiveRecord is used in a clear and effective way to read/write data using no Ruby to process data. | 100% coverage for models. 98% coverage for features. Tests are well written and meaningful. | Purposeful styling pattern and layout using `application.html.erb`. Links or buttons to reach all areas of the site. |
| **2: Passing with Concerns** | Students complete all but 3-5 User Stories | Students utilize MVC to organize code, but cannot defend some of their design decisions. | Ruby is used to process data that could use ActiveRecord instead. | Feature test coverage between 90% and 98%, or model test coverage below 100%, or tests are not meaningfully written or have an unclear objective. | Styling is poor or incomplete. Incomplete navigation for some routes, i.e. users must manually type URLs. |
| **1: Failing** | Students fail to complete 6 or more User Stories | Students do not effectively organize code| Ruby is used to process data more often than ActiveRecord | Below 90% coverage for either features or models. | No styling or no buttons or links to navigate the site. |


---

## User Stories

```
[x] done

User Story 1, Deploy your application to Heroku

As a visitor or user of the site
I will perform all user stories
By visiting the application on Heroku.
Localhost is fine for development, but
the application must be hosted on Heroku.
```

## Shelters
Shelters are organizations that have pets available for adoption.

```
[x] done

User Story 2, Shelter Index

As a visitor
When I visit '/shelters'
Then I see the name of each shelter in the system
```

```
[x] done

User Story 3, Shelter Show

As a visitor
When I visit '/shelters/:id'
Then I see the shelter with that id including the shelter's:
- name
- address
- city
- state
- zip
```

```
[x] done

User Story 4, Shelter Creation

As a visitor
When I visit the Shelter Index page
Then I see a link to create a new Shelter
When I click this link
Then I am taken to '/shelters/new' where I  see a form for a new shelter
When I fill out the form with a new shelter's:
- name
- address
- city
- state
- zip
And I click the button to submit the form
Then a `POST` request is sent to '/shelters',
a new shelter is created,
and I am redirected to the Shelter Index page where I see the new Shelter listed.
```

```
[x] done

User Story 5, Shelter Update

As a visitor
When I visit a shelter show page
Then I see a link to update the shelter
When I click the link
Then I am taken to '/shelters/:id/edit' where I  see a form to edit the shelter's data including:
- name
- address
- city
- state
- zip
When I fill out the form with updated information
And I click the button to submit the form
Then a `PATCH` request is sent to '/shelters/:id',
the shelter's info is updated,
and I am redirected to the Shelter's Show page where I see the shelter's updated info
```

```
[x] done

User Story 6, Shelter Delete

As a visitor
When I visit a shelter show page
Then I see a link to delete the shelter
When I click the link
Then a 'DELETE' request is sent to '/shelters/:id',
the shelter is deleted,
and I am redirected to the shelter index page where I no longer see this shelter
```

---

## Pets
Pets can be adopted from the Shelter. Pets belong to a shelter.

```
[x] done

User Story 7, Pet Index

As a visitor
When I visit '/pets'
Then I see each Pet in the system including the Pet's:
- image
- name
- approximate age
- sex
- name of the shelter where the pet is currently located
```

```
[x] done

User Story 8, Shelter Pets Index

As a visitor
When I visit '/shelters/:shelter_id/pets'
Then I see each Pet that can be adopted from that Shelter with that shelter_id including the Pet's:
- image
- name
- approximate age
- sex
```

```
[x] done

User Story 9, Pet Show

As a visitor
When I visit '/pets/:id'
Then I see the pet with that id including the pet's:
- image
- name
- description
- approximate age
- sex
- adoptable/pending adoption status
```

```
[x] done

User Story 10, Shelter Pet Creation

As a visitor
When I visit a Shelter Pets Index page
Then I see a link to add a new adoptable pet for that shelter
When I click the link
I am taken to '/shelters/:shelter_id/pets/new' where I see a form to add a new adoptable pet
When I fill in the form with the pet's:
- image
- name
- description
- approximate age
- sex ('female' or 'male')
Then a `POST` request is sent to '/shelters/:shelter_id/pets',
a new pet is created for that shelter,
that pet has a status of 'adoptable',
and I am redirected to the Shelter Pets Index page where I can see the new pet listed
```

```
[x] done

User Story 11, Pet Update

As a visitor
When I visit a Pet Show page
Then I see a link to update that Pet
When I click the link
I am taken to '/pets/:id/edit' where I see a form to edit the pet's data including:
- image
- name
- description
- approximate age
- sex
When I click the button to submit the form
Then a `PATCH` request is sent to '/pets/:id',
the pet's data is updated,
and I am redirected to the Pet Show page where I see the Pet's updated information
```

```
[x] done

User Story 12, Pet Delete

As a visitor
When I visit a pet show page
Then I see a link to delete the pet
When I click the link
Then a 'DELETE' request is sent to '/pets/:id',
the pet is deleted,
and I am redirected to the pet index page where I no longer see this pet
```

---

## Usability
Users should be able to use the site easily. This means making sure there are links/buttons to reach all parts of the site and the styling/layout is sensible.

```
[x] done

User Story 13, Shelter Update From Shelter Index Page

As a visitor
When I visit the shelter index page
Next to every shelter, I see a link to edit that shelter's info
When I click the link
I should be taken to that shelters edit page where I can update its information just like in User Story 5
```

```
[x] done

User Story 14, Shelter Delete From Shelter Index Page

As a visitor
When I visit the shelter index page
Next to every shelter, I see a link to delete that shelter
When I click the link
I am returned to the Shelter Index Page where I no longer see that shelter
```

```
[x] done

User Story 15, Pet Update From Pets Index Page

As a visitor
When I visit the pets index page or a shelter pets index page
Next to every pet, I see a link to edit that pet's info
When I click the link
I should be taken to that pets edit page where I can update its information just like in User Story 11
```
```
[x] done

User Story 16, Pet Delete From Pets Index Page

As a visitor
When I visit the pets index page or a shelter pets index page
Next to every pet, I see a link to delete that pet
When I click the link
I should be taken to the pets index page where I no longer see that pet
```

```
[x] done

User Story 17, Shelter Links

As a visitor
When I click on the name a shelter anywhere on the site
Then that link takes me to that Shelter's show page
```

```
[x] done

User Story 18, Pet Links

As a visitor
When I click on the name a pet anywhere on the site
Then that link takes me to that Pet's show page
```

```
[x] done

User Story 19, Pet Index Link

As a visitor
When I visit any page on the site
Then I see a link at the top of the page that takes me to the Pet Index
```

```
[x] done

User Story 20, Shelter Index Link

As a visitor
When I visit any page on the site
Then I see a link at the top of the page that takes me to the Shelter Index
```

```
[x] done

User Story 21, Shelter Pet Index Link

As a visitor
When I visit a shelter show page ('/shelters/:id')
Then I see a link to take me to that shelter's pets page ('/shelters/:id/pets')
```

```
[x] done

User Story 22, Styling                                                                                                                                                                                                                            

As a visitor
When I visit any page on the site
Then I should see a reasonably well styled page
```

---

## Extensions

```
[x] done

User Story 23, Shelter Pet Count

As a visitor
When I visit a shelter pets index page
I see a count of the number of pets at this shelter                                                                    

```

```
[x] done

User Story 24, Adoptable Pets Display First

As a visitor
When I visit a shelter pets index or a pets index page
I see adoptable pets listed before pets whose adoption status is pending

```

```
[ ] done

User Story 25, Pet Filter by Adoptable Status

As a visitor
When I visit the pets index page or a shelter pets index page
I see a link to show only adoptable pets
I also see a link to show only adoption-pending pets
When I click the link
Then my path is something like '/pets?adoptable=true' or '/pets?adoptable=false' (respectively)
And I see only the pets that are adoptable/pending adoption (respectively).
```


```
[x] done

User Story 26, Change Pet's Adoptable/Pending Adoption Status

As a visitor
When I visit a Pet Show page
Then I see a link to change the pet's adoptable status
Adoptable pets should have the link "Change to Adoption Pending"
Adoption Pending pets should have the link "Change to Adoptable"
When I click the link
Then a 'PATCH' request is sent to '/pets/:id/adoptable' or 'pets/:id/pending' (depending on the link)
and I am redirected to the Pet Show page where I see the pet's status has been changed
```

```
[ ] done

User Story 27, Sort Shelters by number of adoptable pets

As a visitor
When I visit the Shelter Index Page
Then I see a link to sort shelters by the number of adoptable pets they have
When I click on the link
I'm taken back to the Shelters Index Page where I see all of the shelters in order of their count of adoptable pets (highest to lowest)
```

```
[ ] done

User Story 28, Sort Shelters in Alphabetical Order

As a visitor
When I visit the Shelter Index Page
Then I see a link to sort shelters in alphabetical order
When I click on the link
I'm taken back to the Shelters Index Page where I see all of the shelters in alphabetical order
```
