require_relative 'types'

# Lexer to convert code into tokens
class Tokenizer
  TOKEN_TYPES = [
    [:def, /\bdef\b/],
    [:end, /\bend\b/],
    [:identifier, /\b[a-zA-z]+\b/],
    [:integer, /\b[0-9]+\b/],
    [:oparen, /\(/],
    [:cparen, /\)/],
    [:comma, /,/]
  ].freeze

  def initialize(code)
    @code = code
  end

  def tokenize
    @tokens = []

    until @code.empty?
      @tokens << tokenize_one_token
    end

    @tokens
  end

  def tokenize_one_token
    TOKEN_TYPES.each do |type, re|
      re = /\A(#{re})/
      if @code =~ re
        value = $1
        @code = @code[value.length..-1].strip
        return Token.new(type, value)
      end
    end

    raise "Could not tokenize: #{@code.inspect}"
  end
end
