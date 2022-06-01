#Criação de um modulo para definir a leitura um arquivo YAML automaticamente
module Helpers
    def get_fixture(item)
      YAML.load(File.read(Dir.pwd + "/spec/fixtures/#{item}.yml"), symbolize_names: true)
    end
  
    def get_thumbnail(file_name)
      return File.open(File.join(Dir.pwd, "spec/fixtures/images", file_name), "rb")
    end
  
    module_function :get_fixture
    module_function :get_thumbnail
  end
  