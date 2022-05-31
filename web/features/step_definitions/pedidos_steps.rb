Dado("que meu perfil de anunciane é {string} e {string}") do |email, password|
  @email_anunciante = email
  @pass_anunciante = password
end

Dado("que eu tenho o sequinte equipamento cadastrado") do |table|
  #Pegango o UserId do usuário, enviando o post de login ao serviço da API
  user_id = SessionService.new.get_userId(@email_anunciante, @pass_anunciante)

  #Carregando arquivo
  thumb = File.open(File.join(Dir.pwd, "features/support/fixtures/images", table.rows_hash[:thumb]), "rb")

  #criando um Equipamento, com os dados do Cenários
  @equipo = {
    thumbnail: thumb,
    name: table.rows_hash[:nome],
    category: table.rows_hash[:categoria],
    price: table.rows_hash[:preco],
  }
  # Removendo da base de dados qualquer equipamento similar ao utilizado nos testes
  MongoDB.new.remove_equipo(@equipo[:name], @email_anunciante)

  #Utilizando a API de equipo/POST para criar um equipamento na Base de Dados.
  @equipo_id = EquipoService.new.create(@equipo, user_id).parsed_response["_id"]
end

Dado("acesso o meu dashboard") do
  @login_page.open
  @login_page.with(@email_anunciante, @pass_anunciante)

  #Checkpoint para garantir que o usuário estará no Dashboard após login
  expect(@dash_page.on_dash?).to be true
end

Quando("{string} e {string} solicita a locação desse equipamento") do |email_locatario, pass_locatario|
  user_id = SessionService.new.get_userId(email_locatario, pass_locatario)
  EquipoService.new.bookings(@equipo_id, user_id)
end

Então("devo ver a seguinte mensagem") do |msg|
  expect_msg = msg.gsub("DATA ATUAL", Time.now.strftime("%d/%m/%Y"))

  expect(@dash_page.order).to have_text expect_msg
end

Então("devo ver os as opções {string} e {string} no pedido") do |button_accept, button_reject|
  #expect(page).to have_selector ".notifications button", text: button_accept
  #expect(page).to have_selector ".notifications button", text: button_reject

  expect(@dash_page.order_actions(button_accept)).to be true
  expect(@dash_page.order_actions(button_reject)).to be true
end
