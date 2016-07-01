function CISlider(id, paramns){
    return new CISliderMain(id, paramns);
}

$.vmouse.moveDistanceThreshold = 10;
// $.vmouse.clickDistanceThreshold = 0.1;
// $.vmouse.resetTimerDuration = 10000;
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
    E.curPos            = null; //int, numero que representa o banner que esta sendo exibido atualmente
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
        eID: elementStrID,
        slideTo: 'left', //Sentido que o slider irá rodar string[left, right] "falta programar orientação vertical(top, bottom)"
        transition: { during: 'roll', onEnd: 'rollBack' }, //Forma de transição de um para outro banner | during[roll, static], onEnd[rollBack, static]
        auto: true, //automatico? [boolean]
        hasNavigate: true, //botões de navegação? [boolean]
        hasTitle: true, //exibir texto de descrição do banner, div.sliderTitulo obrigatória com a descrição [boolean]
        defaultTime: 1,
        cfgNavigate: {
            transition: 'roll', //[roll, static]
            position: 'center', //posição dos botões de navegação, por enquato, só existe center
        },
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
                    }else{
                        E.ul.removeAttribute('style');
                    }
                    
                    E.element.removeAttribute('style');
                }reset();
                E.init(newOpts, { resized: true });      
            })
        }

        function getSize(){
            var screenSize  =$(window).width();
            
            if (screenSize < 1024) 
            {
                var MOB = E.mobile;
                //E.cfgMobile();
                MOB.cfgTapHold();
            }

        }getSize();
    };


    E.mobCfgs = { prevPos: null, newPos: null }

    E.mobile = 
    {
        prevPos: null, 
        newPos: null,

        cfgTapHold: function()
        {
            var e = $(E.ul);
            $(e).on('vmousedown', function(){
                $this = $(this);
                //console.log('Wait...');
                clearTimeout(E.autoTime);

                $(e).on('vmousemove', function(e){
                    //console.log(e);
                    console.log('x:'+e.pageX);
                    MOB.freeMove(e.pageX);
                    //console.log('y:'+e.pageY);
                })

                $this.on('vmouseup', function(){
                    //console.log('Ok, lets go!');
                    E.__setTimeToMove();

                    $this.unbind('vmouseup');
                    $this.unbind('mousemove');
                })
            })
        },

        freeMove: function()
        {
            //var E = E.mobile
            if (MOB.prevPos == null) { MOB.prevPos = pos; return false; }

            if (MOB.options.slideTo == 'right') 
            {
                if (MOB.prevPos > pos) 
                { 
                    var resto = MOB.prevPos - pos;
                    console.log('>>>');
                    //E.ul.style.right = (parseInt(E.ul.style.right) + resto) + "px";
                    //E.ul.style.right = (parseInt(E.ul.style.right) + pos) + "px";
                }
                else
                {
                    var resto = MOB.prevPos + pos;
                    console.log('<<<');
                    //E.ul.style.right = (parseInt(E.ul.style.right) - resto) + "px";   
                }
            }
        }
    }

    E.freeMove = function(pos){
        if (E.mobCfgs.prevPos == null) { E.mobCfgs.prevPos = pos; return false; }

        if (E.options.slideTo == 'right') 
        {
            if (E.mobCfgs.prevPos > pos) 
            { 
                var resto = E.mobCfgs.prevPos - pos;

                console.log('>>>');
                E.ul.style.right = (parseInt(E.ul.style.right) + resto) + "px";
                //E.ul.style.right = (parseInt(E.ul.style.right) + pos) + "px";
            }
            else
            {
                var resto = E.mobCfgs.prevPos + pos;

                console.log('<<<');
                E.ul.style.right = (parseInt(E.ul.style.right) - resto) + "px";   
            }

        }
    }

    E.cfgUL = function ()
    {
        E.ul             = E.element.getElementsByTagName('ul')[0];              // UL principal do slider
        E.lis            = E.ul.getElementsByTagName('li');                      // Cada LI representa um banner que será exibido conforme animação
        E.bannersCount   = E.lis.length;                                         // Total de LIs
        E.width          = E.element.clientWidth;                                // Largura do container de exibição
        E.height         = E.element.clientHeight;                               // Altura do container de exibição
        E.fullWidth      = parseInt(E.element.clientWidth) * E.bannersCount;     // Largura total do slider ( width * bannersCount )

        switch(E.options.slideTo)
        {
            case 'left': case 'right':
                cfgHorizontal(E.options.slideTo);
                break;

            case 'top': case 'bottom':
                cfgVertical(E.options.slideTo);
                break;
        }

        function cfgVertical(orientation){
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
                var leng = E.lis.length;
                while(i < leng)
                {
                    var clone = E.lis[i].cloneNode(true);
                    var newpos = (leng-1) - i;
                    newlis[newpos] = clone;//E.lis[i];
                    i++;
                }

                //Inserir LIs com posições invertidas na UL para 
                E.ul.innerHTML = '';
                for (LI in newlis)
                {
                    E.ul.appendChild(newlis[LI]);
                }

                //Informar que as LIs ja foram revertidas, no caso de instanciar novamente o objeto não inverter de novo as LIS
                E.ul.setAttribute('data-reverted','true');
            }
            else if (orientation == 'left')
            {
               //Se for para esquerda, CFG DEFAULT 
            }

            //Configuração default para as LIs
            for(var i = 0; i< E.bannersCount; i++)
            {
                E.lis[i].style.width = E.width + 'px';
            }

            E.ul.style.width = E.fullWidth + 'px';
        }
    };

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
        if ( E.options.auto ) { E.__setTimeToMove(); }

    };

    E.__setCurNavBtn = function () 
    {
        E.curNavBtn.removeAttribute('data-activenav');
        E.curNavBtn = E.navBox.getElementsByTagName('div')[E.nextPos];
        E.curNavBtn.setAttribute('data-activenav','active');
    };

    E.move = function ()
    {
        E.validateCurAndNextPos();
        
        /* MOVER SLIDER */
        E.cfgPersonalizeSlider();
        if ( E.options.hasTitle )  { E.showTitle(); }
        if ( E.options.hasNavigate ) { E.__setCurNavBtn(); }
    };

    E.__setTimeToMove = function(){

        var time = E.lis[E.getRealPos()].getAttribute('data-showtime');
        if ( !time ) { time = parseInt(E.options.defaultTime); }

        E.autoTime = setTimeout( function () {
            
            E.move();
            E.curPos++;
            E.__setTimeToMove();

        }, time * 1000 )
        console.log('TO:'+E.autoTime);
    }

    E.fn = function()
    {
        E.move();
        E.curPos++;
        E.__setTimeToMove();
    }

    E.cfgPersonalizeSlider = function ()
    {
        if ( E.options.slideTo == 'right' ) 
        {
            if (E.nextPos == 0) 
            {
                pixelsNextPos = E.initialPosition;
            }
            else
            {
                pixelsNextPos = (E.initialPosition - (E.width * E.nextPos) );
            }
        }
        else if( E.options.slideTo == 'left' )
        {
            pixelsNextPos = ( E.nextPos * E.width ) * -1;
        }

        var orientation = E.options.slideTo;

        if (pixelsNextPos != 0 || pixelsNextPos != E.initialPosition )
        {
            if ( E.options.transition.during == 'roll' ){ eval( '$(E.ul).animate({ '+orientation+': (pixelsNextPos) });' ); }
            else if( E.options.transition.during == 'static' ){ E.ul.style[orientation] = (pixelsNextPos) + 'px'; }
        }
        else if (pixelsNextPos == 0 || pixelsNextPos == E.initialPosition )
        {
            if (E.options.transition.onEnd == 'rollBack') { eval( '$(E.ul).animate({ '+orientation+': (pixelsNextPos) });' ); }
            else if(E.options.transition.onEnd == 'static'){ E.ul.style[orientation] = (pixelsNextPos) + 'px'; }
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
        //Na inicialização do site é necessário obrigar a pegar o titulo na posição CURPOS e não NEXTPOS pois o slider 
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
        if ( (E.curPos) == realLeng )  { E.nextPos = 0; } 
        else { E.nextPos = (E.curPos + 1); }
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
                if ( E.options.auto )  { console.log('cleared'); clearTimeout(E.autoTime); }

                //armazenar informação anterior de transição de slider
                var beforeDuring = E.options.transition.during;
                //Verificar como é a transição ao clicar e atribuir
                E.options.transition.during = E.options.cfgNavigate.transition;
                
                E.curPos = i - 1;
                
                E.curNavBtn.removeAttribute('data-activenav');
                E.curNavBtn = this;
                E.curNavBtn.setAttribute('data-activenav','active');

                E.move();
                E.__setTimeToMove();

                //Voltar a transição padrão (sem click)
                E.options.transition.during = beforeDuring;
            }
        }

        E.element.appendChild(E.navBox);

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