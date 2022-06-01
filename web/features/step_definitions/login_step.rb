Dado("que acesso a página principal") do
  @login_page.open
end

Quando("submeto minhas credenciais com {string} e {string}") do |email, password|
  @login_page.with(email, password)
end

Então('sou redirecionado para o Dashboard após o login') do
 # expect(@dash_page.on_dash?).to be true 
 # estava ocorrendo erro ao acessar pela page ([14816:14956:0526/145554.003:ERROR:gpu_init.cc(481)] Passthrough is not supported, GL is disabled, ANGLE is)
 # por esse motivo coloquei a validação no step de login  
  expect(page.has_css?(".dashboard"))
end