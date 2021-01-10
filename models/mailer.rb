class Mailer
  BOTTLE = Mailgun::Client.new(ENV['mg_key'])

  def self.send(letter, scope)
    if scope == 'send to everyone'
      progress_bar = ProgressBar.new(Reader.all.length, :bar, :percentage)
      Reader.all.each do |reader|
        if reader.date_last_sent != Date.today && reader.status == 'confirmed'
          letter_hash = letter.build(reader.email)
          BOTTLE.send_message(ENV['mg_domain'], letter_hash)
          reader.update(date_last_sent: Date.today)
          progress_bar.increment!
        end
      end
    else
      letter_hash = letter.build(scope)
      BOTTLE.send_message(ENV['mg_domain'], letter_hash)
    end
  end

  def self.request_subscribe(reader)
    BOTTLE.send_message(ENV['mg_domain'], { :from    => ["'Evangeline Garreau' #{ENV['gmail_user']}"],
                                            :to      => reader.email,
                                            :subject => '🌊 Confirm your subscription to Good Question',
                                            :html    => "<p>Thank you for subscribing to Good Question! <a href='http://mayirecommend.email/confirm-subscribe/#{reader.id}'>Click here to confirm your subscription</a>.</p>" })
  end
end
