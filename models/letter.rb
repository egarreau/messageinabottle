class Letter

  def initialize(title, path)
    @subject = "May I Recommend ☞ #{title}"
    @html = File.read(path)
    @bottle = Mailgun::Client.new(ENV['mg_key'])
  end

  def build
    mailgun_message = Mailgun::BatchMessage.new(@bottle, ENV['mg_domain'])
    mailgun_message.from(ENV['gmail_user'], {'first' => 'Evangeline', 'last' => 'Garreau'})
    mailgun_message.subject(@subject)
    mailgun_message.body_html(@html)
    mailgun_message
  end
end
