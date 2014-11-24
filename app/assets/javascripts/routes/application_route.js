Resistance.ApplicationRoute = Ember.Route.extend({
  beforeModel: function() {
    var route = this;
    var store = this.store;
    store.find('session', 'current').then(function (session) {
      Resistance.csrfToken = session.get('csrfToken');
      if (session.get('user')) {
        session.get('user').then(function (user) {
          route.controllerFor('application').set('currentUser', user);
        });
      }
    });
  },
  actions: {
    dev_login: function (id) {
      var route = this;
      var store = this.store;
      route.controllerFor('application').set('currentUser', null);
      store.find('session', 'current').then(function (session) {
        session.destroyRecord().then(function () {
          store.find('session', 'current').then(function (session) {
            Resistance.csrfToken = session.get('csrfToken');
            Ember.$.post('/sessions', { user: {
              email: 'test'+id+'@test.com',
              password: 'jagkan'
            }}).then(function (response) {
              session.reload().then(function () {
                Resistance.csrfToken = session.get('csrfToken');
                if (session.get('user')) {
                  session.get('user').then(function (user) {
                    route.controllerFor('application').set('currentUser', user);
                    route.controllerFor('game').get('model').reload();
                  });
                }
              });
            });
          });
        });
      });
    }
  }
});
