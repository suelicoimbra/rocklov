describe "POST /equipo" do
  before(:all) do
    payload = { email: "to@mate.com", password: "pwd123" }

    @user_id = Sessions.new.login(payload).parsed_response["_id"]
  end

  context "CT-API009: Fluxo Principal - Cadastro de um novo equipamento com sucesso" do
    before(:all) do
      payload = {
        thumbnail: Helpers::get_thumbnail("kramer.jpg"),
        name: "Kramer Eddie Van Halen",
        category: "Cordas",
        price: 299,
      }

      MongoDB.new.remove_equipo(payload[:name], @user_id)

      @result = Equipos.new.create(payload, @user_id)
    end

    it "Valida Status Code igual a 200" do
      expect(@result.code).to eql 200
    end
  end

  context "CT-API010: Fluxo Alternativo - Cadastro de um novo equipamento com usuário não Autorizado" do
    before(:all) do
      payload = {
        thumbnail: Helpers::get_thumbnail("baixo.jpg"),
        name: "Contra Baixo",
        category: "Cordas",
        price: 159,
      }

      @result = Equipos.new.create(payload, nil)
    end

    it "Valida Status Code igual a 401" do
      expect(@result.code).to eql 401
    end
  end
end
