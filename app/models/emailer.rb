class Emailer < ActionMailer::Base
  def contact(from, subject, message, name, sent_at = Time.now)
    @subject = subject # Titulo do email
    @recipients = 'sac@compreingressos.com' # Destino do email
    #@recipients = 'centraldevendas@compreingressos.com, clcruz@compreingressos.com, deon@compreingressos.com, sac@compreingressos.com' # Destino do email
    @from = from # origem do email
    @reply_to = from # Responder email para '''(Novidade do rails 2.1)'''
    @sent_on = sent_at # Data do email
    @message = message
	
    # Dados para a view
    @body["name"] = name
    @body["title"] = subject
    @body["email"] = from
    @body["message"] = message
    @headers = {}
  end

  def cadastro(params)
    @recipients = 'sac@compreingressos.com' # Destino do email
    #@recipients = 'operacional@compreingressos.com,suporte@compreingressos.com,centraldevendas@compreingressos.com'
    @params = params
    @from = "servidor@compreingressos.com"
    @subject = "Cadastro de #{params[:tipo]}"
    @sent_on = Time.now
  end

  def ocorrencia(ocorr)
    @ocorrencia = ocorr
    @recipients = @ocorrencia.email
    @from = "servidor@compreingressos.com"
    @subject = "COMPREINGRESSOS.COM - Ocorrencia número #{@ocorrencia.id}"
    @sent_on = Time.now
  end
  
end
