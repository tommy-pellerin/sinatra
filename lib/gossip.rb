require 'bundler'
Bundler.require

class Gossip
  attr_accessor :author, :content

  def initialize(auteur,contenu)
    @author = auteur
    @content = contenu
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = [] #on initialise un array vide
    CSV.read("./db/gossip.csv").each do |csv_line|  # va chercher chacune des lignes du csv do
      all_gossips << Gossip.new(csv_line[0], csv_line[1]) # crée un gossip avec les infos de la ligne
    end
    
    return all_gossips #Attention on retourne un array rempli d'objets Gossip, ce sont des objets sous forme #<Gossip:0x00007f221578bb60> qu'il faudra traduire en string
  end

  def self.find(id)
    csv_data = CSV.read("./db/gossip.csv") # créer un tableau avec l'ensemble des données du csv
    return csv_data[id.to_i] #retourne un array ["author","content"]

  end
  # binding.pry
end



