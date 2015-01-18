
Resistance.Router.map( function () {
  this.route('index', { path: '/' });
  this.route('sign_in');
  this.route('sign_out');
  this.resource('games', function () {
    this.route('show', { path: '/:id' });
    this.route('new');
  });
});
