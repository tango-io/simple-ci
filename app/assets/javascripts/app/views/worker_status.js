simpleCI.Views.workerStatus = Backbone.View.extend({
  el: '.workers-status-box',
  
  initialize: function(){
    var self = this;
    setInterval(function(){
      self.updateStatus();
    }, 3000);
  },

  updateStatus: function(){
    var request = $.ajax({
      url: '/api/workers',
      method: 'get'
    }), self = this;

    request.done(function(response){
      self.updateStatusLabels(response);
    });

    request.error(function(response){
      console.log(response);
    });
  },

  updateStatusLabels: function(stats){
    var items = ['total', 'available', 'busy']
    , self =  this;

    _.each(items, function(item){
      self.$('.js-' + item).html(stats[item]);
    });
  }
});
