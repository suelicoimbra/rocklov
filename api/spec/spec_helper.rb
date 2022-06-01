require_relative "routes/signup"
require_relative "routes/sessions"
require_relative "routes/equipos"

require_relative "libs/mongo"
require_relative "helpers"

require "digest/md5"

def to_md5(pass)
  return Digest::MD5.hexdigest(pass)
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  #Semente de configuração de cadastro de usuários automaticametne
  config.before(:suite) do
    users = [
      { name: "Sueli Coimbra", email: "scoimbra@hotmail.com", password: to_md5("pwd123") },
      { name: "Tomate", email: "to@mate.com", password: to_md5("pwd123") },
      { name: "Penelope", email: "penelope@gmail.com", password: to_md5("pwd123") },
      { name: "Joe Perry", email: "joe@gmail.com", password: to_md5("pwd123") },
      { name: "Edward Cullen", email: "ed@hotmail.com", password: to_md5("pwd123") },
      { name: "Anderson Silva", email: "spider@uol.com", password: to_md5("pwd123") },
    ]

    #Zerando a base e inserindo os usuários da lista, para obter sucesso na execução dos testes
    MongoDB.new.drop_danger
    MongoDB.new.insert_users(users)
  end
end
