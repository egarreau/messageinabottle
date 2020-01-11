class Reader < ActiveRecord::Base
  validates :email, presence: true

  def self.emails
    Reader.pluck('email')
  end
end
