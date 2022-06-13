describe "POST /sessions" do
  #Teste de validação de POST /Session com sucesso
  context "CT-API001: Fluxo Principal - Login com sucesso" do
    before(:all) do
      payload = { email: "scoimbra@hotmail.com", password: "pwd123" }

      @result = Sessions.new.login(payload)
    end

    it "Valida Status Code igual a 200" do
      expect(@result.code).to eql 201 # estava 200 (alterei para simular erro)
    end

    it "Valida id do usuário" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  #   examples = [
  #     {
  #       title: "CT-API002: Fluxo alternativo - Senha Incorreta",
  #       payload: { email: "sueli@hotmail.com", password: "123" },
  #       code: 401,
  #       error: "Unauthorized",
  #     },
  #     {
  #       title: "CT-API003: Fluxo alternativo - Email não cadastrado",
  #       payload: { email: "sueli@hotmail.com", password: "123" },
  #       code: 401,
  #       error: "Unauthorized",
  #     },
  #     {
  #       title: "CT-API004: Fluxo alternativo - Campo Email com valor em branco",
  #       payload: { email: "", password: "pwd123" },
  #       code: 412,
  #       error: "required email",
  #     },
  #     {
  #       title: "CT-API005: Fluxo alternativo - Sem informar o campo Email",
  #       payload: { password: "123" },
  #       code: 412,
  #       error: "required email",
  #     },
  #     {
  #       title: "CT-API006: Fluxo alternativo - Campo Senha com  valor em branco",
  #       payload: { email: "scoimbra@hotmail.com", password: "" },
  #       code: 412,
  #       error: "required password",
  #     },
  #     {
  #       title: "CT-API007: Fluxo alternativo - Sem informar o campo Senha",
  #       payload: { email: "scoimbra@hotmail.com" },
  #       code: 412,
  #       error: "required password",
  #     },
  #   ]

  #Criando o array de casos de testes com Fluxo Alternativo
  #A partir do arquivo de YAML de login, logalizado na pasta fixture
  testSuit = Helpers::get_fixture("login")

  testSuit.each do |testCase|
    #Teste de validação de POST /Session dos fluxos alternativos para tentativas de login.
    context "#{testCase[:title]}" do
      before(:all) do
        payload = { email: "scoimbra@hotmail.com", password: "123" }

        @result = Sessions.new.login(testCase[:payload])
      end

      it "Valida Status Code igual a #{testCase[:code]}" do
        expect(@result.code).to eql testCase[:code]
      end

      it "Valida id do usuário" do
        expect(@result.parsed_response["error"]).to eql testCase[:error]
      end
    end
  end
end
