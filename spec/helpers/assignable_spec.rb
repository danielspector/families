require 'spec_helper'

describe 'assigning maternal grandparents' do
  let(:maternal_grandmother) {create(:person)}
  let(:maternal_grandfather) {create(:person)}
  let(:mother) {create(:person)}
  let(:grandaughter) {create(:person)}

  before(:each) do
    grandaughter.mother = mother
  end
    
  it "can assign a maternal grandmother" do
    grandaughter.maternal_grandmother = maternal_grandmother
    expect(grandaughter.grandmothers).to include(maternal_grandmother)
  end

  it "can assign a maternal grandfather" do
    grandaughter.maternal_grandfather = maternal_grandfather
    expect(grandaughter.grandfathers).to include(maternal_grandfather)
  end
end

describe 'assigning paternal grandparents' do
  let(:paternal_grandmother) {create(:person)}
  let(:paternal_grandfather) {create(:person)}
  let(:father) {create(:person)}
  let(:grandaughter) {create(:person)}

  before(:each) do
    grandaughter.father = father
  end
    
  it "can assign a paternal grandmother" do
    grandaughter.paternal_grandmother = paternal_grandmother
    expect(grandaughter.grandmothers).to include(paternal_grandmother)
  end

  it "can assign a paternal grandfather" do
    grandaughter.paternal_grandfather = paternal_grandfather
    expect(grandaughter.grandfathers).to include(paternal_grandfather)
  end
end