simpleCI.Router = Backbone.Router.extend ({
  routes: {
    ''          : 'mainPage',
    'dashboard' : 'dashboardPage'
  },

  

  mainPage: function(){
    this.mainView = new simpleCI.Views.mainPage();
    this.workerStatus = new simpleCI.Views.workerStatus();
  },

  dashboardPage: function(){
    this.reposModal = new simpleCI.Views.dashboardModal();
  }

})
