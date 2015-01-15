Resistance.NominationCreateController = Ember.ObjectController.extend({
  needs: ['game'],
  currentPlayer: Ember.computed.alias('controllers.game.currentPlayer'),
  king: Ember.computed.alias('controllers.game.content.king'),
  actions: {
    nominate: function (pass) {
      this.get('content').save();
    }
  }
});
