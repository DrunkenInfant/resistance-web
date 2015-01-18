Resistance.GamesNewController = Ember.ObjectController.extend({
  actions: {
    select: function (user) {
      this.get('users').addRecord(user);
    },
    save: function () {
      this.get('content').save().then(function (game) {
        this.transitionToRoute('games.show', game);
      }.bind(this));
    }
  },

  availableUsers: function () {
    return this.get('allUsers').filter(function (user) {
      return !this.get('users').contains(user);
    }.bind(this));
  }.property('users.length', 'allUsers.length'),

  invalid: function () {
    return this.get('users.length') < 5 || this.get('users.length') > 10;
  }.property('users.length')
});
