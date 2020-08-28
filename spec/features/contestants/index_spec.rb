require 'rails_helper'

RSpec.describe "When I visit the contestants index page", type: :feature do
  it " I see a list of names of all the contestants AND under each name a list of the projects (names) that they've been on" do

      @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

      @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
      @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")

      @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)

      ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
      ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
      ContestantProject.create(contestant_id: @gretchen.id, project_id: @upholstery_tux.id)

    visit "/contestants"
    expect(page).to have_content("#{@jay.name}")
    expect(page).to have_content("Projects: #{@news_chic.name}")
    expect(page).to have_content("#{@gretchen.name}")
    expect(page).to have_content("Projects: #{@news_chic.name}, #{@upholstery_tux.name}")

  end
end
