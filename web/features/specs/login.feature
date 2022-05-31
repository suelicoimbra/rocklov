#language:pt

Funcionalidade: Login
    Sendo um usuário cadastrado
    Quero acessar o sistema da Rocklov
    Para que eu possa anunciar meus equipamentos musicais

    @login
    Cenario: Login do usuário

        Dado que acesso a página principal
        Quando submeto minhas credenciais com "sueli.silvestre01@gmail.com" e "pdw123"
     #   Então sou redirecionado para o Dashboard
        Então sou redirecionado para o Dashboard após o login


    Esquema do Cenario: Tentar Logar
        Dado que acesso a página principal
        Quando submeto minhas credenciais com "<email_input>" e "<senha_input>"
        Então vejo a mensagem de alerta: "<mensagem_output>"

        Exemplos: 
        | email_input                | senha_input | mensagem_output                |
        |sueli.silvestre01@gmail.com |abc123       |Usuário e/ou senha inválidos.   |
        |sueli.silvestre@gmail.com   |pwd123       |Usuário e/ou senha inválidos.   |
        |sueli.silvestre*gmail.com   |pwd123       |Oops. Informe um email válido!  |
        |                            |abc123       |Oops. Informe um email válido!  |
        |sueli.silvestre01@gmail.com |abc123       |Usuário e/ou senha inválidos.   |




        