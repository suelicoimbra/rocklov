#language: pt

Funcionalidade: Receber pedido de locação
    Sendo um anunciante que possui equipamentos cadastrados
    Desejo receber pedidos de locação
    Para que eu possa decidir se quero aprová-los ou rejeitá-los

    Cenário: Receber pedido

        Dado que meu perfil de anunciane é "joao@anunciante.com" e "pwd123"
            E que eu tenho o sequinte equipamento cadastrado
            | thumb     | trompete.jpg |
            | nome      | Trompete     |
            | categoria | Outros       |
            | preco     | 100          |
            E acesso o meu dashboard
        Quando "maria@locataria.com" e "pwd123" solicita a locação desse equipamento
        Então devo ver a seguinte mensagem
            """
            maria@locataria.com deseja alugar o equipamento: Trompete em: DATA ATUAL
            """
            E devo ver os as opções "ACEITAR" e "REJEITAR" no pedido