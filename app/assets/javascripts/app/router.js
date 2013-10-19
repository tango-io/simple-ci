simpleCI.Router = Backbone.Router.extend ({
  routes: {
    '' : 'mainPage'
  },

  mainPage: function(){
    this.mainView = new simpleCI.Views.mainPage();
  }
})
