Resistance.GamesRoute = Ember.Route.extend({
  model: function () {
    //return Ember.$.getJSON('/games/')
      //.then(function (games) {
        //return games['games'];
      //});
      return this.store.find('game', 1);
  }
});
