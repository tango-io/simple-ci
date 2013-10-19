simpleCI.Router = Backbone.Router.extend ({
  routes: {
    '' : 'mainPage'
  },

  mainPage: function(){
    this.workerStatus = new simpleCI.Views.workerStatus();
    this.mainView = new simpleCI.Views.mainPage();
  }
})
