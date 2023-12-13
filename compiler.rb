require_relative 'tokenizer'
require_relative 'parser'
require_relative 'generator'

tokens = Tokenizer.new(File.read('test.src')).tokenize
# puts tokens.map(&:inspect).join("\n")

tree = Parser.new(tokens).parse
# puts tree

generated = Generator.new.generate(tree)
RUNTIME = 'function add(x, y) { return x + y};'.freeze
TEST = 'console.log(f(1, 2));'.freeze
puts [RUNTIME, generated, TEST].join("\n")
