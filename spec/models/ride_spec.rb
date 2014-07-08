require 'rails_helper'

RSpec.describe Ride, :type => :model do
  before :each do 
    @attraction = Attraction.create(
      :name => "Roller Coaster",
      :tickets => 5,
      :nausea_rating => 2,
      :happiness_rating => 4,
      :min_height => 32
    )
    @user = User.create(
      :name => "Mindy",
      :nausea => 5,
      :happiness => 3,
      :tickets => 4,
      :height => 34
    )
    @ride = Ride.create(user_id: @attraction.id, attraction_id: @user.id)
  end

  it "is valid with a user_id and a attraction_id" do
    expect(@ride).to be_valid
  end

  it "belongs to one attraction" do
    expect(@ride.attraction).to eq(@attraction)
  end

  it "belongs to one user" do
    expect(@ride.user).to eq(@user)
  end

  it "has a method 'take_ride' that accounts for the user not having enough tickets" do
    @ride = Ride.create(:user_id => @user.id, :attraction_id => @attraction.id)
    expect(@ride.take_ride).to eq("Sorry. You do not have enough tickets the #{@attraction.name}.")
    expect(@user.tickets).to eq(4)
    expect(@user.happiness).to eq(3)
    expect(@user.nausea).to eq(5)
  end

  it "has a method 'take_ride' that accounts for the user not being tall enough" do
    @user.update(:height => 30, :tickets => 10)
    @ride = Ride.create(:user_id => @user.id, :attraction_id => @attraction.id)
    expect(@ride.take_ride).to eq("Sorry. You are not tall enough to ride the #{@attraction.name}.")
    expect(@user.tickets).to eq(10)
    expect(@user.happiness).to eq(3)
    expect(@user.nausea).to eq(5)
  end  

  it "has a method 'take_ride' that accounts for the user not being tall enough and not having enough tickets" do
    @user.update(:height => 30)
    @ride = Ride.create(:user_id => @user.id, :attraction_id => @attraction.id)
    expect(@ride.take_ride).to eq("Sorry. You do not have enough tickets the #{@attraction.name}. You are not tall enough to ride the #{@attraction.name}.")
    expect(@user.tickets).to eq(4)
    expect(@user.happiness).to eq(3)
    expect(@user.nausea).to eq(5)
  end

end

