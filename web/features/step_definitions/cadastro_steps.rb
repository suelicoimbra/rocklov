Dado("que acesso a página de cadastro") do
  @signup_page.open
end

Quando("submeto o seguinte formulário de cadastro:") do |table|
  user = table.hashes.first
  # table is a Cucumber::MultilineArgument::DataTable
  MongoDB.new.remove_user(user[:email])

  @signup_page.create(user)
end
