require_relative 'config/environment'

class MessageInABottle < Sinatra::Base
  get '/' do
    redirect '/subscribe'
  end

  get '/about' do
    erb :about
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
    redirect "/confirm-subscribe?email=#{r.email}"
  end

  post '/delete' do
    email = params['email']
    Reader.destroy_by(email: email)
    if Reader.find_by(email: email)
      success = false
    else
      success = true
    end
    redirect "/confirm-unsubscribe?success=#{success}"
  end

  get '/confirm-subscribe' do
    erb :confirm_subscribe, locals: {email: params[:email]}
  end

  get '/confirm-unsubscribe' do
    erb :confirm_unsubscribe, locals: {success: params[:success]}
  end
end
