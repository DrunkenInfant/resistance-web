Resistance.MissionResultController = Ember.ObjectController.extend({
  needs: ['games_show'],
  currentPlayer: Ember.computed.alias('controllers.games_show.currentPlayer'),
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
