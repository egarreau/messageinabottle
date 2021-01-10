class Letter

  def initialize(title, path)
    @subject = "#{title}"
    @html = File.read(path)
    # @yaml = YAML.load_file(path)
  end

  def build(recipient)
    {
      :from    => ["'Evangeline Garreau' #{ENV['gmail_user']}"],
      :to      => recipient,
      :subject => "Good Question ✧ #{@subject}",
      :html    => @html
    }
  end

  # currently unused due to troubleshooting issues
  # def build_with_template(recipient)
  #   {
  #     :from    => ["'Evangeline Garreau' #{ENV['gmail_user']}"],
  #     :to      => recipient,
  #     :subject => @subject,
  #     :template => 'newsletter',
  #     ":h:X-Mailgun-Variables" => @yaml
  #   }
  # end

  # currently unused due to the fact that it causes all replies to thread in one email
  # def batch
  #   message = Mailgun::BatchMessage.new(@bottle, ENV['mg_domain'])
  #   message.from(ENV['gmail_user'], {'first' => 'Evangeline', 'last' => 'Garreau'})
  #   message.subject(@subject)
  #   message.body_html(@html)
  # end
end
