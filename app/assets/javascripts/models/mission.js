Resistance.Mission = DS.Model.extend({
  game: DS.belongsTo('game'),
  nbr_participants: DS.attr(),
  nbr_fails_required: DS.attr(),
  index: DS.attr(),
  nominations: DS.hasMany('nomination'),
  missionResults: DS.hasMany('missionResult'),

  isCurrent: function () {
    return this.get('game.currentMission') == this;
  }.property('game.currentMission'),

  isCompleted: function () {
    return this.get('missionResults.length') == this.get('nbr_participants');
  }.property('missionResults.length'),

  isNotCompleted: function () {
    return !this.get('isCompleted');
  }.property('isCompleted'),

  hasSucceded: function () {
    return this.get('isCompleted') &&
      this.get('missionResults').filterBy('success', false).get('length') <
        this.get('nbr_fails_required');
  }.property('isCompleted'),

  hasFailed: function () {
    return this.get('isCompleted') &&
      this.get('missionResults').filterBy('success', false).get('length') >=
        this.get('nbr_fails_required');
  }.property('isCompleted'),

  lastNomination: function () {
    var noms = this.get('nominations');
    var lastNom = null;
    if (noms.get('length') > 0) {
      lastNom = noms.objectAt(noms.get('length') - 1);
    }
    return lastNom;
  }.property('nominations.length'),

  currentNomination: function () {
    var lastNom = this.get('lastNomination');
    if (lastNom == null ||
        (!lastNom.get('isNew') && this.get('isNominating'))) {
      lastNom =  this.store.createRecord('nomination', {
        mission: this
      });
    }
    return lastNom;
  }.property('nominations.@each.isNew'),

  state: function () {
    if (this.get('isCompleted')) {
      return 'nomination_complete';
    }
    var lastNom = this.get('lastNomination');
    if (lastNom && lastNom.get('passed')) {
      return 'mission_result';
    } else if (lastNom && !lastNom.get('isNew') && lastNom.get('voteOngoing')) {
      return 'nomination_vote';
    } else {
      return 'nomination_create';
    }
  }.property('lastNomination.isNew', 'lastNomination.passed', 'lastNomination.voteOngoing'),
  isNominating: function () {
    return this.get('state') == 'nomination_create';
  }.property('state')
});
