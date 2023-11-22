class FeriadosController < ApplicationController
    require 'net/http'
    require 'json'
  
    def index
        from_year = 2020
        current_year = Date.today.year
        # entrega un rango desde un año x al año actual a consumir_api, este retorna un arreglo con el resultado
        @feriados = consumir_api(current_year, from_year)
        # render json: @feriados
    end
  
    private
  
    def consumir_api(current_year, from_year)
        feriados = []
        # primero intente iterar desde el año actual hacia atras, pero despues lo cambie
        #   (current_year).downto(from_year) do |year|
        # bucle para iterar desde el año inicial hasta el año actual, por cada iteracion consultare a la api los feriados de ese año
        (from_year).upto(current_year) do |year|
            
            api_url = "https://apis.digital.gob.cl/fl/feriados/#{year}"
            response = Net::HTTP.get(URI(api_url))
            feriados_data = JSON.parse(response)
            # si la respuesta de la api es un array se agrega la respuesta al arreglo de feriados, solo usare el indice fecha y nombre
            if feriados_data.is_a?(Array)
            feriados_data.each do |feriado|
                feriados << { fecha: feriado['fecha'], nombre: feriado['nombre'] }
            end
            else
            puts "Error: feriados_data for #{year} is not an array."
            puts feriados_data.inspect
            end
        end
    
        feriados
    end
end
