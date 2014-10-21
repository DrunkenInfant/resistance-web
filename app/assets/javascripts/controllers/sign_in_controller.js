Resistance.SignInController = Ember.Controller.extend({
  needs: ['application'],
  actions: {
    signIn: function () {
      var store = this.store;
      var self = this;
      return Ember.$.post(
        '/sessions',
        {
          user: {
            email: this.get('email'),
            password: this.get('password')
          }
        },
        function (data) {
          store.find('session', 'current').then(function (session) {
            session.reload().then(function () {
              Resistance.csrfToken = session.get('csrfToken');
              self.controllerFor('application').set('currentUser',
                session.get('user'));
            });
          });
          console.log('Signed in!');
          console.log(data);
        },
        'json'
      ).fail(function () {
        console.log('Sign in failed');
      });
    }
  }
});
