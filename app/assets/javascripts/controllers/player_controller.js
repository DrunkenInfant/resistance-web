Resistance.PlayerController = Ember.ObjectController.extend({
  needs: ['games_show'],
  currentPlayer: Ember.computed.alias('controllers.games_show.currentPlayer'),
  actions: {
    select: function () {
      this.get('controllers.games_show').togglePlayerNominated(this.get('content'));
    }
  }
});
