require './config/environment'
require 'sinatra/activerecord/rake'

task :send, [:filename, :title, :send_type] do |t, args|
  if args[:send_type] == 'send to everyone'
    confirm_token = rand(36**6).to_s(36)
    STDOUT.puts "🌊🌊🌊"
    STDOUT.puts "Are you absolutely positive you're ready to send this letter? Enter '#{confirm_token}' to cast the bottle into the ocean:"
    STDOUT.puts "🌊🌊🌊"
    input = STDIN.gets.chomp
    raise "Bottle not cast. You entered #{input} instead of #{confirm_token}" unless input == confirm_token
  end

  letter = Letter.new(args[:title], args[:filename])
  Mailer.send(letter, args[:send_type])
  STDOUT.puts "🍾 Bottle cast! Your letter is bobbing away on the tide. 🌊"
end
