class Mailer

  def self.send(filename, subject, send_type)
    if send_type == 'send to everyone'
      progress_bar = ProgressBar.new(Reader.emails.length, :bar, :percentage)
      Reader.emails.each do |email|
        send_email(filename, subject, email)
        progress_bar.increment!
      end
    else
      send_email(filename, subject, ENV['test_email'])
    end

  end

  private

  def self.send_email(filename, subject, recipient)
    Pony.mail({
      :to => recipient,
      :from => ENV['gmail_user'],
      :headers => { "From" => "Evangeline Garreau <#{ENV['gmail_user']}>" },
      :subject => subject,
      :html_body => File.read(filename),
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
