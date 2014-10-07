Resistance.Game = DS.Model.extend({
  players: DS.hasMany('player'),
  missions: DS.hasMany('mission'),
  currentMission: function() {
    return this.get('missions').objectAt(0);
  }.property('missions')
});
