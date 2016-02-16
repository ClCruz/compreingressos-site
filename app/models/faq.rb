class Faq < ActiveRecord::Base
  validates_presence_of :titulo, :subtitulo, :texto

  has_many :imagems, :as => :asset, :dependent => :destroy
  
  accepts_nested_attributes_for :imagems, :allow_destroy => true
    
  def to_param
    #retorno = "#{id}-"+titulo.gsub('/','-').gsub(' ','-').gsub('.','+')
    #retorno = retorno.gsub('á','a').gsub('â','a').gsub('ã','a').gsub('à','a')
    #retorno = retorno.gsub('é','e').gsub('ê','e').gsub('í','i').gsub('î','i')
    #retorno = retorno.gsub('ó','o').gsub('ô','o').gsub('õ','o')
    #retorno = retorno.gsub('ú','u').gsub('ç','c')
    #retorno = retorno.gsub('º','').gsub('ª','').gsub('"','').gsub('&','e')
    #retorno = retorno.gsub('?','').gsub('!','')
    retorno = titulo.downcase
    retorno = retorno.gsub('.','').gsub(',','').gsub('º','').gsub('ª','').gsub('"','').gsub('(','').gsub(')','').gsub('#','').gsub("'",'').gsub("’",'').gsub('?','').gsub('!','').gsub(/\r/,'').gsub(/\n/,'-').gsub('/','-').gsub(' ','-').gsub('–','-').gsub('–','-').gsub('&','e').gsub('+','').gsub('“','').gsub('”','')
    retorno = retorno.gsub('á','a').gsub('â','a').gsub('ã','a').gsub('à','a').gsub('é','e').gsub('É','e').gsub('ê','e').gsub('í','i').gsub('î','i').gsub('ï','i').gsub('ó','o').gsub('ô','o').gsub('õ','o').gsub('ú','u').gsub('ç','c').gsub('$','s').gsub('---','-').gsub('--','-')
    retorno = "#{id}-"+retorno
  end
end
