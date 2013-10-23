simpleCI.Router = Backbone.Router.extend ({
  routes: {
    ''          : 'mainPage',
    'dashboard' : 'dashboardPage'
  },

  mainPage: function(){
    console.log('Ola k ase')
    this.mainView = new simpleCI.Views.mainPage();
  },

  dashboardPage: function(){
    console.log('dashboard o k ase?');
  }
})
