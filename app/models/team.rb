class Team < ActiveRecord::Base
  has_one :timer

  validates :name, uniqueness: true, presence: true

end
