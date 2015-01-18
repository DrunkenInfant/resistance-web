Resistance.GamesShowController = Ember.ObjectController.extend({
  needs: ['application'],
  actions: {
    refresh: function () {
      this.get('content').reload();
    }
  },
  leftPlayers: function () {
    return this.get('players')
      .slice(this.get('players.length')/2, this.get('players.length'))
      .reverse();
  }.property('players.@each'),
  rightPlayers: function () {
    return this.get('players')
      .slice(0, this.get('players.length')/2);
  }.property('players.@each'),
  currentPlayer: function () {
    return this.get('players').findBy('user',
      this.get('controllers.application.currentUser'));
  }.property('players.@each', 'controllers.application.currentUser'),
  togglePlayerNominated: function (player) {
    if (this.get('stateIsNominate')) {
      var nom = this.get('currentMission.currentNomination');
      if (nom.get('players').contains(player)) {
        nom.get('players').removeObject(player);
      } else {
        nom.get('players').addRecord(player);
      }
    }
  },
});
