var ciSlider2 = {

    sliders: {},

    setSlider: function (element, paramns)
    {
        if (typeof paramns != 'object')  { paramns = {}; }
        ciSlider.paramns = paramns;
        

        if ( typeof element == 'string')
        {
            var elementid = element.slice(1, (element.length));
            ciSlider.atual = eval('ciSlider.'+elementid+' = {};');
            ciSlider.atual.name = elementid;
            
            this.sliders = document.getElementById(elementid);
        }
        else if( typeof element == 'object' )
        {
            this.sliders = element;
            console.log('É objeto');
        }

        ciSlider.cfgULSliders();

        if ( ciSlider.paramns.auto == undefined ) { ciSlider.paramns.auto = true; }
        if ( ciSlider.paramns.auto ) { ciSlider.animate(0); }

        ciSlider.atual = ciSlider;

        return ciSlider.atual;
    },

    cfgULSliders: function ()
    {
        ul = this.sliders.getElementsByTagName('ul')[0];
        parent = ul.parentNode;

        ciSlider.ul = ul;

        cfgUL(parent, ul);

        function cfgUL(parent, ul)
        {
            var lis     = ul.getElementsByTagName('li');

            var h = parent.clientHeight;
            var w = parent.clientWidth;

            ciSlider.h = h;
            ciSlider.w = w;

            for(var i = 0; i< lis.length; i++)
            {
                lis[i].style.width      = w + 'px';
                lis[i].style.height     = h + 'px';
            }
            ul.style.height = h + 'px';

            if ( ciSlider.paramns.hasTitle == true )
            {
                ciSlider.cfgImageTitle(h, lis[0], parent);
            }

            if ( ciSlider.paramns.hasNavigate == true )
            {
                ciSlider.cfgSliderNav(lis.length, parent, ul);
            }

            var fullw = lis.length * parseInt(w);
            ul.style.width = fullw + 'px';
        }
    },
    
    cfgSliderNav: function (liLeng, parent, ul)
    {
        var mainDiv = document.createElement('div');
        mainDiv.setAttribute('class', 'navBtn');

        for(var i = 0; i < liLeng; i++)
        {
            var btn = document.createElement('div');
            cfgclick(btn, i);
            mainDiv.appendChild(btn);
        }

        function cfgclick (btn, i)
        {
            btn.onclick = function ()
            {
                ciSlider.navigateTo(this, i, ul);

                clearInterval(ciSlider.ntTime);
                clearInterval(ciSlider.anmTime);
                if ( ciSlider.paramns.auto ) { ciSlider.animate(i); }
            }
        }

        parent.appendChild(mainDiv);
    },

    cfgImageTitle: function (h, li, parent)
    {
        var mainDiv = document.createElement('div');
        mainDiv.setAttribute('class', 'imgTitle');

        mainDiv.innerHTML = li.getElementsByClassName('sliderTitulo')[0].innerHTML;
        parent.appendChild(mainDiv);
        parent.style.height = (h + mainDiv.clientHeight) + 'px';

        ciSlider.sliderTitle = mainDiv;
    },

    navigateTo: function (e, pos, ul)
    {
        ciSlider.active = pos;

        var liw = parseInt(ul.getElementsByTagName('li')[0].clientWidth);
        ul.style.left = (liw * pos)*-1 + 'px';

        if ( ciSlider.paramns.hasTitle == true )
        {
            var activeBanner = ul.getElementsByTagName('li')[pos];
            ciSlider.sliderTitle.innerHTML = activeBanner.getElementsByClassName('sliderTitulo')[0].innerHTML;
        }
    },

    animate: function (posAtual)
    {
        time = parseInt(ciSlider.ul.getElementsByTagName('li')[posAtual].getAttribute('data-showtime'));
        if ( time == undefined ) { time = 5; }
        time = time * 1000;

        var nextBanner = ciSlider.ul.getElementsByTagName('li')[posAtual + 1];
        if (nextBanner == undefined)  { posAtual = -1; }

        ciSlider.ntTime = setTimeout( function () {
            ciSlider.navigateTo(null, posAtual + 1, ciSlider.ul);
        }, time);

        ciSlider.anmTime = setTimeout( function(){
            ciSlider.animate(posAtual + 1, null)
        }, time);
    },

    setParamns: function (slider, opt)
    {
        for(optName in opt)
        {
            var value = eval('opt.'+optName);
            eval('slider.'+optName+' = '+value);
            if ( optName == 'auto' )
            {
                ciSlider.__setAuto(slider, value);
            }
        }
    },

    __setAuto: function (slider, value)
    {
        clearInterval(ciSlider.ntTime);
        clearInterval(ciSlider.anmTime);

        console.log('slider::>', slider );
        if ( value )
        {
            if ( slider.active == undefined ) { slider.active = 0; }
            ciSlider.animate(slider.active);
        }
    },

    cfgSlider: function (name)
    {
        ciSlider.atual = eval('ciSlider.'+name);
        console.log(ciSlider.atual);
    }
};

var CICTRL = {
    init: function (strID, paramns)
    {
        return new CISlider(strID, paramns)
    }
};

function CISlider(e, p) {
    elementCfg = this;

    this.setSlider = function (element, paramns)
    {
        if (typeof paramns != 'object')  { paramns = {}; }
        this.paramns = paramns;

        if ( typeof element == 'string')
        {
            var elementid = element.slice(1, (element.length));

            this.sliders = document.getElementById(elementid);
        }

        this.cfgULSliders();

        if ( paramns.auto == undefined ) { paramns.auto = true; }
        if ( paramns.auto ) { this.animate(0); }
    };

    this.cfgULSliders = function ()
    {
        this.ul = this.sliders.getElementsByTagName('ul')[0];
        this.parent = this.ul.parentNode;

        this.cfgUL = function()
        {
            var lis     = this.ul.getElementsByTagName('li');

            this.paramns.h = this.parent.clientHeight;
            this.paramns.w = this.parent.clientWidth;

            for(var i = 0; i< lis.length; i++)
            {
                lis[i].style.width      = elementCfg.paramns.w + 'px';
                lis[i].style.height     = elementCfg.paramns.h + 'px';
            }
            this.ul.style.height = this.paramns.h + 'px';

            if ( this.paramns.hasTitle == true )  { this.cfgImageTitle(this.paramns.h, lis[0], this.parent); }
            if ( this.paramns.hasNavigate == true )  { this.cfgSliderNav(lis.length, this.parent, this.ul); }

            var fullw = lis.length * parseInt(this.paramns.w);
            this.ul.style.width = fullw + 'px';
        };
        
        this.cfgUL();
    };

    this.cfgSliderNav = function  (liLeng, parent, ul)
    {
        var mainDiv = document.createElement('div');
        mainDiv.setAttribute('class', 'navBtn');

        for(var i = 0; i < liLeng; i++)
        {
            var btn = document.createElement('div');
            cfgclick(btn, i);
            mainDiv.appendChild(btn);
        }

        function cfgclick (btn, i)
        {
            btn.onclick = function ()
            {
                elementCfg.navigateTo(this, i, ul);

                clearInterval(this.ntTime);
                clearInterval(this.anmTime);
                if ( elementCfg.paramns.auto ) { elementCfg.animate(i); }
            }
        }

        parent.appendChild(mainDiv);
    };

    this.cfgImageTitle = function (h, li, parent)
    {
        var mainDiv = document.createElement('div');
        mainDiv.setAttribute('class', 'imgTitle');

        mainDiv.innerHTML = li.getElementsByClassName('sliderTitulo')[0].innerHTML;
        parent.appendChild(mainDiv);
        parent.style.height = (h + mainDiv.clientHeight) + 'px';

        this.sliderTitle = mainDiv;
    };

    this.navigateTo = function  (e, pos, ul)
    {
        this.active = pos;

        var liw = parseInt(ul.getElementsByTagName('li')[0].clientWidth);
        ul.style.left = (liw * pos)*-1 + 'px';

        if ( this.paramns.hasTitle == true )
        {
            var activeBanner = ul.getElementsByTagName('li')[pos];
            this.sliderTitle.innerHTML = activeBanner.getElementsByClassName('sliderTitulo')[0].innerHTML;
        }
    };

    this.animate = function (posAtual)
    {
        console.log(this);
        time = parseInt(this.ul.getElementsByTagName('li')[posAtual].getAttribute('data-showtime'));
        if ( time == undefined ) { time = 5; }
        time = time * 1000;

        var nextBanner = this.ul.getElementsByTagName('li')[posAtual + 1];
        if (nextBanner == undefined)  { posAtual = -1; }

        this.ntTime = setTimeout( function () {
            elementCfg.navigateTo(null, posAtual + 1, elementCfg.ul);
        }, time);

        this.anmTime = setTimeout( function(){
            elementCfg.animate(posAtual + 1, null)
        }, time);
    };

    this.setSlider(e, p);
}

var cnn = {
    init: function (strID)
    {
        return new ChangeNumbers(strID);
    }
};

function ChangeNumbers(strId)
{
    this.init = function (strId)
    {
        this.element = document.getElementById(strId);
        this.sum(this.element.innerHTML)
    };

    this.sum = function (n)
    {
        this.atual = n;
        this.novo = parseInt(n) + 1;
    };

    this.change = function ()
    {
        this.element.innerHTML = this.novo;
    }

    this.init(strId);
}