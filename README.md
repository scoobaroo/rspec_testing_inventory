# <img src="https://cloud.githubusercontent.com/assets/7833470/10899314/63829980-8188-11e5-8cdd-4ded5bcb6e36.png" height="60"> Testing Inventory

**Objective:** Use TDD in Rails to create an inventory management application. Your goal is to write code to pass the tests.

## Getting Started

1. Fork this repo, and clone it into your WDI class folder on your local machine.
2. Run `bundle install` to install gems.
3. Run `rake db:create db:migrate` to create and migrate the database.
4. Start your Rails server.
5. Run `rspec` in the Terminal. You should see an angry error message. Your job is to fix it!

## Part 1: Products

A product represents a kind of item sold. Each of this app's products will store a `name`, a `description`, a `category`, an `sku` (which may contain numbers and letters), and `wholesale` and `retail` prices.  Both prices will be `decimal`s, because Ruby's `BigDecimal` is more precise than a `float`!

#### Goal:  Pass products controller tests.

* The failing specs are for a `ProductsController`. For the first part of this lab, implement the functionality for the `ProductsController` to pass the tests. **Some tips:**
  * Read the errors carefully. They will guide you as to what to do next.
  * Once you've gotten past the initial setup errors, and you have failing specs printing out in the Terminal, it may help to only run specific specs by name using `rspec spec -e '#index'`
* You DON'T need to implement fully-functioning views.
* To pass some of these tests, you'll have to add validations to your model to check that fields are present.  

#### Goal: Write tests for the product model.

* Once you have all the specs passing for the `ProductsController`, it's time to implement unit tests for a product model.

* Generate an rspec model test for the product model by running `rails g rspec:model product`.  Read the log messages carefully and find the file(s) Rails expects you to use for testing.  One of these files is `spec/factories/products.rb`. You'll use the factory in this file with the gems Factory Girl and FFaker to create data for testing.


* The other new file generated for your model tests is in `spec/models`.  In this file, write tests for a product model instance method called `margin`.  The `#margin` method should calculate and return the [retail margin](http://retail.about.com/od/glossary/g/margin.htm) of the product instance.

  * <details><summary>What product to test with?</summary>You can use Factory Girl to create a sample product in the test code. (See the controller code for an example.) Also calculate the product's profit margin (by hand) so you know what you expect the `margin` method to return.</details>

* Write a test to ensure that the `#margin` method returns a `BigDecimal` value.

* Write a test to endure that the `#margin` method returns a correct value.

* Run `rspec spec/models`, and read the output carefully. Fix any errors that are preventing your tests from running.  

* Once you have your model tests running, write code to pass them! Remember to use strong parameters.

Feel free to reference the [solution branch](../../tree/solution) for guidance.

## Part 2: Items

Now, you'll practice TDD more independently.  

A product represents a type of product the site sells.  (You can think of products as tshirts, for example, where users can pick color and size.)  The site allows customization of the the color and size of products, and it would be good to know the status of each particular item in the warehouse (sold/unsold).  For this reason, products should **have many items**. Use TDD to guide your implementation of CRUD for items. That means **write tests first**.

Items should have a minimum of three attributes: `size`, `color`, and `status`. The status will usually be `"sold"` or `"unsold"`.

Note: Items routes should be nested under products routes. See the [Rails docs for nested resources](http://guides.rubyonrails.org/routing.html#nested-resources).



#### Goal: Use test-driven development to implement the items controller.


* Use Rails to generate an `rspec` test file for the item controller. Run `rspec spec/controllers`, and debug any issues that prevent your item controller tests from running (you'll still see your product controller tests passing).

* Follow the examples in `spec/controllers/products_controller_spec.rb` as a guide while you write tests for your `ItemsController`.

* Your `ItemsController` doesn't need an `#index` method, since your app will display all of a product's items on the `products#show` page. However, it should have the other six methods for RESTful routes (`#new`, `#create`, `#show`, `#edit`, `#update`, and `#destroy`).

* As you go, continue to debug any errors that prevent `rspec` from running your tests. Read log and error messages carefully.

* Implement item controller code to pass the tests you wrote.

#### Goal: Use test-driven development to implement the item model.

* Generate test and factory files for the item model.  

* Take advantage of the [`factory_girl_rails`](https://github.com/thoughtbot/factory_girl_rails) and [`ffaker`](https://github.com/ffaker/ffaker) gems to define an `item` factory to use in your model tests.

* One of the new files Rails generates when you create model tests should be a "factory" file that Factory Girl will use to create fake items. Inside, you'll find this code:

  ```ruby
  FactoryGirl.define do
    factory :item do
      size "MyString"
      color "MyString"
      status "MyString"
    end
  end
  ```

  Replace the static strings with FFaker-generated data.
    * Hint: Use Factory Girl's "lazy attributes" to get different attribute values for each product.  

* Use Factory Girl's associations to add a product to your item factory.

*  Write tests to make sure the model validates the `presence` of three attributes: `size`, `color`, and `status`.

* Debug any errors that prevent `rspec` from running your tests. Read log and error messages carefully.

* Run `rspec spec/models`, and implement your item model to pass the tests you wrote.


#### Goal: Update the product model with a new `sell_through` method.

* Making a change while doing TDD for an app? Better write tests first!

* Your goal is to add an instance method to the products model called `sell_through`. The `#sell_through` method should calculate and return a decimal value: the overall sell-through rate for this product (items sold / total items). **Write the spec for `#sell_through`.**

* Once you have the spec written, write code in your product model to pass the test(s) you wrote.



Feel free to reference the [solution_items branch](../../tree/solution-items) for guidance.

## Resources

* [RSpec Rails Docs](https://github.com/rspec/rspec-rails)
* [RSpec Controller Specs](https://www.relishapp.com/rspec/rspec-rails/docs/controller-specs)
* [RSpec Built-In Matchers](https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers)
* [Factory Girl Rails Docs](https://github.com/thoughtbot/factory_girl_rails" target)
* [FFaker Docs](https://github.com/ffaker/ffaker)
* [FFaker Cheatsheet](http://ricostacruz.com/cheatsheets/ffaker.html)
* [Rails Nested Resources](http://guides.rubyonrails.org/routing.html#nested-resources)
