# ActiveAdmin-Workflow

[![Version      ](https://badge.fury.io/rb/active_admin_workflow.svg)](https://badge.fury.io/rb/active_admin_workflow)
[![Build Status](https://travis-ci.org/kwent/active_admin_workflow.svg?branch=master)](https://travis-ci.org/kwent/active_admin_workflow)

This gem provides an easy integration between the awesome [workflow](https://github.com/geekq/workflow) and [active_admin](https://github.com/gregbell/active_admin) gems.

## Features

This gem provides you with a DSL extension to ActiveAdmin that allows you to easily define action item buttons for your resource to transition through your workflow.

* Integration with ActiveAdmin authorization adapater layer - the button won't show if the user isn't authorized
* Provide custom permission to authorize against
* Provide confirmation message to prompt user before performing
* Button only shown if workflow can transition
* Localizable button titles and flash messages
* Pass a block to customize the behavior

## Installation

This gem requires both `active_admin` and `workflow`.  Add the gem to your Gemfile to get started and bundle.

```ruby
gem 'active_admin_workflow'
```

## Usage

You will need to define a workflow in a model, and have that model registered as a resource with ActiveAdmin.

**A basic model**

```
# app/models/post.rb
class Post < ActiveRecord::Base
  include WorkflowActiverecord

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true

  DRAFT = 'draft'
  REVIEWED = 'reviewed'
  PUBLISHED = 'published'

  workflow do
    state DRAFT do
      event :peer_review, transitions_to: REVIEWED
    end
    state REVIEWED do
      event :publish, transitions_to: PUBLISHED
    end
    state PUBLISHED do
      event :archive, transitions_to: ARCHIVED
    end
  end
end
```

**Corresponding ActiveAdmin resource**

```
ActiveAdmin.register Post do

  state_action :peer_review
  state_action :publish

  form do |f|
    f.inputs "Post Details" do
      f.input :title
      f.input :body
    end
    f.actions
  end

end
```

In the above example, the `state_action` method is defined by this gem and provides you with the following functionality:

1. The `:peer_review` is assumed to be an event in your workflow definition on the Post model.
2. Calling `state_action` will add an action item button to your ActiveAdmin resource on the `#show` page, if the user is authorized to perform this action via the ActiveAdmin authorization adapter, and if the resource itself returns true to `#can_peer_review?`, which is provided by default with this event in workflow.
3. Clicking the button will call `#peer_review!` on the resource, and redirect you back to `smart_resource_url`.
4. Fully localizable, provide translations for `"posts.peer_review.label"`for the button title and `"posts.peer_review.flash.success` for the flash message when completed.
5. You can pass a block to customize this behavior.

### Custom Block

```
ActiveAdmin.register Post do

  state_action :peer_review

  # Block to be called when submitted
  state_action :publish do
    PostPublicationService.publish!(resource)
    flash[:notice] = "Post published"
    redirect_to collection_path
  end

end
```

### Custom Permission

```
ActiveAdmin.register Post do

  # by default, permission would be :peer_review
  state_action :peer_review, permission: :read
end
```

### Confirmation

```
ActiveAdmin.register Post do

  # Lookup 'posts.peer_review.prompt'
  state_action :peer_review, confirm: :true

  # Pass proc
  state_action :peer_review, confirm: ->{ I18n.t("posts.peer_review.confirm") }
end
```

### Using without workflow model

If you really want to use without a workflow on your model, you essentially just need to provide the following methods, contining with our `:peer_review` example:

```
class Post < ActiveRecord::Base    
  def can_peer_review?
    author.present? && !published?
  end

  def peer_review!
    self.published_at = Time.now
    save!
  end
end
```

## Credits

Based on the amazing work of @macfanatic: https://github.com/macfanatic/active_admin-state_machine
