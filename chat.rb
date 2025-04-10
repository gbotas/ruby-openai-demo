require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_KEY"))

puts "Hello! How can I help you today?"
puts
puts "-"*50
puts 
request1 = gets.chomp
puts 

list_of_messages = [ 
  { :role => "system", :content => "Your are a helpful assistant."},
  { :role => "user", :content => request1.to_s}
]

raw_response = client.chat(
  parameters: {
    model: "gpt-3.5-turbo",
    messages: list_of_messages
}
)
 
next_message = raw.response.fetch("choices").at(0).fetch("message")
 
puts next_message
