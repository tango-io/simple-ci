simpleCI.Views.mainPage = Backbone.View.extend ({
  el: 'body',

  events: {
    'change input.github_url' : 'validateUrl',
    'click .remove-script'    : 'renderHomePage',
    'click .btn-run'          : 'renderRunScript',
    'click .remove-console'   : 'renderToScript'
  },

  model: {},

  validateUrl: function(e){
    var regex = new RegExp("(https://github.com)+(\/[a-zA-Z0-9\-_]+)+(\/[a-zA-Z0-9\-_]+)+$");
    if(regex.test(e.target.value)){
      var $header = this.$el.find('header')
      this.model['github_url'] = e.target.value;
      this.switchToCIWork($header);
      this.hideMainPageElements()
    }else{
      // TODO Display an actual error in the UI
      console.log("No match");
    }
  },

  switchToCIWork: function(target){
    this.renderScriptTemplate(target);
    this.retrieveAppScript();
    this.renderAppScript(target);
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

  retrieveAppScript: function(){
    this.scriptArea = new simpleCI.Views.scriptStage();

    var request = $.ajax({
      url: '/pages/verify_gemfile?repository=' + this.model.github_url,
      method: 'get'
    }), self = this;

    request.done(function(response){
      self.model['script'] = response.script;
      self.scriptArea.fetchScript(self.model.script);
    });

    request.error(function(response){
      // TODO display an actual error
      console.log(response);
    });
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
      // TODO handle error somehow
    });
  },

  renderAppConsole: function(target){
    setTimeout(function(){
      target.find('div.form-control').addClass('console');
    }, 0);
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
