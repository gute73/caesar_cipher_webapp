require 'sinatra'
require 'sinatra/reloader' if development?

def shift(char_value, shift_factor, char_min, char_max)
	shifted_char = char_value + shift_factor
	if (shifted_char > char_max)
		shifted_char = shifted_char - char_max + char_min - 1
	elsif (shifted_char < char_min)
		shifted_char = char_max - (char_min - shifted_char) + 1
	end
	shifted_char.chr
end

def caesar_cipher(message, shift_factor)

	new_message = ""

  message.scan(/./) do |character|
  	char_ascii = character.ord
  	if (char_ascii >= 48 && char_ascii <= 57)
  		new_message += shift(char_ascii, shift_factor, 48, 57)
  	elsif (char_ascii >= 65 && char_ascii <= 90)
  		new_message += shift(char_ascii, shift_factor, 65, 90)
  	elsif (char_ascii >= 97 && char_ascii <= 122)
  		new_message += shift(char_ascii, shift_factor, 97, 122)
  	else
  		new_message += char_ascii.chr
  	end
  end

  new_message
end



get '/' do
	encrypted_message = caesar_cipher(params['message'].to_s, params['shift_factor'].to_i)
  erb :index, :locals => {:encrypted_message => encrypted_message}
end
