simpleCI.Views.dashboardModal = Backbone.View.extend({
  el: '#add-repos-modal',

  events: {
    'click .js-on' : 'addRepo',
    'click .js-off' : 'removeRepo'
  },

  addRepo: function(e){
    console.log($(e.target));
  },

  removeRepo: function(e){
    console.log($(e.target));
  }
});
