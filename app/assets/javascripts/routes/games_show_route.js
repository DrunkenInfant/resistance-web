Resistance.GamesShowRoute = Ember.Route.extend({
  model: function (params) {
    return this.store.find('game', params.id);
  }
});
