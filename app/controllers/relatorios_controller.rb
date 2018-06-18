class RelatoriosController < ApplicationController
  before_filter :authorize
  newrelic_ignore
  layout 'compreingressos_antigo'

  def index

  end

  def todos_os_espetaculos
    require 'iconv'
    require 'cgi'
    require 'hpricot'

    # Query do Tarciso antiga
    #@espetaculos = Espetaculo.find_by_sql("SELECT c.estado AS 'estado', c.nome AS 'cidaden', t.nome AS 'teatron', e.nome AS 'espetaculo', g.nome AS 'generon', e.data_inicial AS 'tinicio', e.data_maxima AS 'ttermino', e.sinopse AS 'sinopse' FROM cidades AS c, teatros AS t, espetaculos AS e, generos AS g WHERE e.teatro_id = t.id AND t.cidade_id = c.id AND e.genero_id = g.id AND e.ativo = 1 AND g.id NOT IN (5,40,75) ORDER BY c.estado, c.nome, t.nome, e.nome, g.nome")
    @pagina_especiais = PaginaEspecial.find(:all, :order => :nome)
    @espetaculos = Espetaculo.find(:all,
                                  :select => ["
                                              espetaculos.id AS id,
                                              espetaculos.nome AS espetaculo,
                                              espetaculos.data_inicial AS tinicio,
                                              espetaculos.data_maxima AS ttermino,
                                              espetaculos.sinopse AS sinopse,
                                              espetaculos.ativo AS ativo,
                                              espetaculos.teatro_id AS teatro_id,
                                              teatros.nome AS teatron,
                                              generos.nome AS generon
                                            "],
                                  :joins => [:teatro, :genero],
                                  :include => [:cidade, :pagina_especiais],
                                  :order => "espetaculos.id"
                                  )

    replace_nome = [
        ["\r", ""],
        [" /\n ", " - "],
        [" /\n", " - "],
        ["/\n ", " - "],
        ["/\n", " - "],
        ["\n (", " ("],
        [" \n(", " ("],
        ["\n(", " ("],
        ["\n", " - "],
        ["\t", " "],
        ["<br>", " "],
        ["<br />", " "],
        ["<strong>", ""],
        ["</strong>", ""],
        ["<b>", ""],
        ["</b>", ""],
        ["<i>", ""],
        ["</i>", ""],
        ["<u>", ""],
        ["</u>", ""],
        ["<em>", ""],
        ["</em>", ""],
        ["<p>", ""],
        ["</p>", ""],
        ["<div>", ""],
        ["</div>", ""],
        ["<span>", ""],
        ["</span>", ""],
        ["–", "-"],
        ["&", "e"],
        ["", ""],
        ["", ""],
        ['"', "'"],
        [/<\/?[^>]+>/,'']
    ]

    replace_sinopse = [
        ["\t", ""],
        ['“', '"'],
        ["<br>", " "],
        ["<br/>", " "],
        ["<br />", " "],
        ["<strong>", ""],
        ["</strong>", ""],
        ["<b>", ""],
        ["</b>", ""],
        ["<i>", ""],
        ["</i>", ""],
        ["<u>", ""],
        ["</u>", ""],
        ["<em>", ""],
        ["</em>", ""],
        ["<p>", ""],
        ["</p>", ""],
        ["<div>", ""],
        ["</div>", ""],
        ["<span>", ""],
        ["</span>", ""],
        ["–", "-"],
        ["&", "e"],
        ["", ""],
        ["", ""],
        ['<p class="p1">', ""],
        ['<p class="p2">', ""],
        ['<span lang="PT">', ""],
        ['<span style="white-space: pre;">', ""],
        ['<div class="page" title="Page 1">', ""],
        ['<div class="layoutArea">', ""],
        ['<div class="column">', ""],
        ['"', "'"],
        [/<\/?[^>]+>/,'']
    ]

    @espetaculos.each_with_index do |e,i|
      replace_nome.each {|replacement| e.espetaculo.gsub!(replacement[0], replacement[1])}
      e.sinopse = e.sinopse.gsub(/[\x80-\xff]/,'')
      e.sinopse = e.sinopse.gsub(/[\x00-\x1F\x80-\x9F]/,'')
      e.sinopse = e.sinopse.gsub(/[\x00-\x08\x0B\x0C\x0E-\x1F\x80-\x9F]/,'')
      e.sinopse = Iconv.conv("ISO-8859-1//IGNORE", "UTF8//IGNORE", e.sinopse)
      e.sinopse = Iconv.conv("UTF-8//IGNORE", "ISO-8859-1", e.sinopse)
      e.sinopse = Hpricot.uxs(CGI.unescapeHTML(e.sinopse))
      #e.sinopse = e.sinopse.gsub(/[^[:print:]]/,'#')
      replace_sinopse.each {|replacement| e.sinopse.gsub!(replacement[0], replacement[1])}
      e.tinicio = "" if e.tinicio.blank?
      e.ttermino = "" if e.ttermino.blank?

      #@espetaculos[i].cidade.estado = Iconv.conv("WINDOWS-1252//IGNORE", "UTF-8", e.cidade.estado)
      #@espetaculos[i].cidade.nome = Iconv.conv("WINDOWS-1252//IGNORE", "UTF-8", e.cidade.nome)
      @espetaculos[i].teatron = Iconv.conv("WINDOWS-1252//IGNORE", "UTF-8", e.teatron)
      @espetaculos[i].espetaculo = Iconv.conv("WINDOWS-1252//IGNORE", "UTF-8", e.espetaculo)
      @espetaculos[i].generon = Iconv.conv("WINDOWS-1252//IGNORE", "UTF-8", e.generon)
      @espetaculos[i].tinicio = Iconv.conv("WINDOWS-1252//IGNORE", "UTF-8", e.tinicio)
      @espetaculos[i].ttermino = Iconv.conv("WINDOWS-1252//IGNORE", "UTF-8", e.ttermino)
      @espetaculos[i].sinopse = Iconv.conv("WINDOWS-1252//IGNORE", "UTF-8", e.sinopse)
    end

    respond_to do |format|
      format.csv do
        response.headers["Content-Type"] = "text/csv; header=present"
        response.headers["Content-Disposition"] = "attachment; filename=#{DateTime.now.strftime("%Y-%m-%d-%H-%M-espetaculos")}.csv"
      end
    end
  end
end