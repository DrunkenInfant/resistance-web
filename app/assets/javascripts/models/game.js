Resistance.Game = DS.Model.extend({
  players: DS.hasMany('player'),
  missions: DS.hasMany('mission'),
  king: DS.belongsTo('player'),

  currentMission: function() {
    return this.get('missions').objectAt(0);
  }.property('missions'),

  state: function() {
    return this.get('currentMission').get('state');
  }.property('currentMission.state'),

  stateIsNominate: function () {
    return this.get('state') == 'nominate';
  }.property('state'),

  stateIsVote: function () {
    return this.get('state') == 'vote';
  }.property('state')
});
