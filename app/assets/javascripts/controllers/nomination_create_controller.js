Resistance.NominationCreateController = Ember.ObjectController.extend({
  needs: ['games_show'],
  currentPlayer: Ember.computed.alias('controllers.games_show.currentPlayer'),
  king: Ember.computed.alias('controllers.games_show.content.king'),
  actions: {
    nominate: function (pass) {
      this.get('content').save();
    }
  }
});
