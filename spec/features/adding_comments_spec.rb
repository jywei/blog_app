require "rails_helper"

RSpec.feature "Adding Comments to Articles" do

  before do
    @john = User.create(email: "john@example.com", password: "password")
    @fred = User.create(email: "fred@example.com", password: "password")

    @article = Article.create(title: "The first article", body: "body of first article", user: @john)

  end

  scenario "Permit a signed-in user to write reviews" do
    login_as(@fred)

    visit "/"
    click_link @article.title
    fill_in "New Comment", with: "Some comments"
    click_button "Add Comment"

    expect(page).to have_content("Comment has been created")
    expect(page).to have_content("Some comments")
    expect(current_path).to eq(article_path(@article.comments.last.id))

  end
end
