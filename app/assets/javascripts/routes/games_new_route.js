Resistance.GamesNewRoute = Ember.Route.extend({
  model: function (params) {
      var game = this.store.createRecord('game');
      var user = this.controllerFor('application').get('currentUser');
      if (user) {
        game.get('users').addRecord(user);
      }
      return game;
  },
  setupController: function (controller, model) {
    this._super(controller, model);
    controller.set('allUsers', this.store.find('user'));
  }
});
