Rails.application.routes.draw do
  get 'feriados/index'
  root 'feriados#index'
end
