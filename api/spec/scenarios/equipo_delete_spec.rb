#encoding: utf-8

describe "DELETE /equipo/{equipo_id}" do
  before(:all) do
    payload = { email: "scoimbra@hotmail.com", password: "pwd123" }

    @user_id = Sessions.new.login(payload).parsed_response["_id"]
  end

  context "CT-API013: Fluxo Principal - Deletar um equipamento por id" do
    before(:all) do
      #Preparando ambiente, cadastrando um novo equipamento
      @payload = {
        thumbnail: Helpers::get_thumbnail("pedais.jpg"),
        name: "Pedaleira dupla",
        category: "Áudio e Tecnologia".force_encoding("ASCII-8BIT"), #modificando o enconding por conta do acento.
        price: 199,
      }

      #Garantindo que o cadastro do equipamento não seja duplicado.
      MongoDB.new.remove_equipo(@payload[:name], @user_id)

      #capturando id do equipamento
      @equipo_id = Equipos.new.create(@payload, @user_id).parsed_response["_id"]

      @result = Equipos.new.delete_by_id(@equipo_id, @user_id)
    end

    it "Valida Status Code igual a 204" do
      expect(@result.code).to eql 204
    end
  end

  context "CT-API014: Fluxo Alternativo - Tentativa em deletar um equipamento que não existe" do
    before(:all) do
      @result = Equipos.new.delete_by_id(MongoDB.new.get_mongo_id, @user_id)
    end

    it "deve retornar o code 204" do
      expect(@result.code).to eql 204
    end
  end
end
