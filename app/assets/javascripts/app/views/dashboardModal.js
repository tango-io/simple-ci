simpleCI.Views.dashboardModal = Backbone.View.extend({
  el: '#add-repos-modal',

  initialize: function(){
  },

  model: {},

  events: {
    'click .js-on.inactive'  : 'addRepo',
    'click .js-off.inactive' : 'removeRepo',
    'click #save'            : 'saveRepos'
  },

  addRepo: function(e){
    var parent = $(e.target).closest('tr');
    var name = parent.find('#name').text();
    var url = parent.find('#url').text();
    var id = parent.find('#id').text();

    this.model = { name: name, url: url, uid: id };

    var request = $.ajax({
      type: 'post',
      url: '/repositories.json',
      dataType: 'JSON',
      data: { repository: this.model }
    }), self = this;

    request.done(function(response){
      self.model = {};
      toggleButtons(parent, 'active', 'inactive');
    });

    request.error(function(response){
    });
  },

  removeRepo: function(e){
    var parent = $(e.target).closest('tr');
    var id = parent.find('#id').text();

    var request = $.ajax({
      type: 'delete',
      url: '/repositories/'+id+'.json',
    }), self = this;

    request.done(function(response){
      toggleButtons(parent, 'inactive', 'active');
    });

    request.error(function(response){
    });
  },

  saveRepos: function(){
    window.location.reload();
  }


});

function toggleButtons(parent, toggle1, toggle2){

  parent.find('.js-on').addClass(toggle1);
  parent.find('.js-on').removeClass(toggle2);

  parent.find('.js-off').addClass(toggle2);
  parent.find('.js-off').removeClass(toggle1);

}
