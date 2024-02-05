require 'bundler'
Bundler.require

class Comment
  attr_accessor :author, :content

  def initialize(auteur,contenu)
    @author = auteur
    @content = contenu
  end

  def save(gossip_id)
    new_csv_name = gossip_id.to_s + "_comment"
    CSV.open("./db/#{new_csv_name}.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all(gossip_id)
    new_csv_name = gossip_id.to_s + "_comment"
    file_path = "./db/#{new_csv_name}.csv"

    if File.exist?(file_path)
      all_comments = [] #on initialise un array vide
      CSV.read("./db/#{new_csv_name}.csv").each do |csv_line|  # va chercher chacune des lignes du csv do
        all_comments << Comment.new(csv_line[0], csv_line[1]) # crée un comment avec les infos de la ligne
      end      
      return all_comments #Attention on retourne un array rempli d'objets Comment, ce sont des objets sous forme #<Comment:0x00007f221578bb60> qu'il faudra traduire en string
    
    else 
      
      CSV.open("./db/#{new_csv_name}.csv",'w+')
    end
  end

end