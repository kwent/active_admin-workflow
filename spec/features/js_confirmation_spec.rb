require 'spec_helper'

feature "JS Confirmations" do

  given(:admin) { create(:user, super_admin: true) }

  given(:category) { create(:category, num_posts: 0) }
  given(:post) { create(:post, :reviewed, category: category) }
  given(:published_post) { create(:post, :published, category: category) }

  scenario 'accepting JS confirmation performs action', js: true do
    login_and_navigate_to_post admin, post

    message = accept_prompt do
      click_link("Publish Post")
    end

    expect(message).to eq("Do you want to publish now?")
    expect(page).to have_css(".flash.flash_notice", text: "Post successfully published")

    post_expect_have_workflow_state "published"
  end

  scenario 'rejecting JS confirmation skips action', js: true do
    login_and_navigate_to_post admin, post

    message = dismiss_prompt do
      click_link("Publish Post")
    end

    expect(message).to eq("Do you want to publish now?")
    expect(page).to_not have_css(".flash.flash_notice", text: "Post successfully published")

    post_expect_have_workflow_state "reviewed"
  end

  scenario 'JS prompt uses Proc for message', js: true do
    login_and_navigate_to_post admin, published_post

    message = accept_prompt do
      click_link("Archive")
    end

    expect(message).to eq("Do you want to archive?")
    post_expect_have_workflow_state "archived"
  end
end
