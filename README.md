# Setup

Please make a copy of this repo and complete all 6 challenges below.

This is a standard Rails 7 application, and set up as follows:

- Install Ruby version 3.0.0
- Run `bundle install`
- Run `yarn install`
- Run `rails db:prepare`

Run dev server with `bin/dev`

## Task 1.
See `app/poros/task_1.rb`

Implement the `unique_names` method.


## Task 2.
See `app/poros/task_2.rb`

Implement the `group_by_owners` method.


## Task 3.
Update this `readme.md` file

Select all statements that are correct after the following migration has been executed:
```
class ContactsMigration < ActiveRecord::Migration
  def change
    create table :contacts do |t|
      t.string :name
      t.integer :telephone_number
      t.text :address, null: false
      t.timestamps
    end
  end
end
```

Select all acceptable answers:
- [x] The contacts.name field may be null.
- [x] The contacts table has no index.
- [ ] The table called contacts contains four different data types.
- [ ] The table called contacts contains four different fields.
- [ ] The contacts.address field may be null.


## Task 4.
Update this `readme.md` file

Consider the following controller and view definitions:
```
class RecordsController < ApplicationController
  def update
    @record = Record.find(params[:id])
    @record.update(record_params)
  end
end
```

```
<%= form_for record do |f| %>
  <%= render "form", f: f %>
<% end %>
```

Select the routing statements that can be used to update a record. Select all acceptable answers:
- [ ] write /records/:id', to: 'records#update'
- [x] put /records/:id', to: 'records#update'
- [x] patch '/records/:id', to: 'records#update'
- [x] post '/records/:id', to: 'records#update'
- [x] resource :records, only: [:update]

## Task 5.
See `app/poros/task_5.rb`

Consider that multiple models make use of the polymorphic :notable and move all the related implementation into a concern.


## Task 6.
Extend the application to create `Activities` over multiple steps:

**Step 1**: name [next button]

**Step 2**: address [back and next buttons]

**Step 3**: starts_at, ends_at [back and save buttons]

Update the activity model, controller and views to reflect this functionality.

- Every step should have its own form
- Show `"#{current_step} of 3"`
- The next step only shows when the current step is valid
- Save on step 3 validates the entire model
- Successful `save` on step 3 redirects to `activities#index`
- Should work the same way for `activities#new` and `activities#edit`

See `app/models/activity.rb`, `app/controllers/activities.rb` and `app/views/activities/**`
