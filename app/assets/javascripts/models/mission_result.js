Resistance.MissionResult = DS.Model.extend({
  mission: DS.belongsTo('mission'),
  success: DS.attr(),
  player: DS.belongsTo('player')
});
