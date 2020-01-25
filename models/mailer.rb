class Mailer

  def self.send(filename, subject, send_type)
    html = File.read(filename)
    if send_type == 'send to everyone'
      progress_bar = ProgressBar.new(Reader.all.length, :bar, :percentage)
      Reader.all.each do |reader|
        if reader.email != "" && reader.date_last_sent != Date.today && reader.status == 'confirmed'
          send_email(html, subject, reader.email)
          reader.update(date_last_sent: Date.today)
          progress_bar.increment!
        end
      end
    else
      send_email(html, subject, send_type)
    end

  end

  def self.send_email(html, subject, recipient)
    Pony.mail({
      :to => recipient,
      :from => ENV['gmail_user'],
      :headers => { "From" => "Evangeline Garreau <#{ENV['gmail_user']}>" },
      :subject => subject,
      :html_body => html,
      :via => :smtp,
      :via_options => {
        :address              => 'smtp.gmail.com',
        :port                 => '587',
        :user_name            => ENV['gmail_user'],
        :password             => ENV['gmail_pass'],
        :authentication       => :plain, 
        :domain               => "localhost.localdomain" 
      } 
    })
  end
end
