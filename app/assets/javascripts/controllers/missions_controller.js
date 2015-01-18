Resistance.MissionsController = Ember.ArrayController.extend({
  itemController: 'mission',
  needs: ['games_show'],
  currentMission: Ember.computed.alias('controllers.games_show.currentMission'),
  currentNomination: Ember.computed.alias('currentMission.currentNomination')
});
