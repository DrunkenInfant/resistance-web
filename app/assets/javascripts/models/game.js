Resistance.Game = DS.Model.extend({
  players: DS.hasMany('player'),
  missions: DS.hasMany('mission', { async: true }),
  king: DS.belongsTo('player'),
  users: DS.hasMany('user'),
  created_at: DS.attr(),

  currentMission: function() {
    return this.get('missions').findBy('isNotCompleted');
  }.property('missions.@each.isNotCompleted'),

  isFinished: function () {
    return this.get('missions').filterBy('hasSucceded').get('length') >= 3 || 
      this.get('missions').filterBy('hasFailed').get('length') >= 3
  }.property('missions.@each.isCompleted'),

  state: function() {
    if (this.get('isFinished')) {
      return 'game_over';
    } else if (this.get('currentMission')) {
      return this.get('currentMission').get('state');
    } else {
      return '';
    }
  }.property('currentMission.state'),

  stateIsNominate: function () {
    return this.get('state') == 'nomination_create';
  }.property('state'),

  stateIsVote: function () {
    return this.get('state') == 'nomination_vote';
  }.property('state'),

  stateIsMission: function () {
    return this.get('state') == 'mission_result';
  }.property('state'),

  stateIsFinished: function () {
    return this.get('state') == 'game_over';
  }.property('state')
});
