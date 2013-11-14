simpleCI.Views.mainPage = Backbone.View.extend ({
  el: 'body',

  events: {
    'change input.github_url' : 'validateUrl',
    'click .remove-script'    : 'renderHomePage',
    'click .btn-run'          : 'renderRunScript',
    'click .remove-console'   : 'renderToScript'
  },

  model: {},

  initialize: function(){
    var sessionId = $('#session_id_').val()
    , self = this
    , client = new Faye.Client('http://localhost:9292/faye');

    client.subscribe("/" + sessionId, function(data){
      self.updateConsole(data)
    });
  },

  renderInlineSpan: function(criteria, content){
    var logEntry = "<span>" + content + "</span>"
      , target = $('.run span').last()

    if(target.text().match(criteria)){
      target.replaceWith($(logEntry));

    }else{
      $(logEntry).appendTo($('.run'));
    }

  },

  updateConsole: function(data){
    var helpers = {}, logEntry = "", self = this
    helpers['enter'] = '\n'

    if ($('.console > .run').length > 0) {
      if(data.log.match('Resolving') != null){
        self.renderInlineSpan('Resolving', data.log)

      }else if(data.log.match('Compressing') != null){
        self.renderInlineSpan('Compressing', data.log)

      }else if(data.log.match('Receiving') != null){
        self.renderInlineSpan('Receiving', data.log)

      }else if(data.log == '.' || data.log == '.\n' || data.log == 'E' || data.log == 'F' || data.log == '*' || data.log == 'S'){
        logEntry = "<span class='inline'>" + data.log + "</span>";
        $(logEntry).appendTo($('.run'));

      }else{
        logEntry = "<span>" + data.log + "</span>";
        $(logEntry).appendTo($('.run'));
      }

      $('.console > .run').scrollTop($('.run').prop('scrollHeight'));
    } else {
        if (data.log != helpers.enter){
            this.resumeCI();
        }
    }
  },

  resumeCI: function(){
    var $header = this.$el.find('header');
    $header.addClass('red');
    this.renderConsoleTemplate($header);
    this.hideScriptStage($header);
    this.renderConsoleTemplate($header);
    this.renderAppConsole($header);
    this.hideMainPageElements();
  },

  validateUrl: function(e){
    var regex = new RegExp("(https://github.com)+(\/[a-zA-Z0-9\-_]+)+(\/[a-zA-Z0-9\-_]+)+$");
    if(regex.test(e.target.value)){
      var $header = this.$el.find('header')
      this.model['github_url'] = e.target.value;
      this.switchToCIWork($header);
      this.hideMainPageElements()

    }else{
      this.$el.find('.github_url').val('')
                                  .attr('placeholder',' Please, provide a valid repo URL')
                                  .addClass('fail-icon')
    }
  },

  switchToCIWork: function(target){
    this.renderScriptTemplate(target);
    this.retrieveAppScript(target);
  },

  renderScriptTemplate: function(target){
    var scriptTemplate = _.template(JST['templates/script_template']());
    target.addClass('red');
    if ($('input').length > 0) {
      target.find('input').replaceWith(scriptTemplate);
    }else{
      target.find('.console').replaceWith(scriptTemplate);
    }
  },

  retrieveAppScript: function(target){
    this.scriptArea = new simpleCI.Views.scriptStage();

    var request = $.ajax({
      url: '/pages/verify_gemfile?repository=' + this.model.github_url,
      method: 'get'
    }), self = this;

    request.done(function(response){
      var $header = self.$el.find('header')
      self.model['script'] = response.script;
      self.renderAppScript($header);
      self.scriptArea.fetchScript(self.model.script);
    });

    request.error(function(response){
      self.$el.find('header').removeClass('red');
      self.showMainPageElements();
      self.scriptRetrievalError(self);
    });
  },

  scriptRetrievalError: function(self){
    var homeTemplate = _.template(JST['templates/home_template']());
    setTimeout(function(){
      self.$el.find('.form-control').replaceWith(homeTemplate);
      self.$el.find('.github_url').val('')
                                  .attr('placeholder',' Please, provide a valid repo url')
                                  .addclass('fail-icon')
    }, 2000);
  },

  renderAppScript: function(target){
    setTimeout(function(){
      target.find('div.form-control').addClass('script-stage');
    }, 0);
  },

  hideScriptStage: function(target){
    setTimeout(function(){
      target.find('div.form-control').removeClass('script-stage');
    },0);
  },

  hideMainPageElements: function(){
    this.$el.find('header p').slideUp('slow').hide('slow');
    this.$el.find('.text-url-github, .text-worker').hide('fast');
  },

  showMainPageElements: function(){
    this.$el.find('header p').slideDown('slow').show('slow');
    this.$el.find('.text-url-github, .text-worker').show('fast');
  },

  renderHomePage: function(){
    var $header = this.$el.find('header')
    $header.removeClass('red');
    this.hideScriptStage($header);
    this.showMainPageElements();
    this.restoreGithubURLInput($header);
  },

  restoreGithubURLInput: function(target){
    var homeTemplate = _.template(JST['templates/home_template']());
    setTimeout(function(){
      target.find('.form-control').replaceWith(homeTemplate);
    }, 2000);
  },

  renderRunScript: function(){
    var $header = this.$el.find('header');
    var $text = this.$el.find('textarea').val();

    this.model['script'] = [ $text ];

    var request = $.ajax({
      type: 'post',
      url: '/jobs',
      dataType: 'JSON',
      data: { job: this.model }
    }), self = this;

    request.done(function(response){
      self.hideScriptStage($header);
      self.renderConsoleTemplate($header);
      self.renderAppConsole($header);
    });

    request.error(function(response){
      var $header = self.$el.find('header')
      var homeTemplate = _.template(JST['templates/home_template']());
      $header.removeClass('red');
      self.hideScriptStage($header);
      self.showMainPageElements();

      setTimeout(function(){
        self.$el.find('.form-control').replaceWith(homeTemplate);
        self.$el.find('.github_url').val('')
                                    .attr('placeholder','Something went wrong, try again later')
                                    .addClass('fail-icon')
      }, 2000);
    });
  },

  renderAppConsole: function(target){
    setTimeout(function(){
      target.find('div.form-control').addClass('console');
    }, 0);
    $(".nano").nanoScroller();
  },

  renderConsoleTemplate: function(target){
    var consoleTemplate = _.template(JST['templates/console_template']());
    setTimeout(function(){
      target.find('.form-control').replaceWith(consoleTemplate);
    }, 1000);
  },

  renderToScript: function(){
    var $header = this.$el.find('header');
    this.renderScriptTemplate($header);
    this.retainConsoleBG($header);
    this.retrieveAppScript(this.model.github_url);
    this.fadeToScriptStage($header)
  },

  retainConsoleBG: function(target){
    target.find('div.form-control').addClass('script-stage').css('background', '#202020');
  },

  fadeToScriptStage: function(target){
    setTimeout(function(){
      target.find('.form-control').css({'background':'', 'transition':'.5s linear'})
    }, 200);
  },

})
