simpleCI.Views.mainPage = Backbone.View.extend ({
  el: 'body',

  events: {
    'change .github_url' : 'validateUrl'
  },

  initialize: function(){
  },

  validateUrl: function(e){
      var regex = new RegExp("(https://github.com)\/([a-z0-9\-_])+\/[a-z0-9\-_]");
        if(regex.test(e.target.value)){
          console.log("Successful match");
          this.$el.find('header').addClass('red');
          this.$el.find('header .simple_ci_logo').attr('src', '/assets/logo-white.png')
      }else{
          console.log("No match");
      }
  }
})
