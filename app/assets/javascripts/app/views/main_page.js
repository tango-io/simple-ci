simpleCI.Views.mainPage = Backbone.View.extend ({
  el: 'body',

  events: {
    'change input.github_url' : 'validateUrl',
    'click .glyphicon-remove' : 'renderHomePage'
  },

  initialize: function(){
  },

  validateUrl: function(e){
      var regex = new RegExp("(https://github.com)+(\/[a-zA-Z0-9\-_]+)+(\/[a-zA-Z0-9\-_]+)+$");
        if(regex.test(e.target.value)){
          $header = this.$el.find('header');
          scriptTemplate = _.template(JST['templates/script_template']());

          console.log("Successful match");

          this.switchToCIWork($header, e.target.value);
          this.hideMainPageElements()
      }else{
          console.log("No match");
      }
  },

  switchToCIWork: function(target, url){
    this.renderScriptTemplate(target);
    this.retrieveAppScript(url);
    this.renderAppScript(target);
  },

  renderScriptTemplate: function(target){
    target.addClass('red');
    target.find('input').replaceWith(scriptTemplate);
  },

  retrieveAppScript: function(url){
    this.scriptArea = new simpleCI.Views.scriptStage();
    this.scriptArea.fetchScript(url);
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
      $header = this.$el.find('header');
      homeTemplate = _.template(JST['templates/home_template']());
      $header.removeClass('red');
      this.hideScriptStage($header);
      this.showMainPageElements();
      this.restoreGithubURLInput($header);
  },

  restoreGithubURLInput: function(target){
      setTimeout(function(){
          target.find('.form-control').replaceWith(homeTemplate);
      }, 2000);
  }
})
