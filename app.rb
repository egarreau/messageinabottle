require_relative 'config/environment'

class MessageInABottle < Sinatra::Base
  get '/' do
    redirect to('/about')
  end

  get '/subscribe' do
    erb :subscribe
  end

  get '/unsubscribe' do
    erb :unsubscribe
  end

  post '/create' do
    email = params['email']
    r = Reader.find_or_create_by(email: email)
    redirect to("/confirm-subscribe?email=#{r.email}")
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

  get '/about' do
    erb :about
  end

  get '/confirm-subscribe' do
    erb :confirm_subscribe, locals: {email: params[:email]}
  end
end
