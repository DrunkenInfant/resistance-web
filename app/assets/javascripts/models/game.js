Resistance.Game = DS.Model.extend({
  players: DS.hasMany('player'),
  missions: DS.hasMany('mission'),
  king: DS.belongsTo('player'),

  currentMission: function() {
    return this.get('missions').findBy('isNotCompleted');
  }.property('missions.@each.isNotCompleted'),

  isFinished: function () {
    return this.get('missions').filterBy('hasSucceded').get('length') >= 3 || 
      this.get('missions').filterBy('hasFailed').get('length') >= 3
  }.property('missions.@each.isCompleted'),

  state: function() {
    if (this.get('isFinished')) {
      return 'finished';
    } else {
      return this.get('currentMission').get('state');
    }
  }.property('currentMission.state'),

  stateIsNominate: function () {
    return this.get('state') == 'nominate';
  }.property('state'),

  stateIsVote: function () {
    return this.get('state') == 'vote';
  }.property('state'),

  stateIsMission: function () {
    return this.get('state') == 'mission';
  }.property('state'),

  stateIsFinished: function () {
    return this.get('state') == 'finished';
  }.property('state')
});
