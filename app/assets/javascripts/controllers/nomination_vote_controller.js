Resistance.NominationVoteController = Ember.ObjectController.extend({
  needs: ['games_show'],
  currentPlayer: Ember.computed.alias('controllers.games_show.currentPlayer'),
  actions: {
    vote: function (pass) {
      this.store.createRecord('vote', {
        nomination: this.get('content'),
        pass: pass
      }).save();
    }
  }
});
