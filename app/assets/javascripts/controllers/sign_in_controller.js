Resistance.SignInController = Ember.Controller.extend({
  actions: {
    signIn: function () {
      return Ember.$.post(
        '/users/sign_in',
        {
          user: {
            email: this.get('email'),
            password: this.get('password')
          }
        },
        function (data) {
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
