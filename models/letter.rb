class Letter

  def initialize(title, path)
    @subject = "May I Recommend ☞ #{title}"
    @html = File.read(path)
  end

  def build(recipient)
    {
      :from    => ["'Evangeline Garreau' #{ENV['gmail_user']}"],
      :to      => recipient,
      :subject => @subject,
      :html    => @html
    }
  end

  # currently unused due to the fact that it causes all replies to thread in one email
  def batch
    message = Mailgun::BatchMessage.new(@bottle, ENV['mg_domain'])
    message.from(ENV['gmail_user'], {'first' => 'Evangeline', 'last' => 'Garreau'})
    message.subject(@subject)
    message.body_html(@html)
  end
end
