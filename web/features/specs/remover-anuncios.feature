#language: pt

Funcionalidade: Remover Anúncios
    Sendo um anunciante que possui um equipamento indesejado
    Quero poder remover esse anúncio
    Para que eu possa manter o meu Dashboard atualizado

    Contexto: Login
        * Login com "spider01@hotmail.com" e "pwd123"

    
    Cenario: Remover um anuncio

        Dado que eu tenho um anuncio indesejado:
            | thumb     | telecaster.jpg |
            | nome      | Telecaster     |
            | categoria | cordas         |
            | preco     | 50             |
        Quando eu solicito a exclusão desse item
            E confirmo a exclusão
        Então não devo ver esse item no meu Dashboard

    @temp
    Cenario: Desistir da exclusão

        Dado que eu tenho um anuncio indesejado:
            | thumb     | telecaster.jpg |
            | nome      | Telecaster     |
            | categoria | cordas         |
            | preco     | 50             |
        Quando eu solicito a exclusão desse item
            E não confirmo a solicitação
        Então esse item deve permanecer no meu Dashboard