Resistance.SessionController = Ember.Controller.extend({
  needs: ['application'],
  currentUser: Ember.computed.alias('controllers.application.currentUser'),
  actions: {
    signIn: function () {
      return Ember.$.post(
        '/sessions',
        {
          user: {
            email: this.get('email'),
            password: this.get('password')
          }
        }).then(function (data) {
          this.store.find('session', 'current').then(function (session) {
            session.reload().then(function () {
              Resistance.csrfToken = session.get('csrfToken');
              session.get('user').then(function (user) {
                this.get('controllers.application').set('currentUser', user);
              }.bind(this));
            }.bind(this));
          }.bind(this));
        }.bind(this));
    },
    signOut: function () {
      this.store.find('session', 'current').then(function (session) {
        session.destroyRecord().then(function () {
          this.store.find('session', 'current').then(function (session) {
            session.reload().then(function () {
              Resistance.csrfToken = session.get('csrfToken');
              this.get('controllers.application').set('currentUser', null);
            }.bind(this));
          }.bind(this));
        }.bind(this));
      }.bind(this));
    }
  }
});

