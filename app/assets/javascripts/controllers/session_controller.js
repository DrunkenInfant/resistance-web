Resistance.SessionController = Ember.Controller.extend({
  needs: ['application', 'socket'],
  currentUser: Ember.computed.alias('controllers.application.currentUser'),
  actions: {
    signIn: function () {
      this.signIn(this.get('email'), this.get('password'));
      this.clearForm();
    },
    signOut: function () {
      this.store.find('session', 'current').then(function (session) {
        session.destroyRecord().then(function () {
          this.store.find('session', 'current').then(function (session) {
            session.reload().then(function () {
              Resistance.csrfToken = session.get('csrfToken');
              this.get('controllers.application').set('currentUser', null);
              this.get('controllers.socket').setupSocket();
            }.bind(this));
          }.bind(this));
        }.bind(this));
      }.bind(this));
    },
    signUp: function () {
      this.store.createRecord('user', {
        email: this.get('email'),
        password: this.get('password'),
        password_confirmation: this.get('password_confirmation'),
      }).save().then(function (user) {
        this.signIn(this.get('email'),this.get('password'));
        this.clearForm();
      }.bind(this));
    }
  },
  clearForm: function () {
    this.set('email', '');
    this.set('password', '');
    this.set('password_confirmation', '');
  },
  signIn: function (email, password) {
    return Ember.$.post(
      '/sessions',
      {
        user: {
          email: email,
          password: password
        }
      }).then(function (data) {
        this.store.find('session', 'current').then(function (session) {
          session.reload().then(function () {
            Resistance.csrfToken = session.get('csrfToken');
            this.get('controllers.socket').setupSocket();
            session.get('user').then(function (user) {
              this.get('controllers.application').set('currentUser', user);
            }.bind(this));
          }.bind(this));
        }.bind(this));
      }.bind(this));
  }
});

