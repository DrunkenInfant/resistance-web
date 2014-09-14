
Resistance.Router.map( function () {
  this.route('index', { path: '/' });
  this.route('sign_in');
  this.route('sign_out');
  this.resource('games');
  this.resource('game', { path: '/game/:id' });
});
