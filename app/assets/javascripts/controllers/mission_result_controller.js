Resistance.MissionResultController = Ember.ObjectController.extend({
  needs: ['game'],
  currentPlayer: Ember.computed.alias('controllers.game.currentPlayer'),
  actions: {
    chooseMissionResult: function (success) {
      var ms = this.store.createRecord('missionResult', {
        mission: this.get('content'),
        success: success
      });
      ms.save().then(
        function () {},
        function () { ms.deleteRecord(); }
      );
    }
  }
});
