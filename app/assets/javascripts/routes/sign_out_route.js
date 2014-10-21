Resistance.SignOutRoute = Ember.Route.extend({
  beforeModel: function() {
    var self = this;
    var store = this.store;
    store.find('session', 'current').then(function (session) {
      session.destroyRecord().then(function () {
        store.find('session', 'current').then(function (session) {
          session.reload().then(function () {
            Resistance.csrfToken = session.get('csrfToken');
            self.controllerFor('application').set('currentUser', null);
            self.transitionTo('index');
          });
        });
      });
    });
  }
});
