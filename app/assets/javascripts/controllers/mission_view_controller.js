Resistance.MissionViewController = Ember.Controller.extend({
  needs: ['game'],
  currentPlayer: Ember.computed.alias('controllers.game.currentPlayer'),
  actions: {
    success: function () {
      var ms = this.store.createRecord('missionResult', {
        mission: this.get('model.game.currentMission'),
        success: true
      });
      ms.save().then(
        function () {},
        function () { ms.deleteRecord(); }
      );
    },
    fail: function () {
      var ms = this.store.createRecord('missionResult', {
        mission: this.get('model.game.currentMission'),
        success: false
      });
      ms.save().then(
        function () {},
        function () { ms.deleteRecord(); }
      );
    }
  }
});
