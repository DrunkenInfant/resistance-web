Resistance.SignOutRoute = Ember.Route.extend({
  beforeModel: function() {
    var self = this;
    Ember.$.ajax({
      url: '/users/sign_out',
      type: 'DELETE',
      success: function(result) {
        self.transitionTo('index');
      }
    });
  }
});
