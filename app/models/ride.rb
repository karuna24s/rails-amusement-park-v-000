class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    if allowed_to_ride
      can_ride
    elsif !is_tall_enough && has_enough_tickets
      "Sorry. You are not tall enough to ride the #{attraction.name}."
    elsif !has_enough_tickets && is_tall_enough
      "Sorry. You do not have enough tickets the #{attraction.name}."
    else
      "Sorry. You do not have enough tickets the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
    end
  end

  def can_ride
    self.user.update(
    tickets: user.tickets - attraction.tickets,
    happiness: user.happiness + attraction.happiness_rating,
    nausea: user.nausea + attraction.nausea_rating)
    "Thanks for riding the #{attraction.name}!"
  end

  private

  def is_tall_enough
    if user.height >= attraction.min_height
      true
    end
  end

  def has_enough_tickets
    if user.tickets >= attraction.tickets
      true
    end
  end

  def allowed_to_ride
    if is_tall_enough && has_enough_tickets
      true
    end
  end

end
