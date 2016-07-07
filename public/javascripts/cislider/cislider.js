function CISlider(id, paramns){
    return new CISliderMain(id, paramns);
}

$.vmouse.moveDistanceThreshold = 10;
$.vmouse.clickDistanceThreshold = 0.1;
$.vmouse.resetTimerDuration = 10000;
/**
 * Configura o slider com base na estrutura HTML do parent @param {string} elementStrID
 * @member E [object] Objeto que será retornado com todas as configurações do slider.
 * @param {string} elementStrID TESTE
 * @param {object} paramns  - Parametros de configuração JSObject
 */
function CISliderMain(elementStrID, newOpts)
{
    var E = this;

    //Elementos HTML
    E.element           = null; //DIV principal com overflow hidden
    E.titleDiv          = null; //DIV para exibir titulo do banner que é descrito em HTML
    E.navBox            = null; //DIV de container para os botões de navegação
    E.curNavBtn         = null; //Botão de navegação ativo
    E.curPos            = 0; //int, numero que representa o banner que esta sendo exibido atualmente
    E.nextPos           = 1;
    E.ul                = null; //UL principal do slider
    E.lis               = null; //Cada LI representa um banner que será exibido conforme animação

    //Informações para operações matemáticas
    E.bannersCount      = null; //Total de LIs
    E.width             = null; //Largura do container de exibição
    E.height            = null; //Altura do container de exibição
    E.fullWidth         = null; //Largura total do slider ( width * bannersCount )

    //outros
    E.initialPosition   = null; //No caso de orientação para a direita, a orientação muda de 0XP para o WIDTH do último banner
    E.autoTime          = null; //timeOut para mudar para o próximo slider

    //Default options
    E.options = {
        width: 1920,
        height: 370,
        eID: elementStrID,
        slideTo: 'left', //Sentido que o slider irá rodar string[left, right] "falta programar orientação vertical(top, bottom)"

        //Todo - transition - deixadoa epnas os default during[roll] e onEnd[continuous]
        transition: { during: 'roll', onEnd: 'continuous' }, //Forma de transição de um para outro banner | during[roll, static], onEnd[continuous, rollBack, static]
        
        auto: true, //automatico? [boolean]
        hasNavigate: true, //botões de navegação? [boolean]
        hasTitle: false, //exibir texto de descrição do banner, div.sliderTitulo obrigatória com a descrição [boolean]
        defaultTime: 1,
        cfgNavigate: {
            transition: 'roll', //[roll, static]
            position: 'center', //posição dos botões de navegação, por enquato, só existe center
        },
        transitionTime: 1500,
        teste: { status: false, msg: null }
    };

    /**
     * Configura o slider com base na estrutura HTML do parent @param {string} elementStrID
     * @constructor
     * @member element [HTMLObject]
     */
    E.init = function (newOpts, paramns)
    {
        if ( typeof paramns != 'object' ) { paramns = { resized: false } }

        E.setDefaultOptions(E.options, newOpts);
        E.element = document.getElementById(elementStrID);
        
        E.cfgUL();
        E.cfgParamns();

        //TODO - onde colocar as configs de tapHold para ao dar resize, não exibir as bolinhas? 
        //Se colocar depois de CFGUL e CFGPARAMS, tapHold não funciona por causa do bug do jqeury que duplica elementos

        function getSize(){
            var screenSize  =$(window).width();
            
            var MOB = E.mobile;
            if (screenSize < 1024) 
            {
                E.log('here!');
                E.hasNavigateBefore = E.options.hasNavigate;
                E.options.hasNavigate = false;
                //E.navBox.style.display="none";
                MOB.cfgTapHold();
            }
            else
            {
                E.options.hasNavigate = true; //TODO - pegar before, mas se não existir, pegar padrão
                //E.navBox.style.display="block";
                $(E.ul).unbind();
            }
        }getSize();

        //Se estiver efetuando o resize, não adicionar um novo evento para não duplicar
        if ( !paramns.resized )
        {
            window.addEventListener('resize', function(){
                function reset()
                {
                    clearTimeout(E.autoTime);

                    if (E.options.slideTo == 'right') 
                    {
                        E.ul.style.right = E.initialPosition + 'px';
                    }
                    else
                    {
                        E.ul.removeAttribute('style');
                    }
                    
                    E.element.removeAttribute('style');
                }reset();

                E.init(newOpts, { resized: true });      
            })
        }
    };


    E.mobCfgs = { prevPos: null, newPos: null }

    E.mobile = 
    {
        prevPos: null, 
        newPos: null,

        cfgTapHold: function()
        {
            E.log('cfgtaphold');
            MOB = E.mobile;
            var ul = $(E.ul);

            $(ul).on('vmousedown', function(){
                
                $this = $(this);
                clearTimeout(E.autoTime);

                $this.on('vmousemove', function(event){
                    E.freeMove(event.pageX);
                })

                $this.on('vmouseup', function(){
                    
                    var soltoem = parseInt(E.ul.style[E.options.slideTo]);
                    //converter posição para numero positivo. left sempre será negativo
                    if (E.options.slideTo == 'left') { soltoem = soltoem * -1; }

                    var idx = E.getRealPos(Math.round(soltoem / parseInt(E.width)));
                    
                    E.nextPos = idx;
                    E.curPos = (idx - 1 < 0) ? E.lis.length-1 : idx - 1;

                    E.options.transitionTime = 500;
                    E.move(true);
                    E.options.transitionTime = 1500;

                    MOB.prevPos = null;

                    if (E.options.auto) { E.__setTimeToMove(); }

                    $this.unbind('vmouseup');
                    $this.unbind('mousemove');
                })
            })
        },
    },

    //Movimentação com Touchscreen
        E.freeMove = function(pos)
        {
            if (MOB.prevPos == null) { MOB.prevPos = pos; return false; }

            velocidade = 6.5;

            if ( MOB.prevPos > pos ) 
            { 
                if (E.options.slideTo == 'right') 
                {
                    var moveTo = (parseInt(E.ul.style.right) + velocidade);
                    var ultimaPosicao = (E.fullWidth - E.width); //Largura total - largura de 1 banner
                    if ( moveTo >= ultimaPosicao ) { return false; }
                    MOB.prevPos = pos; //definir posição anterior como a posição atual da função
                }
                else if (E.options.slideTo == 'left') 
                {
                    var moveTo = (parseInt(E.ul.style.left) - velocidade);
                    var ultimaPosicao = (E.fullWidth - E.width) * -1; //Largura total - largura de 1 banner

                    if ( moveTo <= ultimaPosicao ) { return false; }
                    MOB.prevPos = pos;
                }
            }
            else if( MOB.prevPos < pos )
            {
                if (E.options.slideTo == 'right') 
                {
                    var moveTo = (parseInt(E.ul.style.right) - velocidade);
                    if ( moveTo <= 0 ) { return false; }
                    MOB.prevPos = pos;
                }
                else if (E.options.slideTo == 'left') 
                {
                    var moveTo = (parseInt(E.ul.style.left) + velocidade);
                    if ( moveTo >= 0 ) { return false; }
                    MOB.prevPos = pos; //definir posição anterior como a posição atual da função
                }
            }
            E.ul.style[E.options.slideTo] = moveTo + "px";   
        }

    E.cfgUL = function ()
    {
        //E.ul             = E.element.getElementsByTagName('ul')[0];        // UL principal do slider
        // E.lis            = E.ul.getElementsByTagName('li');                // Cada LI representa um banner que será exibido conforme animação
        
        E.ul             = $(E.element).find('> ul')[0];        // UL principal do slider
        E.lis            = $(E.ul).find('> li');;               // Cada LI representa um banner que será exibido conforme animação
        E.bannersCount   = E.lis.length;                        // Total de LIs
        E.width          = $(E.element).outerWidth();           // Largura do container de exibição
        //E.width          = E.options.width;

        /*
            TODO - Calcular o WIDTH conforme percentual ou numero informado para o width comum em desktop e não deixar via css.
            calcular height em percentual
        */
            E.percentW = E.options.width * 1920; //Pegar width em percentual - Percentual de laurgura do slider em relação a um montior
            E.percentH = (E.options.height / E.options.width); //Percentual do HEIGHT em relação ao width - para calcular height em mobile de todas as resoluções
            newheight         = E.width * E.percentH;
            E.element.style.height = Math.ceil(newheight) + 'px';
            E.height         = newheight;                     // Altura do container de exibição
        /*calcular height em percentual*/
        
        E.fullWidth      = $(E.element).outerWidth() * E.bannersCount;     // Largura total do slider ( width * bannersCount )
        switch(E.options.slideTo)
        {
            case 'left': case 'right':
                cfgHorizontal(E.options.slideTo);
                break;

            case 'top': case 'bottom':
                cfgVertical(E.options.slideTo);
                break;
        }

        function cfgVertical(orientation)
        {
            //TODO
        }

        function cfgHorizontal(orientation)
        {
            //Inverter LIS caso vá para a DIREITA
            if (orientation == 'right' && !E.ul.getAttribute('data-reverted'))
            {
                //Ler LIs e inverter posições para rodar para a direita. ou seja, a primeira LI deve ser a última.     
                var i = 0;
                var newlis = [];
                var leng = $(E.lis).length;
                while(i < leng)
                {
                    var clone = E.lis[i].cloneNode(true);
                    var newpos = (leng-1) - i;
                    newlis[newpos] = clone;//E.lis[i];
                    i++;
                }

                //Inserir LIs com posições invertidas na UL para 
                $(E.ul).html('');
                $(newlis).each(function(){
                    $(E.ul).append($(this));
                })

                E.lis = $(E.ul).find('> li');

                //Informar que as LIs ja foram revertidas, no caso de instanciar novamente o objeto não inverter de novo as LIS
                $(E.ul).attr('data-reverted','true');
            }
            else if (orientation == 'left')
            {
                //Se for para esquerda, CFG DEFAULT 
                $(E.ul).css('left', '0px');
            }

            $(E.lis).each(function(){
                $(this).width(E.width);

                //Se continer um mosaico, configurar...
                $(this).find('ul.mosaico').each(function(){
                    E.setMosaico($(this))
                })
            })

            $(E.ul).width(E.fullWidth);
        }
    };

    E.setMosaico = function(mosaico)
    {
        //var parent = $(mosaico).parent();
        //$(parent).attr('class', 'hasMosaico');
        //$(mosaico).find('li').first().attr('class','hasMosaico');
        
        //Por necessidade do ruby, a main LI deve vir dentro da UL do mosaico. Remover a primeira LI que será o banner principal 
        //e colocar o HTML dentro da LI principal
        
        var main = $(mosaico).find('li').first();
        $(main).remove();
        var parent = $(mosaico).parent();
        $(parent).attr('class', 'hasMosaico');
        $(main.html()).insertBefore(mosaico);
    }

    /**
     * @member paramns {object} - teste
     * @member paramns.hasTitle {boolean} - teste
     */
    E.cfgParamns = function ()
    {
        E.validateCurAndNextPos();
        if ( E.options.hasTitle ) { E.cfgImageTitle(); }

        if (E.options.slideTo == 'right') 
        {
            E.initialPosition = (E.fullWidth - E.lis[0].clientWidth);
            E.ul.style.right = E.initialPosition + 'px';
        }
        else if( E.options.slideTo == 'left' )
        {
            E.initialPosition = 0; //Default
        }

        if ( E.options.hasNavigate ) { E.cfgSliderNav(); } 
        else 
            { 
                if (E.navBox != null) 
                {
                    E.navBox.style.display = 'none'; 
                }
            }
        if ( E.options.auto ) { E.__setTimeToMove(); }

    };

    E.__setCurNavBtn = function () 
    {
        //TODO - no mobile, algumas vezes curNavBtn é undefined. verificar porque.
        if (E.curNavBtn != undefined) 
        {
            E.curNavBtn.removeAttribute('data-activenav');
            E.curNavBtn = E.navBox.getElementsByTagName('div')[E.nextPos];
            E.curNavBtn.setAttribute('data-activenav','active');
        }
    };

    E.move = function (prevent)
    {
        if (prevent == undefined) { prevent = false; }
        if (!prevent) { E.validateCurAndNextPos(); }
        
        /* MOVER SLIDER */
        E.cfgPersonalizeSlider(prevent);

        if ( E.options.hasTitle )  { E.showTitle(); }
        if ( E.options.hasNavigate ) { E.__setCurNavBtn(); }

        //Depois de mover e exibir tudo, aumentar posição atual;
        E.curPos++;
    };

    E.__setTimeToMove = function(){

        var time = E.lis[E.getRealPos()].getAttribute('data-showtime');
        if ( !time ) { time = parseInt(E.options.defaultTime); }

        clearTimeout(E.autoTime); //limapr qualquer timeout existente, evitar bugs

        E.autoTime = setTimeout( function () {
            
            E.move();
            E.__setTimeToMove();

        }, time * 1000 )
    }

    E.cfgPersonalizeSlider = function (manualScroll)
    {
        clearTimeout(E.autoTime);
        var options = {};

        var pixelsNextPos = ( E.nextPos * E.width ) * -1;
        if (E.options.slideTo == 'right') 
        {
            if (E.nextPos == 0) { pixelsNextPos = E.initialPosition; }
            else { pixelsNextPos = (E.initialPosition - (E.width * E.nextPos) ); }
        }

        options[E.options.slideTo] = pixelsNextPos;

        //Durante... Se o movimento vier de manualScroll (mobile), não executar continuous
        if (E.nextPos > 0 || manualScroll)
        {
            $(E.ul).animate(options, E.options.transitionTime);
        }
        //Do ultimo para o começo...
        else
        {
            continuous(E.options.slideTo);
        }


        function continuous(to)
        {
            if (to == 'right') 
            {
                var cloned = E.lis[E.lis.length-1].cloneNode(true); //Pegar a ultima LI, que na verdade é a primeira

                cloned.style.position = 'absolute';
                cloned.style.left = ($(cloned).outerWidth() * -1) + "px";
                E.ul.style.position = 'relative';

                E.ul.insertBefore(cloned,E.lis[0]);

                var pixelsNextPos = ( $(E.lis[0]).outerWidth() * -1 );
                
                $(E.ul).animate({ right: (pixelsNextPos) }, E.options.transitionTime, function(){

                    E.ul.style.right = E.initialPosition+'px';
                    cloned.parentNode.removeChild(cloned);
                });
            }
            else if(to == 'left')
            {
                var cloned = E.lis[0].cloneNode(true); //edited

                $(E.ul).append(cloned);
                $(E.ul).width( $(E.ul).find('> li').length * E.width ); //jquery bug - o $ cria outro elemento no seletor, por isso é necessário pegar de novo as LIs

                var pixelsNextPos = (parseInt(E.ul.style.width) - $(E.lis[0]).outerWidth() ) * -1;
                
                $(E.ul).animate({ left: (pixelsNextPos) }, E.options.transitionTime, function(){ //edited

                    E.ul.style.left = E.initialPosition+'px'; //edited
                    cloned.parentNode.removeChild(cloned);
                });
            }
        }
    };

    /*  
    * No caso de ir para a direita, o slider esta invertido, sendo a primeira LI exibia, como ultimo elemento da UL. Então neste caso, a posição
    * real do elemento atual é o inverso de sua posição atual
    *
    * Reference: posição real em relação a qual variável(curPos ou NextPos)? Default, nextPos
    * */
    E.getRealPos = function(reference)
    {
        if ( reference == undefined ) { reference = E.nextPos; }
        var realPos = reference;

        if ( E.options.slideTo == 'right' ) { realPos = (E.lis.length-1) - reference; }

        return realPos;
    };

    E.cfgImageTitle = function ()
    {
        E.titleDiv = document.createElement('div');
        E.titleDiv.setAttribute('class', 'imgTitle');

        E.element.appendChild(E.titleDiv);
        E.element.style.height = (E.height + E.titleDiv.clientHeight) + 'px';

        E.showTitle(true);
    };

    E.showTitle = function (init)
    {
        //Na inicialização do site é necessário obrigar a pegar o titulo na posição CURPOS e não NEXTPOS
        var ref = (init) ? E.curPos : undefined ;

        var curLI = E.lis[E.getRealPos(ref)].getElementsByClassName('sliderTitulo')[0];
        var txt = curLI.innerHTML;

        E.titleDiv.innerHTML = txt;
    };

    /*
    * Função que valida se a próxima LI para tentar pegar existe ou nao. Se não existir, voltar para ZERO
    * */
    E.validateCurAndNextPos = function ()
    {
        var realLeng = E.lis.length-1;

        if ( E.curPos == undefined || E.curPos > realLeng ) { E.curPos = 0; } //Definir inicial ou Zerar

        //Se estiver no ultimo, voltar para o primeiro
        if ( (E.curPos) == realLeng )  
        { 
            E.nextPos = 0; 
        }
        else 
        { 
            E.nextPos = (E.curPos + 1); 
        }
    };

    E.cfgSliderNav = function  ()
    {
        E.navBox = document.createElement('div');
        E.navBox.setAttribute('class', 'navBtn');

        for(var i = 0; i < E.bannersCount; i++)
        {
            var btn = document.createElement('div');
            cfgclick(btn, i);
            E.navBox.appendChild(btn);
        }

        function cfgclick (btn, i)
        {
            btn.onclick = function ()
            {
                if ( E.options.auto ) { clearTimeout(E.autoTime); }

                //armazenar informação anterior de transição de slider
                var beforeDuring = E.options.transition.during;
                //Verificar como é a transição ao clicar e atribuir
                E.options.transition.during = E.options.cfgNavigate.transition;
                
                E.curPos = i - 1;
                
                E.curNavBtn.removeAttribute('data-activenav');
                E.curNavBtn = this;
                E.curNavBtn.setAttribute('data-activenav','active');

                E.move();

                if (E.options.auto) 
                {
                    E.__setTimeToMove();
                }

                //Voltar a transição padrão (sem click)
                E.options.transition.during = beforeDuring;
            }
        }

        $(E.element).append(E.navBox);

        /*
        * Config position of nav menu
        * */

        if ( E.options.cfgNavigate.position == 'center' )
        {
            var centerPos = E.navBox.clientWidth / 2;
            E.navBox.style.left = '50%';
            E.navBox.style.marginLeft = (centerPos * -1) + 'px';
        }
        else if ( E.options.cfgNavigate.position == 'top_center' )  { /*TODO*/ }
        else if ( E.options.cfgNavigate.position == 'left' )        { /*TODO*/ }
        else if ( E.options.cfgNavigate.position == 'top_left' )    { /*TODO*/ }
        else if ( E.options.cfgNavigate.position == 'right' )       { /*TODO*/ }
        else if ( E.options.cfgNavigate.position == 'top_right' )   { /*TODO*/ }

        /* Cfg CSS botão ativo */
        E.curNavBtn = E.navBox.getElementsByTagName('div')[0];
        E.curNavBtn.setAttribute('data-activenav','active');
    };

    E.setDefaultOptions = function (initial, news)
    {
        if (typeof news != 'object') { news = {} };

        for(optName in initial)
        {
            if (news[optName] != undefined)
            {
                //null e undefined são entendidos como 'object pelo javascript', caso for um destes, converter para string
                if ( initial[optName] == null || initial[optName] == undefined ) { initial[optName] = '"'+initial[optName]+'"'; }

                if ( typeof initial[optName] == 'object' ) 
                {
                    E.setDefaultOptions(initial[optName], news[optName]);
                }
                else
                {
                    initial[optName] = news[optName];
                }
            }
        }
    },

    E.log = function(msg){
        if ( E.options.eID == 'mainSlider' ) 
        {
            console.log(msg);
        }
    },

    E.init(newOpts);
}