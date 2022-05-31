describe "POST /equipo/{equipo_id/bookings}" do
  before(:all) do
    payload = { email: "ed@hotmail.com", password: "pwd123" }

    @ed_id = Sessions.new.login(payload).parsed_response["_id"]
  end

  context "CT-API015: Fluxo Principal - Deletar locação de um equipamento por id" do
    before(:all) do
      #DADO  QUE JOE PERRY TEM UM EQUIPAMENTO "FENDER STRATOS" PARA LOCAÇÃO
      #Efetuando o login do JoePerry para pegar o login
      joe_id = Sessions.new.login(email: "joe@gmail.com", password: "pwd123").parsed_response["_id"]
      #Criando Payload do equipamento "Fender Stratos"
      fender = {
        thumbnail: Helpers::get_thumbnail("fender-sb.jpg"),
        name: "Fender Stratos",
        category: "Cordas",
        price: 150,
      }

      #Garantindo que o cadastro do equipamento não seja duplicado.
      MongoDB.new.remove_equipo(fender[:name], joe_id)

      #Criando novo equipamento na base e pegando o Id do equipamento
      fender_id = Equipos.new.create(fender, joe_id).parsed_response["_id"]

      #QUANDO SOLICITO A LOCAÇÂO DA FENDER DE JOE PERRY
      @result = Equipos.new.bookings(fender_id, @ed_id)
    end

    it "Valida Status Code igual a 200" do
      expect(@result.code).to eql 200
    end
  end
end
