require_relative 'config/environment'

class MessageInABottle < Sinatra::Base
  get '/subscribe' do
    erb :subscribe
  end

  get '/unsubscribe' do
    erb :unsubscribe
  end

  post '/create' do
    @email = params['email']
    r= Reader.find_or_create_by(email: @email)
    "Successfully subscribed! #{r.email}"
  end

  post '/delete' do
    @email = params['email']
    Reader.destroy_by(email: @email)
    if Reader.find_by(email: @email)
      "Unsubscribe unsuccessful"
    else
      "Unsubscribe successful!"
    end
  end
end
