describe "POST /signup" do
  context "CT-API008: Fluxo Principal - Cadastro de Novo usuários com Sucesso" do
    before(:all) do
      payload = { name: "Xandy Avião", email: "comandante@xandy.com", password: "pwd123" }
      puts "OBS.: Para garantir que o teste não falhe, fazemos uma 'garantia' para que o usuário não exista na base."
      MongoDB.new.remove_user(payload[:email])

      @result = Signup.new.create(payload)
    end

    it "Valida Status Code igual a 200" do
      expect(@result.code).to eql 200 
    end

    it "Valida id do usuário" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end
#usuario já existe
  context "CT-API00X: Fluxo Principal - Usuario ja existe" do
    before(:all) do
      payload = { name: "Usuario ja existe", email: "usuariocadastrado@gmail.com", password: "pwd123" }
      MongoDB.new.remove_user(payload[:email])

      #e o email desse usuário ja foi cadastrado no sistema
      Signup.new.create(payload)

      #quando faço uma requisição para a rota /signup
      @result = Signup.new.create(payload)
    end

    it "deve retornar 409" do
      #entao deve retornar 409
      expect(@result.code).to eql 409
    end

    it "deve retornar mensagem" do
      expect(@result.parsed_response["error"]).to eql "Email already exists :("
    end 

  end

  #nome é obrigatório
  context "CT-API00X: Fluxo Principal - Nome é obrigatório" do
    before(:all) do
      payload = { name: "", email: "nomeobrigatorio@gmail.com", password: "pwd123" }
  
      #quando faço uma requisição para a rota /signup
      @result = Signup.new.create(payload)
    end

    it "deve retornar 412" do
      #entao deve retornar 412
      expect(@result.code).to eql 412
    end

    it "deve retornar mensagem" do
      expect(@result.parsed_response["error"]).to eql "required name"
    end 

  end

  #email é obrigatório
  context "CT-API00X: Fluxo Principal - Email é obrigatório" do
    before(:all) do
      payload = { name: "email obrigatorio", email: "", password: "pwd123" }
  
      #quando faço uma requisição para a rota /signup
      @result = Signup.new.create(payload)
    end

    it "deve retornar 412" do
      #entao deve retornar 412
      expect(@result.code).to eql 412
    end

    it "deve retornar mensagem" do
      expect(@result.parsed_response["error"]).to eql "required email"
    end 

  end
  #password é obrigatório
  context "CT-API00X: Fluxo Principal - Password é obrigatório" do
    before(:all) do
      payload = { name: "Password obrigatorio", email: "pass@teste.com", password: "" }
  
      #quando faço uma requisição para a rota /signup
      @result = Signup.new.create(payload)
    end

    it "deve retornar 412" do
      #entao deve retornar 412
      expect(@result.code).to eql 412
    end

    it "deve retornar mensagem" do
      expect(@result.parsed_response["error"]).to eql "required password"
    end 

  end

end


