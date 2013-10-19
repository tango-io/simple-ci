simpleCI.Views.mainPage = Backbone.View.extend ({
  el: 'body',

  events: {
    'change .github_url' : 'validateUrl'
  },

  initialize: function(){
  },

  validateUrl: function(e){
    alert('working again :3');
    var regex=/^https:\/\/\w+([\.\-\w]+)?\.([a-z]{2,4}|travel)(:\d{2,5})?(\/.*)?$/i;
    return regex.test(url);
  }
})
