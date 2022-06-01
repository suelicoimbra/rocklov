describe "GET /equipo/{equipo_id}" do
  before(:all) do
    payload = { email: "to@mate.com", password: "pwd123" }

    @user_id = Sessions.new.login(payload).parsed_response["_id"]
  end

  context "CT-API011: Fluxo Principal - Obter um equipamento por id" do
    before(:all) do
      #Preparando ambiente, cadastrando um novo equipamento
      @payload = {
        thumbnail: Helpers::get_thumbnail("sanfona.jpg"),
        name: "Sanfona Lettici",
        category: "Outros",
        price: 1299,
      }

      #Garantindo que o cadastro do equipamento não seja duplicado.
      MongoDB.new.remove_equipo(@payload[:name], @user_id)

      #capturando id do equipamento
      @equipo_id = Equipos.new.create(@payload, @user_id).parsed_response["_id"]

      @result = Equipos.new.find_by_id(@equipo_id, @user_id)
    end

    it "Valida Status Code igual a 200" do
      expect(@result.code).to eql 200
    end

    it "deve retornar o nome do equipamento" do
      expect(@result.parsed_response).to include("name" => @payload[:name])
    end
  end

  context "CT-API012: Fluxo Alternativo - Tentativa em obter um equipamento que não existe" do
    before(:all) do
      @result = Equipos.new.find_by_id(MongoDB.new.get_mongo_id, @user_id)
    end

    it "deve retornar o code 404" do
      expect(@result.code).to eql 404
    end
  end
end

describe "GET /equipos" do
  before(:all) do
    payload = { email: "scoimbra@hotmail.com", password: "pwd123" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response["_id"]
  end

  context "CT-API016: Fluxo Principal - Obter um lista de equipamento" do
    before(:all) do
      payloads = [{
        thumbnail: Helpers::get_thumbnail("sanfona.jpg"),
        name: "Sanfona Lettici",
        category: "Outros",
        price: 499,
      }, {
        thumbnail: Helpers::get_thumbnail("trompete.jpg"),
        name: "Trompete Dourado",
        category: "Outros",
        price: 599,
      }, {
        thumbnail: Helpers::get_thumbnail("slash.jpg"),
        name: "Lets Paul Slash",
        category: "Outros",
        price: 699,
      }]

      payloads.each do |payload|
        #Garantindo que o cadastro do equipamento não seja duplicado.
        MongoDB.new.remove_equipo(payload[:name], @user_id)
        Equipos.new.create(payload, @user_id)
      end

      #Quando faço a requisição  get para retornar a lista de equipamentos
      @result = Equipos.new.list(@user_id)
    end

    it "Valida Status Code igual a 200" do
      expect(@result.code).to eql 200
    end

    it "Deve retornar uma lista de equipamentos" do
      expect(@result.parsed_response).not_to be_empty
    end
  end
end
