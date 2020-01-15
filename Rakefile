require './config/environment'
require 'sinatra/activerecord/rake'

task :send, [:filename, :subject, :send_type] do |t, args|
  if args[:send_type] == 'send to everyone'
    confirm_token = rand(36**6).to_s(36)
    STDOUT.puts "🌊🌊🌊"
    STDOUT.puts "Did you allow gmail access? https://accounts.google.com/b/0/DisplayUnlockCaptcha"
    STDOUT.puts "🌊🌊🌊"
    STDOUT.puts "Are you absolutely positive you're ready to send this letter? Enter '#{confirm_token}' to cast the bottle into the ocean:"
    input = STDIN.gets.chomp
    raise "Bottle not cast. You entered #{input} instead of #{confirm_token}" unless input == confirm_token
  end

  Mailer.send(args[:filename], args[:subject], args[:send_type])
  STDOUT.puts "🍾 Bottle cast! Your letter is bobbing away on the tide. 🌊"
end
