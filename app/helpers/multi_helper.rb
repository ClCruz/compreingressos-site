module MultiHelper
    module_function
    #@@site = "compreingressos"
    #@@site = "ingressoslitoral"
    @@site = "CIAdeingressos"

    def getSite
        @@site
    end
    def SizeOfMiniature
        case @@site
        when 'compreingressos'
            '160'
        when 'ingressoslitoral'
            '320'
        when 'CIAdeingressos'
            '320'
        end
    end
    def getLogo
        case @@site
        when 'compreingressos'
            '../images/menu_logo.png'
        when 'ingressoslitoral'
            '../images/multi_litoralingressos/logo_header.png'
        when 'CIAdeingressos'
            '../images/multi_ciadeingressos/logo_header.jpg'
        end
    end
    def getFavico
        case @@site
        when 'compreingressos'
            '/favicon.ico'
        when 'ingressoslitoral'
            '/images/multi_litoralingressos/favicon.ico'
        when 'CIAdeingressos'
            '/images/multi_ciadeingressos/favicon.ico'
        end
    end
    def getTitulo
        case @@site
        when 'compreingressos'
            'COMPREINGRESSOS.COM - Gestão de bilheteria e venda de ingressos para teatros e casas de show'
        when 'ingressoslitoral'
            'INGRESSOSLITORAL.COM - Venda de ingressos para teatros e casas de show'
        when 'CIAdeingressos'
            'CIADEINGRESSOS.COM - Venda de ingressos para teatros e casas de show'
        end
    end
    def getName
        case @@site
        when 'compreingressos'
            'COMPREINGRESSOS.COM'
        when 'ingressoslitoral'
            'INGRESSOSLITORAL.COM'
        when 'CIAdeingressos'
            'CIADEINGRESSOS.COM'
        end
    end
    def getFacebook
        case @@site
        when 'compreingressos'
            'http://www.facebook.com/compreingressos'
        when 'ingressoslitoral'
            ''
        end
    end
    def getTwitter
        case @@site
        when 'compreingressos'
            'http://twitter.com/compreingressos'
        when 'ingressoslitoral'
            ''
        end
    end
    def getBlog
        case @@site
        when 'compreingressos'
            'http://blog.compreingressos.com/'
        when 'ingressoslitoral'
            ''
        end
    end
    def getInstagram
        case @@site
        when 'compreingressos'
            'https://www.instagram.com/compreingressos'
        when 'ingressoslitoral'
            ''
        end
    end
    def getYoutube
        case @@site
        when 'compreingressos'
            'https://www.youtube.com/compreingressos'
        when 'ingressoslitoral'
            ''
        end
    end
    def getGooglePlus
        case @@site
        when 'compreingressos'
            'https://plus.google.com/b/107039038797259256027/107039038797259256027'
        when 'ingressoslitoral'
            ''
        end
    end
    def getTomTicket
        case @@site
        when 'compreingressos'
            'https://compreingressos.tomticket.com/kb/'
        when 'ingressoslitoral'
            ''
        end
    end
    def getHasMidiaSocial
        getFacebook != '' && getTwitter != ''
    end
    def getURICadastro
        case @@site
        when 'compreingressos'
            'https://compra.compreingressos.com/comprar/minha_conta.php'
        when 'ingressoslitoral'
            'https://compra.ingressoslitoral.com/comprar/minha_conta.php'
        when 'CIAdeingressos'
            'https://compra.ciadeingressos.com/comprar/minha_conta.php'
        end
    end
    def borderoWebURI
        case @@site
        when 'compreingressos'
            'https://compra.compreingressos.com/comprar/loginBordero.php?redirect=..%2Fadmin%2F%3Fp%3DrelatorioBordero'
        when 'ingressoslitoral'
            'https://compra.ingressoslitoral.com/comprar/loginBordero.php?redirect=..%2Fadmin%2F%3Fp%3DrelatorioBordero'
        when 'CIAdeingressos'
            'https://compra.ciadeingressos.com/comprar/loginBordero.php?redirect=..%2Fadmin%2F%3Fp%3DrelatorioBordero'
        end
    end
    def meiaEntradaURI
        case @@site
        when 'compreingressos'
            '/meia_entrada'
        when 'ingressoslitoral'
            '/meia-entrada-por-regiao'
        when 'CIAdeingressos'
            '/meia-entrada-por-regiao'
        end
    end

    def footerMenu (nome)
        case @@site
        when 'compreingressos'
            true
        when 'ingressoslitoral'
            case nome
            when 'SERVIÇOS'
                true
            when 'Captação de patrocínio'
                false
            when 'Catracas online e offline'
                false
            when 'Central de vendas'
                false
            when 'Credenciamento'
                true
            when 'Gestão de bilheteria'
                true
            when 'Ingressos'
                true
            when 'Vendas para grupos'
                false
            when 'Vendas pela internet'
                true
            when 'Vantagens do sistema'
                true
            when 'AJUDA'
                true
            when 'Borderô web'
                true
            when 'Institucional'
                false
            when 'Lei 6103/11'
                true
            when 'Perguntas frequentes'
                false
            when 'Política de venda'
                false
            when 'Privacidade'
                false
            when 'Política de Meia Entrada'
                true
            when 'Pontos de Venda'
                false
            when 'Política de Cancelamento'
                true
            end
        when 'CIAdeingressos'
            case nome
            when 'SERVIÇOS'
                true
            when 'Captação de patrocínio'
                false
            when 'Catracas online e offline'
                false
            when 'Central de vendas'
                false
            when 'Credenciamento'
                true
            when 'Gestão de bilheteria'
                true
            when 'Ingressos'
                true
            when 'Vendas para grupos'
                false
            when 'Vendas pela internet'
                true
            when 'Vantagens do sistema'
                true
            when 'AJUDA'
                true
            when 'Borderô web'
                true
            when 'Institucional'
                false
            when 'Lei 6103/11'
                true
            when 'Perguntas frequentes'
                false
            when 'Política de venda'
                false
            when 'Privacidade'
                false
            when 'Política de Meia Entrada'
                true
            when 'Pontos de Venda'
                false
            when 'Política de Cancelamento'
                true
            end
        end

    end
    
    #module_function :SizeOfMiniature :getLogo
end