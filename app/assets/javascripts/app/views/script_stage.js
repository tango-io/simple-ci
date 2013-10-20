simpleCI.Views.scriptStage = Backbone.View.extend({
  el: 'header textarea',

  fetchScript: function(script){
    this.buildScript(script);
  },

  buildScript: function(responseArray){
    var script = "";

    _.each(responseArray, function(line){
      script = script + line + "\n";
    });

    $(this.$el).text(script)
  }
});
