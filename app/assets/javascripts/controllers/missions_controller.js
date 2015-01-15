Resistance.MissionsController = Ember.ArrayController.extend({
  itemController: 'mission',
  needs: ['game'],
  currentMission: Ember.computed.alias('controllers.game.currentMission'),
  currentNomination: Ember.computed.alias('currentMission.currentNomination')
});
