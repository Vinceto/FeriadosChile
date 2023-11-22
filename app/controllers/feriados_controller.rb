class FeriadosController < ApplicationController
    require 'net/http'
    require 'json'
  
    def index
      from_year = 2020
      current_year = Date.today.year
  
      @feriados = consumir_api(current_year, from_year)
      # render json: @feriados
    end
  
    private
  
    def consumir_api(current_year, from_year)
        feriados = []
        #   (current_year).downto(from_year) do |year|
        (from_year).upto(current_year) do |year|
            
            api_url = "https://apis.digital.gob.cl/fl/feriados/#{year}"
            response = Net::HTTP.get(URI(api_url))
            feriados_data = JSON.parse(response)
    
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
