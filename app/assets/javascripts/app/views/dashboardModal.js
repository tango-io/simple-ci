simpleCI.Views.dashboardModal = Backbone.View.extend({
  el: '#add-repos-modal',

  model: {},

  events: {
    'click .js-on.inactive'  : 'addRepo',
    'click .js-off.inactive' : 'removeRepo',
    'click #save'            : 'saveRepos',
  },

  addRepo: function(e){
    var parent = $(e.target).closest('tr');
    var name = parent.find('#name').text();
    var url = parent.find('#url').text();
    var id = parent.find('#id').text();

    this.model = { name: name, url: url, uid: id, activated: true };

    var request = $.ajax({
      type: 'post',
      url: '/repositories.json',
      dataType: 'JSON',
      data: { repository: this.model }
    }), self = this;

    request.done(function(response){
      self.toggleButtons(parent, 'active', 'inactive');
      var template = _.template($('#repo-template').html(),
                                ( {repo: self.model} ) );
                                $('.dashboard table tbody').append(template);
                                self.model = {};
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
      self.toggleButtons(parent, 'inactive', 'active');
      $('.dashboard table tbody').find('#'+id).remove();
    });

    request.error(function(response){
    });
  },

  toggleButtons: function(parent, toggle1, toggle2){
    parent.find('.js-on').addClass(toggle1);
    parent.find('.js-on').removeClass(toggle2);

    parent.find('.js-off').addClass(toggle2);
    parent.find('.js-off').removeClass(toggle1);
  }

});
