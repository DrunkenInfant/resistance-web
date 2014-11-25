Resistance.GameController = Ember.Controller.extend({
  needs: ['application'],
  actions: {
    select: function (player) {
      if (this.get('model.stateIsNominate')) {
        var nom = this.get('model.currentMission.currentNomination');
        if (nom.get('players').contains(player)) {
          nom.get('players').removeObject(player);
        } else {
          nom.get('players').addRecord(player);
        }
      }
    },
    nominate: function () {
      this.get('model.currentMission.currentNomination').save();
    },
    vote: function (pass) {
      this.store.createRecord('vote', {
        nomination: this.get('model.currentMission.currentNomination'),
        pass: pass
      }).save();
      this.get('model').reload();
    },
    chooseMissionResult: function (success) {
      var ms = this.store.createRecord('missionResult', {
        mission: this.get('model.currentMission'),
        success: success
      });
      ms.save().then(
        function () {},
        function () { ms.deleteRecord(); }
      );
    }
  },
  currentPlayer: function () {
    return this.get('model.players').findBy('user',
      this.get('controllers.application.currentUser'));
  }.property('model.players.@each', 'controllers.application.currentUser'),
});
