Resistance.MissionResult = DS.Model.extend({
  mission: DS.belongsTo('mission'),
  success: DS.attr()
});
