simpleCI.Router = Backbone.Router.extend ({
  routes: {
    ''          : 'mainPage',
    'dashboard' : 'dashboardPage'
  },

  mainPage: function(){
    this.mainView = new simpleCI.Views.mainPage();
  },

  dashboardPage: function(){
  }
})
