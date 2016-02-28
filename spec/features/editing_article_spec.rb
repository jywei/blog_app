require "rails_helper"

RSpec.feature "Editing an article" do

  before do
    john = User.create!(email: "john@example.com", password: "password")
    login_as(john)
    @article = Article.create(title: "Fist testing article", body: "The body of testing article", user: john)
  end

  scenario "A user updates an article" do
    visit "/"

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: "Update article"
    fill_in "Body", with: "Update body of article"
    click_button "Update Article"

    expect(page).to have_content("Article has been updated")
    expect(current_path).to eq(article_path(@article))
  end

  scenario "A user fails to update an article" do
    visit '/'

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: ""
    fill_in "Body", with: ""
    click_button "Update Article"

    expect(page).to have_content("Article has not been updated")
    expect(current_path).to eq(article_path(@article))
  end
end
