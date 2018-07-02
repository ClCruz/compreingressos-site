module MultiHelper
    module_function

    def SizeOfMiniature
        #'160' #compreingressos

        '320' #ingressoslitoral
    end
    def getLogo
        #'../images/menu_logo.png' #compreingressos

        '../images/multi_litoralingressos/logo_header.png' #ingressoslitoral
    end
    def getFavico
        #'/favicon.ico' #compreingressos

        '/images/multi_litoralingressos/favicon.ico' #ingressoslitoral
    end
    def getTitulo
        #'COMPREINGRESSOS.COM - Gestão de bilheteria e venda de ingressos para teatros e casas de show' #compreingressos

        'INGRESSOSLITORAL.COM - Venda de ingressos para teatros e casas de show' #ingressoslitoral
    end
    def getName
        #'COMPREINGRESSOS.COM' #compreingressos

        'INGRESSOSLITORAL.COM' #ingressoslitoral
    end
    def getFacebook
        #'http://www.facebook.com/compreingressos' #compreingressos

        '' #ingressoslitoral
    end
    def getTwitter
        #'http://twitter.com/compreingressos' #compreingressos

        '' #ingressoslitoral
    end
    def getBlog
        #'http://blog.compreingressos.com/' #compreingressos

        '' #ingressoslitoral
    end
    def getInstagram
        #'https://www.instagram.com/compreingressos' #compreingressos

        '' #ingressoslitoral
    end
    def getYoutube
        #'https://www.youtube.com/compreingressos' #compreingressos

        '' #ingressoslitoral
    end
    def getGooglePlus
        #'https://plus.google.com/b/107039038797259256027/107039038797259256027' #compreingressos

        '' #ingressoslitoral
    end
    def getTomTicket
        #'https://compreingressos.tomticket.com/kb/' #compreingressos

        '' #ingressoslitoral
    end
    def getHasMidiaSocial
        getFacebook != '' && getTwitter != ''
    end
    
    #module_function :SizeOfMiniature :getLogo
end