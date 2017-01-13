class ArticulosOnlineController < ApplicationController

require 'net/http'
require 'net/https'
def login_der(args_hash)
    uri = URI.parse("http://www.derdistribuciones.com.ar/Verificar_Usuario.aspx")
    uri.query = URI.encode_www_form(argumentos)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri.request_uri)
    http.request(request).body
end

private
def argumentos
{
      "Usuario" => 2419,
      "Clave" => 91431821,
      "Ingresar" => INGRESAR,
}
end


end
