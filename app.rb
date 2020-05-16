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

  get '/archive' do
    # archive = Archive.new
    # erb :archive, locals: {archive: archive}
    "render archive here"
  end

  get '/archive/:letter' do
    # letter = something with params[:letter]
    # erb :letter, locals: {letter: letter}
    "render letter here"
  end

  get '/welcome/:id' do
    reader = Reader.find(params[:id])
    reader.update(status: 'confirmed')
    erb :welcome, locals: {email: reader.email}
  end

  get '/confirm-subscribe' do
    erb :confirm_subscribe, locals: {email: params[:email]}
  end

  get '/confirm-unsubscribe' do
    erb :confirm_unsubscribe, locals: {success: params[:success]}
  end

  post '/create' do
    email = params['email']
    r = Reader.find_or_create_by(email: email)
    html = "<p>Thank you for subscribing to May I Recommend! <a href='https://letter-in-a-bottle.herokuapp.com/welcome/#{r.id}'>Click here to confirm your subscription.</a></p>"
    Mailer.send_email(html, '🌊 Confirm your subscription to May I Recommend', r.email)
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
end
