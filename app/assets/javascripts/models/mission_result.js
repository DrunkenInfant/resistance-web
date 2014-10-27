Resistance.MissionResult = DS.Model.extend({
  mission: DS.belongsTo('mission'),
  player: DS.belongsTo('player')
});
