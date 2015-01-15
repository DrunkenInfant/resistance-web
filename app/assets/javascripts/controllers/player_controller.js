Resistance.PlayerController = Ember.ObjectController.extend({
  needs: ['game'],
  currentPlayer: Ember.computed.alias('controllers.game.currentPlayer'),
  actions: {
    select: function () {
      this.get('controllers.game').togglePlayerNominated(this.get('content'));
    }
  }
});
