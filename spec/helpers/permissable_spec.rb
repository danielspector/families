require 'spec_helper'
include Permissable

describe Permissable do
  let(:album_marcia) {create(:album, person_id: @marcia.id, family_id: @brady.id)}
  let(:album_carol) {create(:album, person_id: @carol.id, family_id: @brady.id)}
  let(:album_harold) {create(:album, person_id: @harold.id, family_id: @brady.id)}
  let(:album_mike) {create(:album, person_id: @mike.id, family_id: @brady.id)}
  
  before(:each) do
    make_brady_bunch  
  end

  describe "for group checkboxes" do
    it "for siblings" do
      album_marcia.permissions = "1"
      expect(@greg.can_see?(album_marcia)).to eq(true)
      expect(album_marcia.relationships_permitted).to include("brother", "sister")
      expect(album_marcia.all_permitted_members).to include("Greg")
      expect(album_marcia.all_permitted_members).to_not include("Mike")
      expect(@carol.can_see?(album_marcia)).to eq(false)
    end

    it "for parents" do
      album_marcia.permissions = "2"
      expect(@carol.can_see?(album_marcia)).to eq(true)
      expect(album_marcia.relationships_permitted).to include("mother", "father")
      expect(album_marcia.all_permitted_members).to include("Mike")
      expect(album_marcia.all_permitted_members).to_not include("Greg")
      expect(@connie.can_see?(album_marcia)).to eq(false)
    end

    it "for children" do
      album_carol.permissions = "3"
      expect(@marcia.can_see?(album_carol)).to eq(true)
      expect(album_carol.relationships_permitted).to include("son", "daughter")
      expect(album_carol.all_permitted_members).to include("Greg")
      expect(album_carol.all_permitted_members).to_not include("Harold")
      expect(@mike.can_see?(album_carol)).to eq(false)

    end

    it "for grandparents" do
      album_marcia.permissions = "4"
      expect(@harold.can_see?(album_marcia)).to eq(true)
      expect(album_marcia.relationships_permitted).to include("grandmother", "grandfather")
      expect(album_marcia.all_permitted_members).to include("Connie")
      expect(album_marcia.all_permitted_members).to_not include("Mike")
      expect(@greg.can_see?(album_marcia)).to eq(false)

    end

    it "for grandchildren" do
      album_harold.permissions = "5"
      expect(@marcia.can_see?(album_harold)).to eq(true)
      expect(album_harold.relationships_permitted).to include("grandson", "granddaughter")
      expect(album_harold.all_permitted_members).to include("Greg")
      expect(album_harold.all_permitted_members).to_not include("Carol")
      expect(@connie.can_see?(album_harold)).to eq(false)

    end

    it "for parents-in-laws" do
      album_mike.permissions = "7"
      expect(@connie.can_see?(album_mike)).to eq(true)
      expect(album_mike.relationships_permitted).to include("father_in_law", "mother_in_law")
      expect(album_mike.all_permitted_members).to include()
      expect(album_mike.all_permitted_members).to_not include("Marcia")
      expect(@carol.can_see?(album_mike)).to eq(false)
    end

    it "for children-in-laws" do
      album_harold.permissions = "6"
      expect(@mike.can_see?(album_harold)).to eq(true)
      expect(album_harold.relationships_permitted).to include("son_in_law", "daughter_in_law")
      expect(album_harold.all_permitted_members).to_not include("Greg")
      expect(@carol.can_see?(album_harold)).to eq(false)
    end

    it "for spouse" do
      album_carol.permissions = "8"
      expect(@mike.can_see?(album_carol)).to eq(true)
      expect(album_carol.relationships_permitted).to include("husband", "wife")
      expect(album_carol.all_permitted_members).to include("Mike")
      expect(album_carol.all_permitted_members).to_not include("Harold")
      expect(@marcia.can_see?(album_carol)).to eq(false)
    end

    it "for aunts and uncles" do
      album_marcia.permissions = "9"
      expect(@jenny.can_see?(album_marcia)).to eq(true)
      expect(album_marcia.relationships_permitted).to include("uncle", "aunt")
      expect(album_marcia.all_permitted_members).to include("Jon")
      expect(album_marcia.all_permitted_members).to_not include("Mike")
      expect(@harold.can_see?(album_marcia)).to eq(false)
    end

    it "for nieces and nephews" do
      album_carol.permissions = "10"
      expect(@jon_jr.can_see?(album_carol)).to eq(true)
      expect(album_carol.relationships_permitted).to include("niece", "nephew")
      expect(album_carol.all_permitted_members).to include("Jon Jr.")
      expect(album_carol.all_permitted_members).to_not include("Connie")
      expect(@marcia.can_see?(album_carol)).to eq(false)
    end

    it "for cousins" do
      album_marcia.permissions = "11"
      expect(@jon_jr.can_see?(album_marcia)).to eq(true)
      expect(album_marcia.relationships_permitted).to include("cousin")
      expect(album_marcia.all_permitted_members).to include("Jon Jr.")
      expect(album_marcia.all_permitted_members).to_not include("Carol")
      expect(@greg.can_see?(album_marcia)).to eq(false)
    end

    it "for siblings_in_law" do
      album_mike.permissions = "12"
      expect(@jenny.can_see?(album_mike)).to eq(true)
      expect(album_mike.relationships_permitted).to include("brother_in_law", "sister_in_law")
      expect(album_mike.all_permitted_members).to include("Jenny")
      expect(album_mike.all_permitted_members).to_not include("Carol")
      expect(@greg.can_see?(album_mike)).to eq(false)
    end
  end

  describe "for individual checkboxes" do
    it "with one person excluded" do
      album_marcia.permissions = "1 2 4 11 jon5"
      expect(@jon.can_see?(album_marcia)).to eq(true)
      expect(album_marcia.all_permitted_members).to include("Carol")
      expect(album_marcia.all_permitted_members).to_not include("Jenny")
      expect(@jenny.can_see?(album_marcia)).to eq(false)
    end

    it "with one person included" do
      album_marcia.permissions = "connie1"
      expect(@connie.can_see?(album_marcia)).to eq(true)
      expect(album_marcia.relationships_permitted).to be_blank
      expect(@jenny.can_see?(album_marcia)).to eq(false)
    end
  end
end