require 'gossip'
require 'comment'

class ApplicationController < Sinatra::Base
  get '/' do #dirigier à la page d'acceuil index
    erb :index, locals: {gossips: Gossip.all} #créer une variable local gossips
  end

  #new page
  get '/gossips/new/' do #diriger à la page de formulaire new_gossip
    erb :new_gossip
  end
  
  post '/gossips/new/' do #récupere les informations du formulaire de la page new_gossip
    Gossip.new(params["gossip_author"],params["gossip_content"]).save #la route post va récupérer depuis le formulaire, le name ="gossip_author" automatiquement et l'injecter dans la création de l'instance 
    # puts params
    redirect '/' #une fois le formulaire soumit redirige à la page index
  end

  #show page + comments
  get '/gossips/:id/' do #diriger à la page show
    puts "Je rentre dans la page show: #{params['id']}"
    erb :show, locals: {gossip_author: Gossip.find(params['id'])[0],gossip_content: Gossip.find(params['id'])[1], comments: Comment.all(params['id'])} #créer une variable local gossips pour afficher les gossips avec la methode find dans la page show
  end

  post '/gossips/:id/' do #récupere les informations du formulaire de la page show
    Comment.new(params["comment_author"],params["comment_content"]).save(params['id']) #la route post va récupérer depuis le formulaire, le name ="gossip_author" automatiquement et l'injecter dans la création de l'instance 
    
    redirect '/gossips/:id/comment_saved/' #une fois le formulaire soumit redirige à la page index
  end
  
  get '/gossips/:id/comment_saved/' do #diriger à la page de confirmation commentaire validé
    redirect '/'
    # erb :comment_saved
  end
  
  #gossip edit page
  get '/gossips/:id/edit/' do #diriger à la page de formulaire edit
    erb :edit_gossip
  end
  
  post '/gossips/:id/edit/' do #récupere les informations du formulaire de la page edit    
    puts "Je rentre dans la page edit: #{params['id']}"
    Gossip.update(params["new_gossip_author"],params["new_gossip_content"],params['id']) #la route post va récupérer depuis le formulaire, le name ="gossip_author" automatiquement et l'injecter dans la création de l'instance 
    redirect '/' #une fois le formulaire soumit redirige à la page index
  end
  
  binding

end