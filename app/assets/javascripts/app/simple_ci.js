var simpleCI = {
  Views: {},
  initialize: function(){
    simpleCI.router = new simpleCI.Router();
    Backbone.history.start();
  }
}
