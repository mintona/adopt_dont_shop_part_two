require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit the favorites index page" do
    before(:each) do
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

      @shelter_2 = Shelter.create(name: "Denver Shelter",
                                address: "345 Blake St",
                                city: "Denver",
                                state: "CO",
                                zip: "80220")

      pet_2_image = "https://images.pexels.com/photos/39317/chihuahua-dog-puppy-cute-39317.jpeg"
      pet_2_description = 'I am the cutest puppy ever! I love to be around kids as long as they do not play too "ruff."'
      @pet_2 = Pet.create(image: pet_2_image,
                          name: "Marley",
                          approximate_age: "2",
                          sex: "Female",
                          description: pet_2_description,
                          shelter: @shelter_2)
    end

    it 'if I have no favorited pets it displays a message saying so' do
      visit '/favorites'

      expect(page).to have_content("You haven't added any pets to your Favorite Pets yet.")

      visit "/pets/#{@pet_1.id}"

      click_button 'Add to Favorite Pets'

      visit '/favorites'

      expect(page).to_not have_content("You haven't added any pets to your Favorite Pets yet.")

      click_button 'Remove from Favorite Pets'

      expect(page).to have_content("You haven't added any pets to your Favorite Pets yet.")
    end

    it 'shows all favorited pets' do
      visit '/favorites'

      expect(page).to_not have_content("#{@pet_1.name}")
      expect(page).to_not have_content("#{@pet_2.name}")

      expect(page).to_not have_css("img[src*='#{@pet_1.image}']")
      expect(page).to_not have_css("img[src*='#{@pet_2.image}']")


      visit "/pets/#{@pet_1.id}"

      click_button 'Add to Favorite Pets'

      visit '/favorites'

      within "#pet-#{@pet_1.id}" do
        expect(page).to have_css("img[src*='#{@pet_1.image}']")
        click_link("#{@pet_1.name}")
        expect(current_path).to eq("/pets/#{@pet_1.id}")
      end

      visit "/pets/#{@pet_2.id}"

      click_button 'Add to Favorite Pets'

      visit '/favorites'

      within "#pet-#{@pet_2.id}" do
        expect(page).to have_css("img[src*='#{@pet_2.image}']")
        click_link("#{@pet_2.name}")
        expect(current_path).to eq("/pets/#{@pet_2.id}")
      end

    end

    it "has no section for pets with applications before any applications have been created" do
      visit '/favorites'

      expect(page).to_not have_content("Pets With Applications")
      expect(page).to_not have_css("#pets-with-applications")
    end

    describe "after one or more applications have been created" do
      before(:each) do
        pet_3_image = "https://images.pexels.com/photos/1076758/pexels-photo-1076758.jpeg"
        pet_3_description = "I'm a jelly fish! Watch out, I sting!"
        @pet_3 = Pet.create!(image: pet_3_image,
                            name: "Peanut",
                            approximate_age: "2",
                            sex: "Female",
                            shelter: @shelter_2,
                            description: pet_3_description)

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
        @pet_2.applications << @application
      end

      it "I see a section that lists all pets with at least one application" do
        visit '/favorites'

        within '#pets-with-applications' do
          within "#pet-app-#{@pet_1.id}" do
            expect(page).to have_content(@pet_1.name)
          end

          within "#pet-app-#{@pet_2.id}" do
            expect(page).to have_content(@pet_2.name)
          end

          expect(page).to_not have_content(@pet_3.name)
        end
      end

      it "I can click a pet name to visit the pet show page" do
        visit '/favorites'

        within "#pets-with-applications" do
          click_link "#{@pet_1.name}"
          expect(current_path).to eq("/pets/#{@pet_1.id}")
        end

        visit '/favorites'

        within "#pets-with-applications" do
          click_link "#{@pet_2.name}"
          expect(current_path).to eq("/pets/#{@pet_2.id}")
        end
      end

      describe "When I have approved an application" do
        it "lists all pets that have an approved application on them" do
          visit '/favorites'

          expect(page).to_not have_content("Pets with Approved Applications")
          expect(page).to_not have_css("#approved-pets")

          visit "/applications/#{@application.id}"

          within "#pet-app-#{@pet_1.id}" do
            click_button 'Approve'
          end

          visit "/applications/#{@application.id}"

          within "#pet-app-#{@pet_2.id}" do
            click_button 'Approve'
          end

          visit '/favorites'

          within "#approved-pets" do
            expect(page).to_not have_link("#{@pet_3.name}")
            click_link "#{@pet_1.name}"
          end

          expect(current_path).to eq("/pets/#{@pet_1.id}")

          visit '/favorites'

          within "#approved-pets" do
            click_link "#{@pet_2.name}"
          end

          expect(current_path).to eq("/pets/#{@pet_2.id}")
        end
      end
    end
  end
end
