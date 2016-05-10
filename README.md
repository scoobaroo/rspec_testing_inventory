# <img src="https://cloud.githubusercontent.com/assets/7833470/10899314/63829980-8188-11e5-8cdd-4ded5bcb6e36.png" height="60"> Testing Inventory

**Objective:** Use TDD in Rails to create an inventory management application. Your goal is to write code to pass some existing tests, then write and pass tests for other features.

## Getting Started

1. Fork this repo, and clone it into your WDI class folder on your local machine.
2. Run `bundle install` to install gems.
3. Run `rake db:create db:migrate` to create and migrate the database.
4. Start your Rails server.
5. The primary gem you'll use for testing this app is `rspec-rails`. You'll also use `factory_girl_rails` to set up and tear down test data and `ffaker` to create realistic fake data.  Examine your `Gemfile` to make sure these gems are included.
5. Run `rspec` in the Terminal. You should see `0 examples, 0 failures`.
6. Create a new `my-items-intro` branch to start working on, and switch to it.

## Intro: Items TDD

#### Goal: Set up items controller test files.

* Use Rails to generate an rspec controller test file for the items controller: `rails g rspec:controller items`. Read the Terminal output, and open the new file that was created.

* This spec file references the `ItemsController`, which isn't set up yet. Run `rspec` now to see the error `uninitialized constant ItemsController (NameError)`.  

* Use Rails to generate an items controller. Read the Terminal output - note that Rails attempted to create the spec file again because `rspec-rails` is included in the project.  

* Run `rspec` to confirm your tests are no longer throwing errors.


#### Goal: Set up item model test files.

* Use Rails to generate rspec model test files for the items model: `rails g rspec:model item`. Note that this command creates two new files. One is a factory, and the other is the `Item` model spec.

* Run `rspec` to see the error `uninitialized constant Item (NameError)`.

* Use Rails to generate an item model.  Items will have three attributes: `color`, `size`, and `status`.  Read the Terminal output to see which files are created. Choose `y` to overwrite the factory file if there is a conflict.

* Run `rspec` to confirm the tests are working. You will see "pending" tests.


#### Goal: Test the `items#show` controller action.

* Add a RESTful route to `config/routes.rb` that will trigger the items controller's `show` action.  To follow Rails conventions, make it a named route with the name or "prefix" `item`. Run `rake routes`.

  <details>
    <summary>click to see route syntax</summary>
    `get '/items/:id' => 'items#show', as: :item`
  </details>

* In your items controller spec file, add this section to test the `items#show` controller action:

  ```ruby
  # spec/controllers/items_controller_spec.rb
  RSpec.describe ItemsController, type: :controller do
    describe "#show" do
      it "renders the :show view" do
        item = Item.create({size:'s', color:'blue', status:'unsold'})
        get :show, id: item.id
        expect(response).to render_template(:show)
      end
    end
  end
  ```

* Discuss with a partner what each line in the test above does.  Refer to the `rspec-rails` [controller spec docs](https://www.relishapp.com/rspec/rspec-rails/docs/controller-specs).

  <details>
    <summary>click for solution</summary>
    ```ruby
    # spec/controllers/items_controller_spec.rb

    # set up controller tests for the ItemsController
    RSpec.describe ItemsController, type: :controller do  
      # set up tests for the show action, specifically
      describe "#show" do  
        # say how to test one goal of the show action
        it "renders the :show view" do  
          item = Item.create({size:'s', color:'blue', status:'unsold'}) # create test item
          get :show, id: item.id  # make a get request to /items/:id
          expect(response).to render_template(:show)  # test that response renders show view
        end
      end
    end
    ```
  </details>

* This test will require a `show` method in the items controller, and a `show` view for items. Add an empty `show` method to the items controller, and create an `app/views/items/show.html.erb` file if you don't have one yet.

* Run `rspec spec/controllers` and verify that your test passes.

* The `show` method should look up the item to display and assign an `@item` instance variable to be used in the view. Add a second test inside the  `describe #show` block:

  ```ruby
  it "assigns @item" do
    item = Item.create({size:'s', color:'blue', status:'unsold'})
    get :show, id: item.id  
    expect(assigns(:item)).to eq(item)
  end
  ```

* This isn't looking very DRY!  Use the `rspec-rails` [`let!`](https://www.relishapp.com/rspec/rspec-core/v/2-5/docs/helper-methods/let-and-let) helper method to assign the `item` at the beginning of the `describe #show` block:

  ```ruby
  describe "#show" do
    let(:item) { Item.create({size:'s', color:'blue', status:'unsold'}) }

    it "renders the :show view" do
      get :show, id: item.id
      expect(response).to render_template(:show)
    end

    it "assigns @item" do
      get :show, id: item.id
      expect(assigns(:item)).to eq(item)
    end
  end
  ```


* To DRY up the tests further, use the `rspec-rails` [`before(:each)` hook](https://www.relishapp.com/rspec/rspec-core/docs/hooks/before-and-after-hooks) (method) to make a get request before each of the `#show` tests are run:

  ```ruby
  describe "#show" do
    let(:item) { Item.create({size:'s', color:'blue', status:'unsold'}) }

    before(:each) do # same as `before do`
      get :show, id: item.id  
    end

    it "renders the :show view" do
      expect(response).to render_template(:show)
    end

    it "assigns @item" do
      expect(assigns(:item)).to eq(item)
    end
  end
  ```

* Run `rspec spec/controllers`, and write code to pass your tests.

#### Goal: Test the `items#create` controller action.

* Make the route in `config/routes.rb` that will route to the `items#create` action. Also make a route for the `items#new` action, since that's the action that will eventually serve a form and lead to the `create` route.

  <details>
    <summary>click to see routes after this step</summary>
    ```ruby
    get '/items/new' => 'items#new', as: :new_item
    post '/items' => 'items#create'
    get '/items/:id' => 'items#show', as: :item
    ```
  </details>

* Create skeleton (empty) methods in the items controller for the `new` and `create` actions.

* Make a new block in the items controller test file (`spec/controllers/items_controller_spec.rb`) to `describe` the `#create` action.  

* For this action, you'll test two different contexts: successful creates and validation failures. Add two `context` blocks inside the `describe #create` block.

  <details>
  <summary>click to see what the `describe #create` block should look like now</summary>
  ```ruby
  # spec/controllers/items_controller_spec.rb
  # after the `describe #show block`
  describe "#create" do
    context "success" do
    end

    context "failed validations" do
    end
  end
  ```
  </details>

* Inside the "success" context, use `let` to set up a hash of valid item data. Then use `before(:each)` to make a `post` request to the `create` action with item data `item_hash`:

  ```ruby
  context "success" do
    let(:item_hash) { { size: "XL", color: "heather", status: "sold" } }
    before(:each) do
      post :create, item: item_hash
    end
  end
  ```

* If the create is successful, the `create` action should redirect to the show page for the new item (redirects have an HTTP status of 302). Add the following test after the `before(:each)` block ends:

  ```ruby
  it "redirects to 'item_path'" do
    expect(response.status).to be(302)
    expect(response.location).to match(/\/items\/\d+/)
  end
  ```

* The `create` method should add the new item to the database. Add another test to the success context that checks whether the number of items in the database increases when you give the `create` controller action the valid data.

  * **Hint**: Compare the `Item.count` before and after the request is made to create the new item.
  * **Hint**: Use `rspec-rails` [equality matchers](https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers/equality-matchers) to check whether expected and actual values are the same.

  <details>
    <summary>click for solution</summary>

    ```ruby
    context "success" do
      let(:item_hash) { { size: "XL", color: "heather", status: "sold" } }
      let(:items_count) { Item.count }

      before(:each) do
        post :create, item: item_hash
      end

      # ...

      it "adds an item to the database" do
        expect(Item.count).to eq(items_count + 1)
      end
    end
    ```
  </details>

* Your item model will eventually require that each item have a `status`.  One way the `create` method could fail is to if someone tried to create an item with a `nil` status.  Inside the "failed validations" context block, use `let` to set up an item data hash with a `nil` status.

* Also in the failed validations context, use `before(:each)` (or just `before`) to make a post request to the create action with your invalid item hash as data.

* If the item fails validations, the controller should redirect back to the form (on the new item path). Inside the "failed validations" context, add a test to check that it `"redirects to 'new_item_path'"` with a response of 302.

  <details>
    <summary>click to see what the failed validations context should look like after the last 3 steps</summary>

    ```ruby
    context "failed validations" do
      # set up item data without a status to cause validation failure
      let(:item_hash) { { size: "S", color: "sage", status: nil } }

      before do
        post :create, item: item_hash
      end

      it "redirects to 'new_item_path'" do
        expect(response.status).to be(302)
        expect(response).to redirect_to(new_item_path)
      end
    end
    ```
  <details>


* If the item fails validations, the controller should add an error message to the flash hash. Add the following test:

  ```ruby
  context "failed validations" do
    # ...
    it "adds a flash error message" do
      expect(flash[:error]).to be_present
    end
  end
  ```

#### Goal: Pass the controller tests!

* Run `rspec spec/controllers`, and fill in the `show` and `create` actions pass your tests. (You'll need to add a validation to the item model to ensure the `status` is present.)


#### Goal: More realistic test data.

* Take a closer look at the item factory file that Rails generated for you when you generated the model test: `spec/factories/items.rb`. Factory Girl is a gem that will set up and tear down instances of test data for your app. The current code sets up a factory to create and destroy `item` instances. It should look like this:

  ```ruby
  # spec/factories/items.rb
  FactoryGirl.define do
    factory :item do
      color "MyString"
      size "MyString"
      status "MyString"
    end
  end
  ```

* Every time you use the factory above to create an item, you'll get an item with color, size, and status all equal to `"MyString"`.  Replace these values with different ones to change the items Factory Girl will create; for example:

  ```ruby
  # spec/factories/items.rb
  FactoryGirl.define do
    factory :item do
      color "cerulean"
      size "M"
      status "sold"
    end
  end
  ```

* It can be a benefit to test with data that is more realistic, and randomized test data can help ensure you're not accidentally coding a solution that's too narrow.

* Use Factory Girl's "[lazy attributes](https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md#lazy-attributes)" and the Ruby array method [`sample`](http://ruby-doc.org/core-2.2.0/Array.html#method-i-sample) to make the factory randomly assign either `"sold"` or `"unsold"` as the status of each item it creates.

  <details>
    <summary>click for solution</summary>
    `status { ["sold", "unsold"].sample }`
  </details>

* Use Factory Girl's lazy attributes and FFaker's [`Color` module](https://github.com/ffaker/ffaker/blob/master/REFERENCE.md#ffakercolor) to make the factory assign a random color to each item.

  <details>
    <summary>click for solution</summary>
    `color { FFaker::Color.name }`
  </details>


Feel free to check your work against the [solution-items-intro branch](../../tree/solution-items-intro).


## Part 1: Products

A product represents a kind of item sold by this app. Each of this app's products will store a `name`, a `description`, a `category`, a `sku` number (which may contain numbers and letters), and `wholesale` and `retail` prices.  Both prices will be `decimal`s, because Ruby's `BigDecimal` is more precise than a `float`!

1. Commit your work on your branch.  
2. Check out the `products-start` branch.
3. Create and switch to a new `my-work` branch.

Reference the [solution-products branch](../../tree/solution-products) for guidance if you get stuck during this part of the lab.


#### Goal:  Pass products controller tests.

* The failing specs are for a `ProductsController`. Implement the functionality for the `ProductsController` to pass the tests. **Some tips:**
  * Read the errors carefully. They will guide you as to what to do next.
  * Once you've gotten past the initial setup errors, and you have failing specs printing out in the Terminal, it may help to only run specific specs by name using `rspec spec -e '#index'`
* You DON'T need to implement fully-functioning views.
* To pass some of these tests, you'll have to add model validations to check that fields are present.  
* Remember to use [strong parameters](http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters) in your controller.

#### Goal: Write tests for the product model.

* Once you have all the specs passing for the `ProductsController`, it's time to implement unit tests for a product model.

* Generate an rspec model test for the product model by running `rails g rspec:model product`.  Read the log messages carefully and find the file(s) Rails expects you to use for testing.  One of these files is `spec/factories/products.rb`. Do not overwrite this file! You'll use the factory in this file, with the gems Factory Girl and FFaker, to create data for testing.

* The other new file generated for your model tests is in `spec/models`.  In this file, write tests for a product model instance method called `margin`.  The `#margin` method should calculate and return the [retail margin](http://retail.about.com/od/glossary/g/margin.htm) of the product instance. The retail margin is the retail price minus the wholesale price, divided by the retail price and expressed as a percentage.

  * <details><summary>What product to test with?</summary>You can use Factory Girl to `create` a sample product in the test code. (See the controller code for an example.) Also calculate the product's profit margin (by hand) so you know what you expect the `margin` method to return.</details>

* Write a test to ensure that the `#margin` method returns a `BigDecimal` value.

* Write a test to endure that the `#margin` method returns a correct value for some example product.

* Run `rspec spec/models`, and read the output carefully. Fix any errors that are preventing your tests from running.  

* Once you have your model tests running, write code to pass them!


## Part 2: Nested Items

Now, you'll practice TDD more independently.  

A product represents a type of product the site sells.  (You can think of products as tshirts, for example.)  The site allows customization of the the color and size of products, and it would be good to know the status of each particular item in the warehouse (sold/unsold).  For this reason, products should **have many items**. Use TDD to guide your implementation of CRUD for items. That means **write tests first**.

Your items should be set up to have a minimum of three attributes: `size`, `color`, and `status`. The status will usually be `"sold"` or `"unsold"`.

Note: Items routes should be nested under products routes. See the [Rails docs for nested resources](http://guides.rubyonrails.org/routing.html#nested-resources).

Reference the [solution-nested-items branch](../../tree/solution-nested-items) for guidance if you get stuck during this part of the lab.

#### Goal: Set up factory for the item model.

* Generate test and factory files for the item model, if you don't have them yet. Generate the item model, if you don't have one yet.

* Take advantage of the [`factory_girl_rails`](https://github.com/thoughtbot/factory_girl_rails) and [`ffaker`](https://github.com/ffaker/ffaker) gems to define an `item` factory to use in your model tests.

* Use Factory Girl's associations to add a product to your item factory, and refactor your controller code.


#### Goal: Use test-driven development to implement the items controller.


* If you don't have one yet, use Rails to generate an `rspec` test file for the item controller. Run `rspec spec/controllers`, and debug any issues that prevent your item controller tests from running (you'll still see your product controller tests passing).

* Follow the examples in `spec/controllers/products_controller_spec.rb` as a guide while you write tests for your `ItemsController`.

* Your `ItemsController` doesn't need an `#index` method, since your app will display all of a product's items on the `products#show` page. However, it should have the other six methods for RESTful routes (`#new`, `#create`, `#show`, `#edit`, `#update`, and `#destroy`).

* Your tests should check that the appropriate controller actions display flash error messages when the model fails to validate the `presence` of the `status` attribute.

* As you go, continue to debug any errors that prevent `rspec` from running your tests. Read log and error messages carefully.

* Implement item controller code to pass the tests you wrote.

#### Goal: Update the product model with a new `sell_through` method.

* Making a change while doing TDD for an app? Better write tests first!

* Your goal is to add an instance method to the products model called `sell_through`. The `#sell_through` method should calculate and return a decimal value: the overall sell-through rate for this product (items sold / total items). **Write the spec for `#sell_through`.**

* Once you have the spec written, write code in your product model to pass the test(s) you wrote.

## Part 3: Code Cleanup

Reference the [solution-nested-items branch](../../tree/solution-nested-items) for guidance if you get stuck during this part of the lab.

####Goal: Strong params for security and prosperity!

* If you haven't yet, use Rails strong parameters for your items and products controllers.
* In your products controller, define a private `product_params` method that implements strong parameters (look this up if you need to)!  Refactor your controller actions to use the new `product_params` method.

* In your items controller, define a private `item_params` method that implements strong parameters (look this up if you need to)!  Refactor your controller actions to use the new `item_params` method.

####Goal: DRYify item and product lookup.

* Many routes in the products controller look up a product by id.  Define a private `set_product` method in the products controller that assigns the `@product` variable based on the id parameter.

* Refactor your controller actions to use the `set_product` method before the other methods that find the product. Hint: look up `before_filter`.

* Similarly, many routes in the items controller look up a product and/or item. Create `set_product` and `set_item` methods in your items controller, and use `before_filter`s to apply them to the appropriate actions.

## Resources

* [RSpec Rails Docs](https://github.com/rspec/rspec-rails)
* [RSpec Controller Specs](https://www.relishapp.com/rspec/rspec-rails/docs/controller-specs)
* [RSpec Built-In Matchers](https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers)
* [Factory Girl Rails Docs](https://github.com/thoughtbot/factory_girl_rails" target)
* [FFaker Docs](https://github.com/ffaker/ffaker)
* [FFaker Cheatsheet](http://ricostacruz.com/cheatsheets/ffaker.html)
* [Rails Nested Resources](http://guides.rubyonrails.org/routing.html#nested-resources)
