require_relative 'config/environment'

class MessageInABottle < Sinatra::Base

  get '/' do
    redirect to("http://mayirecommend.email/subscribe"), 301
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
    archive = Archive.new
    erb :archive, locals: {archive: archive}
    "render archive here"
  end

  # get '/archive/:letter' do
  #   # letter = something with params[:letter]
  #   # erb :letter, locals: {letter: letter}
  #   "render letter here"
  # end

  post '/create' do
    email = params['email']
    reader = Reader.find_or_create_by(email: email)
    Mailer.request_subscribe(reader)
    redirect "/subscription-pending?email=#{reader.email}"
  end

  get '/subscription-pending' do
    erb :subscription_pending, locals: {email: params[:email]}
  end

  get '/confirm-subscribe/:id' do
    reader = Reader.find(params[:id])
    reader.update(status: 'confirmed')
    redirect "/welcome?email=#{reader.email}"
  end

  get '/welcome' do
    erb :welcome, locals: {email: params[:email]}
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

  get '/confirm-unsubscribe' do
    erb :confirm_unsubscribe, locals: {success: params[:success]}
  end
end
