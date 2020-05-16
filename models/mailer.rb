class Mailer

  def self.send(filename, subject, recipient)
    bottle = Mailgun::Client.new(ENV['mg_key'])
    letter = Mailgun::BatchMessage.new(bottle, ENV['mg_domain'])
    letter.from(ENV['gmail_user'], {'first' => 'Evangeline', 'last' => 'Garreau'})
    letter.subject(subject)
    letter.body_html(File.read(filename))

    if recipient == 'send to everyone'
      progress_bar = ProgressBar.new(Reader.all.length, :bar, :percentage)
      Reader.all.each do |reader|
        # if reader.date_last_sent != Date.today && reader.status == 'confirmed'
        #   letter.add_recipient(:to, reader.email)
        #   reader.update(date_last_sent: Date.today)
        #   progress_bar.increment!
        # end
      end
    else
      letter.add_recipient(:to, recipient)
    end
    letter.finalize
  end
end
