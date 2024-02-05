require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do #dirigier à la page d'acceuil index
    erb :index, locals: {gossips: Gossip.all} #créer une variable local gossips
  end

  get '/gossips/new/' do #diriger à la page de formulaire new_gossip
    erb :new_gossip
  end
  
  post '/gossips/new/' do #récupere les informations du formulaire de la page new_gossip
    Gossip.new(params["gossip_author"],params["gossip_content"]).save #la route post va récupérer depuis le formulaire, le name ="gossip_author" automatiquement et l'injecter dans la création de l'instance 
    # puts params
    redirect '/' #une fois le formulaire soumit redirige à la page index
  end

  # get '/gossips/:id' do
    
  #   # "Voici le numéro du potin que tu veux : #{params['id']}!"
  #   puts "Je rentre dans la page #{params['id']}"
  #   Gossip.find(params['id'])
  # end

  get '/gossips/:id' do #diriger à la page show
    puts "Je rentre dans la page #{params['id']}"
    erb :show, locals: {gossip_author: Gossip.find(params['id'])[0],gossip_content: Gossip.find(params['id'])[1]} #créer une variable local gossips
  end

  

end