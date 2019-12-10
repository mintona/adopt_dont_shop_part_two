require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe "when I visit an application's show page" do
    before :each do
      @shelter_1 = Shelter.create(name: "Boulder Shelter",
                                  address: "123 Arapahoe Ave",
                                  city: "Boulder",
                                  state: "CO",
                                  zip: "80301")

      pet_1_image = "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg"
      pet_1_description = "I am a loveable, snuggly, cat! If you are anti snuggle, look elsewhere. I want to be pet at all times!"

      @pet_1 = Pet.create(image: pet_1_image,
                          name: "Alex",
                          approximate_age: "10",
                          sex: "Male",
                          description: pet_1_description,
                          shelter: @shelter_1)

      pet_2_image = "https://images.pexels.com/photos/39317/chihuahua-dog-puppy-cute-39317.jpeg"
      pet_2_description = 'I am the cutest puppy ever! I love to be around kids as long as they do not play too "ruff."'
      @pet_2 = Pet.create(image: pet_2_image,
                          name: "Marley",
                          approximate_age: "2",
                          sex: "Female",
                          description: pet_2_description,
                          shelter: @shelter_1)

      pet_3_image = "https://images.pexels.com/photos/1076758/pexels-photo-1076758.jpeg"
      pet_3_description = "I'm a jelly fish! Watch out, I sting!"
      @pet_3 = Pet.create!(image: pet_3_image,
                          name: "Peanut",
                          approximate_age: "2",
                          sex: "Female",
                          description: pet_3_description,
                          shelter: @shelter_1)

      pets = [@pet_1, @pet_2, @pet_3]

      pets.each do |pet|
        visit "/pets/#{pet.id}"
        click_button 'Add to Favorite Pets'
      end

      @application = Application.create!(name: 'Jordan Holtkamp',
                                        address: '123 Main St',
                                        city: 'Lafayette',
                                        state: 'CO',
                                        zip: '80515',
                                        phone: '6102021418',
                                        description: 'I am a great pet dad.')


      @pet_1.applications << @application
      @pet_3.applications << @application
    end

    it "has an approval button next to each pet" do
      visit "/applications/#{@application.id}"

      within "#pet-app-#{@pet_1.id}" do
        expect(page).to have_button('Approve')
      end

      within "#pet-app-#{@pet_3.id}" do
        expect(page).to have_button('Approve')
      end
    end

    describe "I can click a pet's approve button" do
      it "to approve the application for that pet if it has no other approvals" do

        visit "/pets/#{@pet_1.id}"

        expect(page).to_not have_content("Adoption Pending")

        visit "/applications/#{@application.id}"

        within "#pet-app-#{@pet_1.id}" do
          click_button('Approve')
        end

        expect(current_path).to eq("/pets/#{@pet_1.id}")
        expect(page).to have_content("Adoption Pending")
        expect(page).to have_content("On hold for #{@application.name}")
      end

      it "I can still approve other pets on the same application" do
        visit "/applications/#{@application.id}"

        within "#pet-app-#{@pet_1.id}" do
          click_button('Approve')
        end

        visit "/applications/#{@application.id}"

        within "#pet-app-#{@pet_3.id}" do
          click_button('Approve')
        end

        expect(current_path).to eq("/pets/#{@pet_3.id}")
        expect(page).to have_content("Adoption Pending")
        expect(page).to have_content("On hold for #{@application.name}")
      end
    end

    describe "if there is an approved application on the pet" do
      before :each do
        @application_2 = Application.create!(name: 'Ali Vermeil',
          address: '123 South St',
          city: 'Denver',
          state: 'CO',
          zip: '80211',
          phone: '1234567890',
          description: 'I am a great pet pop.')

          @pet_1.applications << @application_2
      end

      it "there is no button to approve another application for that pet" do
        visit "/applications/#{@application.id}"

        within "#pet-app-#{@pet_1.id}" do
          click_button('Approve')
        end

        visit "/applications/#{@application.id}"

        within "#pet-app-#{@pet_1.id}" do
          expect(page).to_not have_button('Approve')
        end

        visit "/applications/#{@application_2.id}"

        within "#pet-app-#{@pet_1.id}" do
          expect(page).to_not have_button('Approve')
        end
      end

      it "applications are still visible on the pets application index page" do
        visit "/pets/#{@pet_1.id}/applications"

        expect(page).to have_link(@application.name)
        expect(page).to have_link(@application_2.name)

        visit "/applications/#{@application.id}"

        within "#pet-app-#{@pet_1.id}" do
          click_button('Approve')
        end

        visit "/pets/#{@pet_1.id}/applications"

        expect(page).to have_link(@application.name)
        expect(page).to have_link(@application_2.name)
      end

      it "I can click a button to unapprove the application for that pet and makes pet adoptable" do
        visit "/applications/#{@application.id}"

        within "#pet-app-#{@pet_1.id}" do
          click_button('Approve')
        end

        visit "/pets/#{@pet_1.id}"

        expect(page).to_not have_content('Adoptable')
        expect(page).to have_content("On hold for #{@application.name}")

        visit "/applications/#{@application.id}"

        within "#pet-app-#{@pet_1.id}" do
          expect(page).to_not have_button('Approve')
          click_button('Unapprove')
        end

        expect(current_path).to eq("/applications/#{@application.id}")

        within "#pet-app-#{@pet_1.id}" do
          expect(page).to have_button('Approve')
        end

        visit "/pets/#{@pet_1.id}"

        expect(page).to have_content('Adoptable')
        expect(page).to_not have_content("On hold for #{@application.name}")
      end
    end
  end
end
