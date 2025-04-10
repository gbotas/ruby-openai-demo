require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

list_of_messages = [ 
  { :role => "system", :content => "You are a helpful assistant."}
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
  
  # exit loop immediately if user types bye

  if user_request == "bye"
    break
  end

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
  puts
  puts next_message
  puts
  puts "-"*50
  puts
  puts "Ask anything..."
  puts
  puts "-"*50
  puts
end  


puts "Goodbye! Let me know if I can help you with something else."






 
 
