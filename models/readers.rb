class Reader < ActiveRecord::Base
  def self.emails
    Reader.pluck('email')
  end
end
