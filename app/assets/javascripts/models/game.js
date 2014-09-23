Resistance.Game = DS.Model.extend({
  players: DS.hasMany('player'),
  missions: DS.hasMany('mission')
});
