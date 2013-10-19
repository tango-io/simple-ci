simpleCI.Views.scriptStage = Backbone.View.extend({
  el: 'header textarea',

  fetchScript: function(target){
    var request = $.ajax({
      url: '/pages/verify_gemfile?repository=' + target,
      method: 'get'
    }), self = this;

    request.done(function(response){
      self.buildScript(response.script);
    });

    request.error(function(response){
      console.log(response);
    });
  },

  buildScript: function(responseArray){
    var script = "";

    _.each(responseArray, function(line){
      script = script + line + "\n";
    });

    $(this.$el).text(script)
  }
});
