# <img src="https://cloud.githubusercontent.com/assets/7833470/10899314/63829980-8188-11e5-8cdd-4ded5bcb6e36.png" height="60"> Testing Inventory

**Objective:** Use TDD in Rails to create an inventory management application. Your goal is to write code to pass the tests.

## Getting Started

1. Fork this repo, and clone it into your `develop` folder on your local machine.
2. Run `bundle install` to install gems.
3. Run `rake db:create db:migrate` to create and migrate the database.
4. Start your Rails server.
5. Run `rspec` in the Terminal. You should see an angry error message. Your job is to fix it!

## Part 1: Products

#### Goal:  Pass products controller tests.

* The failing specs are for a `ProductsController`. For the first part of this lab, implement the functionality for the `ProductsController` to pass the tests. **Some tips:**
  * Read the errors carefully. They will guide you as to what to do next.
  * Once you've gotten past the initial setup errors, and you have failing specs printing out in the Terminal, it may help to only run specific specs by name using `rspec spec -e '#index'`
* You DON'T need to implement fully-functioning views.

#### Goal: Write tests for the product model.

* Once you have all the specs passing for the `ProductsController`, it's time to implement unit tests for a product model. Note that your app doesn't currently have a product model. This is the perfect time to write tests for it!

* Generate an rspec model test for the product model by running `rails g rspec:model product`.  Read the log messages to find the files that Rails created for you.  

* One of the new files should be a "factory" file that FactoryGirl will use to create fake products. Inside, you'll find this code:

    ```
    factory :product do
      name "MyString"
      sku "MyString"
      wholesale "9.99"
      retail "9.99"
      category "MyString"
      description "MyString"
    end
    ```

    Replace the static strings with FFaker-generated data.
      * Hint: Remember that the retail and wholesale prices should be decimals.   
      * Hint: Use Factory Girl's "lazy attributes" to get different attribute values for each product.

* The other new file generated for your model tests is in `spec/models`.  In this file, write tests for a Product model instance method called `margin`.  The `#margin` method should calculate and return the [retail margin](http://retail.about.com/od/glossary/g/margin.htm) of the product instance.

  * <details><summary>What product to test with?</summary>You can use Factory Girl to create a sample product in the test code. Also calculate the product's profit margin (by hand) so you know what you expect the `margin` method to return.</details>
  * Beware of data types. The app is using `BigDecimal` for prices because it stores precise values.

* Run `rspec spec/models`, and read the output carefully. Fix any errors that are preventing your tests from running. **Don't worry about passing the tests yet.**

* Once you have your model tests running, write code to pass them!

<!-- Feel free to reference the [solution branch](../../tree/solution) for guidance. -->

## Part 2: Items

Now, you'll practice TDD more independently.  

Your app will sell socks.  A product represents a design of socks the site sells.  But, the site allows customization of the color and size of socks, and it would be good to know the status of each pair of socks in our warehouse (sold/unsold).  For this reason, products should **have many items**. Each item will represent a specific pair of socks. Use TDD to guide your implementation of CRUD for items. That means **write tests first**.

Don't forget to use Rails to generate `rspec` tests for your model and controller when you're ready to start speccing them out.

* Items routes should be nested under products routes. See the [Rails docs for nested resources](http://guides.rubyonrails.org/routing.html#nested-resources).

#### Goal: Use test-driven development to implement the items controller.

* Follow the examples in `spec/controllers/products_controller_spec.rb` as a guide while you write tests for your `ItemsController`.

* Your `ItemsController` doesn't need an `#index` method, since your app will display all of a product's items on the `products#show` page. However, it should have the other six methods for RESTful routes (`#new`, `#create`, `#show`, `#edit`, `#update`, and `#destroy`).

* Debug any errors that prevent `rspec` from running your tests. Read log and error messages carefully.

* Run `rspec spec/items`, and implement your item controller code to pass the tests you wrote.

#### Goal: Use test-driven development to implement the item model.

* Generate test and factory files for the item model.  Take advantage of the [`factory_girl_rails`](https://github.com/thoughtbot/factory_girl_rails) and [`ffaker`](https://github.com/ffaker/ffaker) gems to define an `item` factory to use in your model tests.

* Items should have a minimum of three attributes: `size`, `color`, and `status`. Write tests to make sure the model validates these three attributes for `presence`.

* Debug any errors that prevent `rspec` from running your tests. Read log and error messages carefully.

* Run `rspec spec/models`, and implement your item model to pass the tests you wrote.


#### Goal: Update the product model with a new `sell_through` method.

* Making a change while doing TDD for an app? Better write tests first!

* Your goal is to add an instance method to the products model called `sell_through`. The `#sell_through` method should calculate and return the overall sell-through rate for this product (items sold / total items). **Write the spec for `#sell_through`.**

* Once you have the spec written, write code in your product model to pass the test(s) you wrote.



<!-- Feel free to reference the [solution_items branch](../../tree/solution_items) for guidance. -->

## Resources

* [RSpec Rails Docs](https://github.com/rspec/rspec-rails)
* [RSpec Controller Specs](https://www.relishapp.com/rspec/rspec-rails/docs/controller-specs)
* [RSpec Built-In Matchers](https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers)
* [Factory Girl Rails Docs](https://github.com/thoughtbot/factory_girl_rails" target)
* [FFaker Docs](https://github.com/ffaker/ffaker)
* [FFaker Cheatsheet](http://ricostacruz.com/cheatsheets/ffaker.html)
* [Rails Nested Resources](http://guides.rubyonrails.org/routing.html#nested-resources)
