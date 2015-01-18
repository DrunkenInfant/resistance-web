Resistance.GamesIndexRoute = Ember.Route.extend({
  model: function () {
    return this.store.find('game');
  }
});
