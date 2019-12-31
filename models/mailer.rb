class Mailer

  def self.send(filename, subject, send_type)
    if send_type == 'send to everyone'
      recipient = Reader.emails
		else
			recipient = nil
    end

		m = Pony.mail({
      :to => ENV['gmail_user'],
      :bcc => recipient,
      :from => ENV['gmail_user'],
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
    puts m
	end
end
