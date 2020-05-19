class Mailer
  BOTTLE = Mailgun::Client.new(ENV['mg_key'])

  def self.send(letter, recipient)
    if recipient == 'send to everyone'
      progress_bar = ProgressBar.new(Reader.all.length, :bar, :percentage)
      Reader.all.each do |reader|
        if reader.date_last_sent != Date.today && reader.status == 'confirmed'
          letter.add_recipient(:to, reader.email)
          reader.update(date_last_sent: Date.today)
          progress_bar.increment!
        end
      end
    else
      letter.add_recipient(:to, recipient)
    end
    letter.finalize
  end

  def self.request_subscribe(reader)
    BOTTLE.send_message(ENV['mg_domain'], { :from    => ["'Evangeline Garreau' #{ENV['gmail_user']}"],
                                            :to      => reader.email,
                                            :subject => '🌊 Confirm your subscription to May I Recommend',
                                            :html    => "<p>Thank you for subscribing to May I Recommend! <a href='http://mayirecommend.email/confirm-subscribe/#{reader.id}'>Click here to confirm your subscription</a>.</p>" })
  end
end
