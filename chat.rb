require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_KEY"))

list_of_messages = [ 
  { :role => "system", :content => "Your are a helpful assistant."}
]

#define empty variable
user_request = ""

#print intro
puts
puts "Hello! How can I help you today?"
puts
puts "-"*50
puts

while user_request != "bye"
  #get user request
  user_request = gets.chomp

  #push request to list of messages which is then fed to API
  list_of_messages.push ({:role => "user", :content => user_request.to_s})
  raw_response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: list_of_messages
  }
  )

  #fetch AI message and push it in hash format to list of messages
  next_message = raw_response.fetch("choices").at(0).fetch("message").fetch("content")
  list_of_messages.push({ :role => "assistant", :content => next_message.to_s})

  #print message
  puts next_message
  puts
  puts "-"*50
end  


puts "Goodbye!"






 
 
