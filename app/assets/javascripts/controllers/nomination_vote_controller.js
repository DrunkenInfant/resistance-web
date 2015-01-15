Resistance.NominationVoteController = Ember.ObjectController.extend({
  needs: ['game'],
  currentPlayer: Ember.computed.alias('controllers.game.currentPlayer'),
  actions: {
    vote: function (pass) {
      this.store.createRecord('vote', {
        nomination: this.get('content'),
        pass: pass
      }).save();
      this.get('controllers.game.content').reload();
    }
  }
});
